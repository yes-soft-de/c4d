import { HttpClient, HttpErrorResponse } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { TokenService } from '../../admin-service/token/token.service';
import { AdminConfig } from '../../AdminConfig';
import { ReportsResponse } from '../entity/reports-response';

@Injectable({
  providedIn: 'root'
})
export class ReportsService {

  constructor(private httpClient: HttpClient,
    private tokenService: TokenService) { }

    
  private static errorHandler(error: HttpErrorResponse) {
    return throwError(error || 'Server Error');
  }


  allReports(): Observable<ReportsResponse> {
    return this.httpClient.get<ReportsResponse>(
      AdminConfig.reportsAPI,
      this.tokenService.httpOptions()
    ).pipe(catchError(ReportsService.errorHandler));
  }
}
