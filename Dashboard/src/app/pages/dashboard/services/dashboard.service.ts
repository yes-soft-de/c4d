import { HttpClient, HttpErrorResponse } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { TokenService } from '../../admin-service/token/token.service';
import { AdminConfig } from '../../AdminConfig';
import { CaptainsDashboardResponse } from '../entity/captains-dashboard-response';
import { ContractsDashboardResponse } from '../entity/contracts-dashboard-response';
import { OrdersDashboardResponse } from '../entity/orders-dashboard-response';

@Injectable({
  providedIn: 'root'
})
export class DashboardService {

  constructor(private httpClient: HttpClient,
              private tokenServcie: TokenService) { }


  private static errorHandle(error: HttpErrorResponse) {
    return throwError(error || 'Server Error');
  }

  captainsDashboard(): Observable<CaptainsDashboardResponse> {
    return this.httpClient.get<CaptainsDashboardResponse>(
      AdminConfig.captainsDashboardAPI,
      this.tokenServcie.httpOptions()
    ).pipe(catchError(DashboardService.errorHandle));
  }

  ordersDashboard(): Observable<OrdersDashboardResponse> {
    return this.httpClient.get<OrdersDashboardResponse>(
      AdminConfig.ordersDashboardAPI,
      this.tokenServcie.httpOptions()
    ).pipe(catchError(DashboardService.errorHandle));
  }

  contractsDashboard(year: string, month: string): Observable<ContractsDashboardResponse> {
    return this.httpClient.get<ContractsDashboardResponse>(
      `${AdminConfig.contractsDashboardAPI}/${year}/${month}`,
      this.tokenServcie.httpOptions()
    ).pipe(catchError(DashboardService.errorHandle));
  }

}
