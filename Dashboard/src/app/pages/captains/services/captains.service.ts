import { HttpClient, HttpErrorResponse, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { TokenService } from '../../admin-service/token/token.service';
import { AdminConfig } from '../../AdminConfig';
import { CaptainsResponse } from '../entity/captains-response';

@Injectable({
  providedIn: 'root'
})
export class CaptainsService {

  constructor(
        private httpClient: HttpClient, 
        private tokenService: TokenService) {}

  private static errorHandle(error: HttpErrorResponse) {
    return throwError(error || 'Server Error');
  }

  // Get All Day Off Captains
  allDayOffCaptians(): Observable<CaptainsResponse> {    
    return this.httpClient.get<CaptainsResponse>(
      AdminConfig.dayOffCaptainsAPI, 
      this.tokenService.httpOptions()
      ).pipe(catchError(CaptainsService.errorHandle));
  }

  allPendingCaptains(userType: string): Observable<CaptainsResponse> {
    return this.httpClient.get<CaptainsResponse>(
      `${AdminConfig.pendingCaptainsAPI}/${userType}`,
      this.tokenService.httpOptions()
      ).pipe(catchError(CaptainsService.errorHandle));
  }

  allOngoingCaptains(state: string): Observable<CaptainsResponse> {
    return this.httpClient.get<CaptainsResponse>(
      `${AdminConfig.ongoingCaptainsAPI}/${state}`,
      this.tokenService.httpOptions()
      ).pipe(catchError(CaptainsService.errorHandle));
  }

  captainDetails(captainId: number): Observable<any> {
    return this.httpClient.get(
      `${AdminConfig.captainDetailAPI}/${captainId}`,
      this.tokenService.httpOptions()
    ).pipe(catchError(CaptainsService.errorHandle));
  }
}
