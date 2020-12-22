import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Subject } from 'rxjs';
import { takeUntil } from 'rxjs/operators';
import { OrderDetails } from '../../entity/order-details';
import { OrderDetailsResponse } from '../../entity/order-details-response';
import { OrdersService } from '../../services/orders.service';

@Component({
  selector: 'app-order-details',
  templateUrl: './order-details.component.html',
  styleUrls: ['./order-details.component.scss']
})
export class OrderDetailsComponent implements OnInit {

  private destroy$: Subject<void> = new Subject<void>();
  orderDetails: OrderDetails;

  constructor(private orderService: OrdersService,
              // private router: Router,/
              private activateRoute: ActivatedRoute) { }

  ngOnInit() {
    console.log('detail', Number(this.activateRoute.snapshot.paramMap.get('id')));
    this.orderService.orderDetails(Number(this.activateRoute.snapshot.paramMap.get('id')))
      .pipe(takeUntil(this.destroy$))
      .subscribe(
        (orderDetail: OrderDetailsResponse) => {
          if (orderDetail) {
            console.log('ORder Details: ', orderDetail);
            this.orderDetails = orderDetail.Data;
          }
        },
        error => console.log('Error : ', error)
      );
  }


}
