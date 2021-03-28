import { HttpClient, HttpErrorResponse } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { TokenService } from '../../admin-service/token/token.service';
import { AdminConfig } from '../../AdminConfig';
import { SupportInformationRequest } from '../entity/support-info-request';
import { SupportInformationRequestResponse } from '../entity/support-info-request-response';

@Injectable({
  providedIn: 'root'
})
export class SupportsService {

  constructor(private httpClient: HttpClient,
              private tokenService: TokenService) { }

  private static errorHandler(error: HttpErrorResponse) {
    return throwError(error || 'Server Error');
  }

  getSupportInformation(): Observable<SupportInformationRequestResponse> {
    return this.httpClient.get<SupportInformationRequestResponse>(
      AdminConfig.getSupportInfoAPI,
      this.tokenService.httpOptions()
    ).pipe(catchError(SupportsService.errorHandler));
  }

  updateSupportInformation(data): Observable<SupportInformationRequest> {
    return this.httpClient.put<SupportInformationRequest>(
      AdminConfig.supportInfoAPI,
      JSON.stringify(data),
      this.tokenService.httpOptions()
    ).pipe(catchError(SupportsService.errorHandler));
  }

  createSupportInformation(data): Observable<SupportInformationRequest> {
    return this.httpClient.post<SupportInformationRequest>(
      AdminConfig.supportInfoAPI,
      JSON.stringify(data),
      this.tokenService.httpOptions()
    ).pipe(catchError(SupportsService.errorHandler));
  }

}
