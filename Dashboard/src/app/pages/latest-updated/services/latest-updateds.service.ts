import { HttpClient, HttpErrorResponse } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { TokenService } from '../../admin-service/token/token.service';
import { AdminConfig } from '../../AdminConfig';
import { LatestUpdated } from '../entity/latest-updated';
import { LatestUpdatedResponse } from '../entity/latest-updated-response';

@Injectable({
  providedIn: 'root'
})
export class LatestUpdatedsService {


  constructor(private httpClient: HttpClient,
              private tokenService: TokenService) { }

  private static errorHandler(error: HttpErrorResponse) {
    return throwError(error || 'Server Error');
  }

  getLatestUpdated(): Observable<LatestUpdatedResponse> {
    return this.httpClient.get<LatestUpdatedResponse>(
      AdminConfig.getUpdatesAPI,
      this.tokenService.httpOptions()
    ).pipe(catchError(LatestUpdatedsService.errorHandler));
  }

  updateLatestUpdate(data): Observable<any> {
    return this.httpClient.put<any>(
      AdminConfig.updateAPI,
      JSON.stringify(data),
      this.tokenService.httpOptions()
    ).pipe(catchError(LatestUpdatedsService.errorHandler));
  }

  createLatestUpdate(data): Observable<LatestUpdated> {
    return this.httpClient.post<LatestUpdated>(
      AdminConfig.updateAPI,
      JSON.stringify(data),
      this.tokenService.httpOptions()
    ).pipe(catchError(LatestUpdatedsService.errorHandler));
  }

}
