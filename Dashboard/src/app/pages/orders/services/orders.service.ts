import { HttpClient, HttpErrorResponse } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { TokenService } from '../../admin-service/token/token.service';
import { AdminConfig } from '../../AdminConfig';
import { OrderDetailsResponse } from '../entity/order-details-response';
import { OrdersResponse } from '../entity/orders-response';

@Injectable({
  providedIn: 'root'
})
export class OrdersService {

  constructor(
    private httpClient: HttpClient, 
    private tokenService: TokenService) {}

  private static errorHandle(error: HttpErrorResponse) {
  return throwError(error || 'Server Error');
  }

  // Get All Day Off Captains
  allPendingOrders(): Observable<OrdersResponse> {    
  return this.httpClient.get<OrdersResponse>(
    AdminConfig.pendingOrdersAPI, 
    this.tokenService.httpOptions()
    ).pipe(catchError(OrdersService.errorHandle));
  }

  orderDetails(orderId: number): Observable<OrderDetailsResponse> {
    return this.httpClient.get<OrderDetailsResponse>(
      `${AdminConfig.orderDetailsAPI}/${orderId}`,
      this.tokenService.httpOptions()
    ).pipe(catchError(OrdersService.errorHandle));
  }


}
