import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
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
    private orderService: OrdersService,
    private router: Router,
    private toaster: ToastrService
) { }

  ngOnInit() {
    this.orderService.allPendingOrders()
      .pipe(takeUntil(this.destroy$))
      .subscribe(
        pendingOrders => {
          if (pendingOrders) {
            this.pendingOrders = pendingOrders.Data;
            this.pendingOrdersList = pendingOrders.Data.reverse();
          }
          console.log(pendingOrders);
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
