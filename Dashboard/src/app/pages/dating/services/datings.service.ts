import { HttpClient, HttpErrorResponse, JsonpClientBackend } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { TokenService } from '../../admin-service/token/token.service';
import { AdminConfig } from '../../AdminConfig';
import { DatingsResponse } from '../entity/datings-response';

@Injectable({
  providedIn: 'root'
})
export class DatingsService {

  constructor(private httpClient: HttpClient,
    private tokenService: TokenService) { }

    
  private static errorHandler(error: HttpErrorResponse) {
    return throwError(error || 'Server Error');
  }


  allDatings(): Observable<DatingsResponse> {
    return this.httpClient.get<DatingsResponse>(
      AdminConfig.datingsAPI,
      this.tokenService.httpOptions()
    ).pipe(catchError(DatingsService.errorHandler));
  }

  datingIsDone(datingID: number, value: boolean): Observable<any> {
    return this.httpClient.put<any>(
      AdminConfig.datingAPI,
      JSON.stringify({id: datingID, isDone: value}),
      this.tokenService.httpOptions()
    ).pipe(catchError(DatingsService.errorHandler));
  }
}
