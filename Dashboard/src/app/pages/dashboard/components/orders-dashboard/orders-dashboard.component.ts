import { Component, OnDestroy, OnInit } from '@angular/core';
import { Subject } from 'rxjs';
import { takeUntil } from 'rxjs/operators';
import { CaptainsDashboardResponse } from '../../entity/captains-dashboard-response';
import { OrdersDashboardResponse } from '../../entity/orders-dashboard-response';
import { DashboardService } from '../../services/dashboard.service';

@Component({
  selector: 'app-orders-dashboard',
  templateUrl: './orders-dashboard.component.html',
  styleUrls: ['./orders-dashboard.component.scss']
})
export class OrdersDashboardComponent implements OnInit, OnDestroy {
  private destroy$: Subject<void> = new Subject<void>();
  countpendingOrders: number;
  countOngoingOrders: number;
  ordersCount: number;
  orders: any[] = [];
  latestOrdersNumber = 5;
  config: any;

  constructor(private dashboardService: DashboardService) { }

  ngOnInit() {
    this.dashboardService.ordersDashboard()
    .pipe(takeUntil(this.destroy$))
    .subscribe((ordersResponse: OrdersDashboardResponse) => {
      if (ordersResponse) {
        console.log('ordersResponse', ordersResponse);
        this.countpendingOrders = ordersResponse.Data[0].countpendingOrders;
        this.countOngoingOrders = ordersResponse.Data[1].countOngoingOrders;
        this.ordersCount = ordersResponse.Data[2].ordersCount;
        ordersResponse.Data.map((captians, index) => {          
          if (index >= 3) {
            this.orders.push(captians);
          }
        });
      }      
    }, error => console.log(error),
    () => {
      if (this.orders.length > 0 ) {
        this.config = {
          itemsPerPage: 5,
          currentPage: 1,
          totalItems: this.orders.length
        };
      }
    });
  }

  
  pageChanged(event) {
    this.config.currentPage = event;
  } 

  ngOnDestroy() {
    this.destroy$.next();
    this.destroy$.complete();
  }  

}
