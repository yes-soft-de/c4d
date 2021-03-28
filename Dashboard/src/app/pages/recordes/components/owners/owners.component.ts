import { Component, EventEmitter, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { Subject } from 'rxjs';
import { AllOrdersResponse } from '../../entity/all-orders-response';
import { AllOwners } from '../../entity/all-owners';
import { AllOwnersResponse } from '../../entity/all-owners-response';
import { RecordesService } from '../../services/recordes.service';

@Component({
  selector: 'app-owners',
  templateUrl: './owners.component.html',
  styleUrls: ['./owners.component.scss']
})
export class OwnersComponent implements OnInit {
  private destroy$: Subject<void> = new Subject();
  getLogEvent: EventEmitter<string> = new EventEmitter();
  allOwners: AllOwners[];
  allOwnersList: AllOwners[] = [];
  config: any;
  orderID: string;

  constructor(private recordService: RecordesService,
              private toaster: ToastrService,
              private router: Router) {}

  ngOnInit() {
    this.recordService.allOwnersCaptains('owner').subscribe(
      (response: AllOwnersResponse) => {
        if (response) {
          console.log('All Owners : ', response);
          this.allOwners = response.Data;
          this.allOwnersList = response.Data.reverse();
        }
      },
      error => {
        console.log(error);
        if (error.error.status_code == 404) {
          this.toaster.error(error.error.msg);
          setTimeout(() => {
            this.router.navigate(['/']);
          }, 2000);
        }
      }, () => {
        this.config = {
          id: 'record-owners-pagination',
          itemsPerPage: 5,
          currentPage: 1,
          totalItems: this.allOwnersList.length
        };
      }
    );
  }

  ngOnDestroy() {
    this.destroy$.next();
    this.destroy$.complete();
  }


  getOrderLog(id: string) {
    if (id) {
      console.log('order id : ', id);
      this.orderID = id;
      this.getLogEvent.emit(id);
    }
  }

  pageChanged(event) {
    this.config.currentPage = event;
  }



}
