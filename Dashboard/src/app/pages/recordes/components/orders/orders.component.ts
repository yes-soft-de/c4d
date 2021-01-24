import { Component, OnDestroy, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { Subject } from 'rxjs';
import { AllOrders } from '../../entity/all-orders';
import { AllOrdersResponse } from '../../entity/all-orders-response';
import { RecordesService } from '../../services/recordes.service';

@Component({
  selector: 'app-orders',
  templateUrl: './orders.component.html',
  styleUrls: ['./orders.component.scss']
})
export class OrdersComponent implements OnInit, OnDestroy {
  private destroy$: Subject<void> = new Subject();
  allOrders: AllOrders[];
  allOrdersList: AllOrders[] = [];
  config: any;

  constructor(private recordService: RecordesService,
              private toaster: ToastrService,
              private router: Router) {}

  ngOnInit() {
    this.recordService.allOrders().subscribe(
      (response: AllOrdersResponse) => {
        if (response) {
          console.log('All Orders : ', response);
          this.allOrders = response.Data;
          this.allOrdersList = response.Data;          
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
      }
    );
    this.config = {
      itemsPerPage: 5,
      currentPage: 1,
      totalItems: this.allOrdersList.length
    }
  }

  ngOnDestroy() {
    this.destroy$.next();
    this.destroy$.complete();
  }


  pageChanged(event) {
    this.config.currentPage = event;
  }



}
