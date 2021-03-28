import { DatePipe } from '@angular/common';
import {ChangeDetectorRef, Component, EventEmitter, Input, OnInit} from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import {Observable, Subject, Subscription} from 'rxjs';
import {mergeMap, takeUntil, takeWhile} from 'rxjs/operators';
import { OrderLog } from '../../entity/order-log';
import { OrderLogRecords } from '../../entity/order-log-records';
import { OrderLogResponse } from '../../entity/order-log-response';
import { RecordesService } from '../../services/recordes.service';
import {ChangeDetection} from '@angular/cli/lib/config/schema';

@Component({
  selector: 'app-orders-log',
  templateUrl: './orders-log.component.html',
  styleUrls: ['./orders-log.component.scss'],
  providers: [DatePipe]
})
export class OrdersLogComponent implements OnInit {
  @Input() parentEvent!: EventEmitter<any>;
  @Input() parentOrderID!: string;
  private destroy$: Subject<void> = new Subject();
  allLogs: OrderLog;
  allLogsList: OrderLogRecords[] = [];
  allLogsListFilter: OrderLogRecords[] = [];
  orderID: string;
  name: string;

  constructor(private recordService: RecordesService,
              private toaster: ToastrService,
              private datePipe: DatePipe,
              private router: Router,) {
  }

  ngOnInit() {
    const orderId = this.parentOrderID;
    this.parentEvent.subscribe(id => {
      this.orderID = id;
      this.getOrdersLog(id);
      console.log('orderID : ', this.orderID);
    });
    if (!this.orderID) {
        console.log('orderId: ', orderId);
        this.getOrdersLog(orderId);
    }
  }

  getOrdersLog(orderId: string) {
     this.recordService.allRecordes(orderId)
        .subscribe(
          (response: OrderLogResponse) => {
            if (response) {
              this.allLogs = response.Data;
              this.allLogsList = response.Data.record;
            }
            console.log('orders Log : ', response.Data);
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
            this.orderID = orderId;
            this.allLogsListFilter = this.allLogsList;
          }
        );
  }

  ngOnDestroy() {
    this.destroy$.next();
    this.destroy$.complete();
  }


  // applyFilter() {
  //   // if the search input value is empty
  //   if (!this.name) {
  //     this.allLogsListFilter = [...this.allLogsList];
  //   } else {
  //     this.allLogsListFilter = [];
  //     this.allLogsListFilter = this.allLogsList.filter(res => {

  //       if (res.date) {
  //         const date = (this.datePipe.transform(new Date(res.date.timestamp * 1000), 'yyyy-MM-dd')).toString().match(this.name.toLocaleLowerCase());
  //         if (date) {
  //           return date;
  //         }
  //       }

  //       if (res.state) {
  //         const state = res.state.toLocaleLowerCase().match(this.name.toLocaleLowerCase());
  //         if (state) {
  //           return state;
  //         }
  //       }

  //       if (res.orderID) {
  //         const orderID = res.orderID.toLocaleLowerCase().match(this.name.toLocaleLowerCase());
  //         if (orderID) {
  //           return orderID;
  //         }
  //       }
  //     });
  //   }
  // }

}
