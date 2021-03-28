import { Component, EventEmitter, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { Subject } from 'rxjs';
import { AllOwners } from '../../entity/all-owners';
import { AllOwnersResponse } from '../../entity/all-owners-response';
import { RecordesService } from '../../services/recordes.service';

@Component({
  selector: 'app-captains',
  templateUrl: './captains.component.html',
  styleUrls: ['./captains.component.scss']
})
export class CaptainsComponent implements OnInit {
  private destroy$: Subject<void> = new Subject();
  getLogEvent: EventEmitter<string> = new EventEmitter();
  allCaptains: AllOwners[];
  allCaptainsList: AllOwners[] = [];
  config: any;
  orderID: string;


  constructor(private recordService: RecordesService,
              private toaster: ToastrService,
              private router: Router) {}

  ngOnInit() {
    this.recordService.allOwnersCaptains('captain').subscribe(
      (response: AllOwnersResponse) => {
        if (response) {
          console.log('All Captains : ', response);
          this.allCaptains = response.Data;
          this.allCaptainsList = response.Data.reverse();
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
          id: 'record-captains-pagination',
          itemsPerPage: 5,
          currentPage: 1,
          totalItems: this.allCaptainsList.length
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
