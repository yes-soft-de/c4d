import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, ParamMap } from '@angular/router';
import { Subject } from 'rxjs';
import { share, takeUntil } from 'rxjs/operators';
import { OrderDetails } from '../../entity/order-details';
import { OrderDetailsResponse } from '../../entity/order-details-response';
import { OrdersService } from '../../services/orders.service';
// import { google } from '@google/maps';

@Component({
  selector: 'app-order-details',
  templateUrl: './order-details.component.html',
  styleUrls: ['./order-details.component.scss']
})
export class OrderDetailsComponent implements OnInit {

  private destroy$: Subject<void> = new Subject<void>();
  orderDetails: OrderDetails;
  marker: any;

  constructor(private orderService: OrdersService,
              // private router: Router,/
              private activateRoute: ActivatedRoute) { }

  ngOnInit() {
   
    this.activateRoute.paramMap.subscribe((params: ParamMap) => {
      let id = parseInt(params.get('id'));
      console.log(params);
      this.orderService.orderDetails(id)
      .pipe(takeUntil(this.destroy$))
      .subscribe(
        (orderDetail: OrderDetailsResponse) => {
          if (orderDetail) {
            console.log('Order Details: ', orderDetail);
            this.orderDetails = orderDetail.Data;
          }
        },
        error => console.log('Error : ', error)
      );
    });

  }


}
