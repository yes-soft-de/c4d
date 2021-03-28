import { Component, EventEmitter, Input, OnDestroy, OnInit, Output, ViewChild } from '@angular/core';
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
  getLogEvent: EventEmitter<string> = new EventEmitter();
  allOrders: any[];
  allOrdersList: any[] = [];
  orderID: string;
  config: any;
  name: string;

  constructor(private recordService: RecordesService,
              private toaster: ToastrService,
              private router: Router) {}

  ngOnInit() {
    this.getOrders();
  }

  getOrders() {
    this.recordService.allOrders().subscribe(
      (response: AllOrdersResponse) => {
        if (response) {
          console.log('All Orders : ', response);
          this.allOrders = response.Data;
          this.allOrdersList = response.Data.reverse();
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
          id: 'record-order-pagination',
          itemsPerPage: 5,
          currentPage: 1,
          totalItems: this.allOrdersList.length
        };
        console.log('order config : ', this.config);
      }
    );
  }

  ngOnDestroy() {
    this.destroy$.next();
    this.destroy$.complete();
  }


  pageChanged(event) {
    this.config.currentPage = event;
  }

  getOrderLog(id: string) {
    if (id) {
      console.log('order id : ', id);
      this.orderID = id;
      this.getLogEvent.emit(id);
      // this.getOrders();
    }
  }

  applyFilter() {
    this.allOrdersList = [];
    if (!this.name) {
      this.allOrdersList = [...this.allOrders];
    } else {
      this.allOrdersList = this.allOrders.filter(res => {
        if (res.userName) {
          const userName = res.userName.toLocaleLowerCase().match(this.name.toLocaleLowerCase());
          if (userName) {
            return userName;
          }
        }
        if (res?.acceptedOrder[0]?.captainName) {
          const captainName = res.acceptedOrder[0].captainName.toLocaleLowerCase().match(this.name.toLocaleLowerCase());
          if (captainName) {
            return captainName;
          }
        }
      })
    }
  }


}
