import { DatePipe } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { Subject } from 'rxjs';
import { takeUntil } from 'rxjs/operators';
import { OrderLog } from '../../entity/order-log';
import { OrderLogResponse } from '../../entity/order-log-response';
import { RecordesService } from '../../services/recordes.service';

@Component({
  selector: 'app-orders-log',
  templateUrl: './orders-log.component.html',
  styleUrls: ['./orders-log.component.scss'],
  providers: [DatePipe]
})
export class OrdersLogComponent implements OnInit {
  private destroy$: Subject<void> = new Subject();
  allLogs: OrderLog[];
  allLogsList: OrderLog[] = [];
  allLogsListFilter: OrderLog[] = [];
  config: any;
  name: string;

  constructor(private recordService: RecordesService,
              private toaster: ToastrService,
              private datePipe: DatePipe,
              private router: Router,
              private activatedRoute: ActivatedRoute) {}

  ngOnInit() {
    this.recordService.allRecordes(this.activatedRoute.snapshot.paramMap.get('id'))
    .pipe(takeUntil(this.destroy$))
    .subscribe(
      (response : OrderLogResponse) => {
        if (response) {
          this.allLogs = response.Data;
          this.allLogsList = response.Data; 
        }
        console.log('orders Log : ', response);
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
        this.allLogsListFilter = this.allLogsList;
      }
    );
    
    this.config = {
      itemsPerPage: 5,
      currentPage: 1,
      totalItems: this.allLogsList.length
    }
  }

  ngOnDestroy() {
    this.destroy$.next();
    this.destroy$.complete();
  }


  pageChanged(event) {
    this.config.currentPage = event;
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
