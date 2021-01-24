import { HttpClient, HttpErrorResponse } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { TokenService } from '../../admin-service/token/token.service';
import { AdminConfig } from '../../AdminConfig';
import { AllOrdersResponse } from '../entity/all-orders-response';

@Injectable({
  providedIn: 'root'
})
export class RecordesService {

  constructor(private httpClient: HttpClient,
              private tokenService: TokenService) { }

  private static errorHandler(error: HttpErrorResponse) {
    return throwError(error || 'Server Error');
  }

  allOrders(): Observable<AllOrdersResponse> {
    return this.httpClient.get<AllOrdersResponse>(
      AdminConfig.ordersAPI,
      this.tokenService.httpOptions()
    ).pipe(catchError(RecordesService.errorHandler));
  }

  allOwnersCaptains(userType: string): Observable<any> {
    return this.httpClient.get(
      `${AdminConfig.ownersCaptainsAPI}/${userType}`,
      this.tokenService.httpOptions()
    ).pipe(catchError(RecordesService.errorHandler));
  }

  allRecordes(orderId: string): Observable<any> {
    return this.httpClient.get(
      `${AdminConfig.recordsAPI}/${orderId}`,
      this.tokenService.httpOptions()
    ).pipe(catchError(RecordesService.errorHandler));
  }

}
