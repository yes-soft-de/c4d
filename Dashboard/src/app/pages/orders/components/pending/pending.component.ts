import { Component, OnInit } from '@angular/core';
import { Subject } from 'rxjs';
import { takeUntil } from 'rxjs/operators';
import { OrderDetails } from '../../entity/order-details';
import { Orders } from '../../entity/orders';
import { OrdersService } from '../../services/orders.service';

@Component({
  selector: 'app-pending',
  templateUrl: './pending.component.html',
  styleUrls: ['./pending.component.scss']
})
export class PendingComponent implements OnInit {
  private destroy$: Subject<void> = new Subject<void>();
  pendingOrders: OrderDetails[];
  pendingOrdersList: OrderDetails[] = [];
  config: any;

  constructor(
    private orderService: OrdersService
) { }

  ngOnInit() {
    this.orderService.allPendingOrders()
      .pipe(takeUntil(this.destroy$))
      .subscribe(
        pendingOrders => {
          if (pendingOrders) {
            this.pendingOrders = pendingOrders.Data;
            this.pendingOrdersList = pendingOrders.Data;
          }
          console.log(pendingOrders);
        },
        error => console.log('Error : ', error)
      );
      this.config = {
        itemsPerPage: 5,
        currentPage: 1,
        totalItems: this.pendingOrdersList.length
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
