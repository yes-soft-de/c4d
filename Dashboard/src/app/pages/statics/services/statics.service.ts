import { HttpClient, HttpErrorResponse } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { TokenService } from '../../admin-service/token/token.service';
import { AdminConfig } from '../../AdminConfig';
import { TopCaptiansResponse } from '../entity/top-captains-response';


@Injectable({
  providedIn: 'root'
})
export class StaticsService {

  constructor(private httpClient: HttpClient,
    private tokenService: TokenService) { }

    
  private static errorHandler(error: HttpErrorResponse) {
    return throwError(error || 'Server Error');
  }


  allTopOwners(): Observable<any> {
    return this.httpClient.get<any>(
      AdminConfig.topOwnersAPI,
      this.tokenService.httpOptions()
    ).pipe(catchError(StaticsService.errorHandler));
  }

  allTopCaptains(): Observable<TopCaptiansResponse> {
    return this.httpClient.get<TopCaptiansResponse>(
      AdminConfig.topCaptainsAPI,
      this.tokenService.httpOptions()
    ).pipe(catchError(StaticsService.errorHandler));
  }

  allUsers(userType: string): Observable<any> {
    return this.httpClient.get<any>(
      `${AdminConfig.allUsersAPI}/${userType}`,
      this.tokenService.httpOptions()
    ).pipe(catchError(StaticsService.errorHandler));
  }

  // getAllOrdersAndCount/{year}/{month}/{userId}/{userType}
  statisticDetails(year: string, month: string, userId: number, userType: string): Observable<any> {
    return this.httpClient.get<any>(
      `${AdminConfig.statisticDetailsAPI}/${year}/${month}/${userId}/${userType}`,
      this.tokenService.httpOptions()
    ).pipe(catchError(StaticsService.errorHandler));
  }

}
