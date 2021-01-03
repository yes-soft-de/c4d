import { HttpClient, HttpErrorResponse } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { TokenService } from '../../admin-service/token/token.service';
import { AdminConfig } from '../../AdminConfig';
import { PackagesResponse } from '../entity/packages-response';

@Injectable({
  providedIn: 'root'
})
export class PackagesService {


  constructor(
    private httpClient: HttpClient, 
    private tokenService: TokenService) {}

  private static errorHandle(error: HttpErrorResponse) {
  return throwError(error || 'Server Error');
  }

  // Get All Packages
  allPackages(): Observable<PackagesResponse> {    
  return this.httpClient.get<PackagesResponse>(
    AdminConfig.allpackagesAPI, 
    this.tokenService.httpOptions()
    ).pipe(catchError(PackagesService.errorHandle));
  }


  // Get Package Details
  packageDetails(packageId: number): Observable<any> {
    return this.httpClient.get<any>(
      `${AdminConfig.packageDetailsAPI}/${packageId}`, 
      this.tokenService.httpOptions()
    ).pipe(catchError(PackagesService.errorHandle));
  }


  // Change Package State
  acceptPackage(data: any): Observable<any> {
    return this.httpClient.put<any>(
      AdminConfig.packageAcceptAPI,
      JSON.stringify(data),
      this.tokenService.httpOptions()
    ).pipe(catchError(PackagesService.errorHandle));
  }

  // Change Package State
  createPackage(data): Observable<any> {
    return this.httpClient.post<any>(
      AdminConfig.createPackageAPI,
      JSON.stringify(data),
      this.tokenService.httpOptions()
    ).pipe(catchError(PackagesService.errorHandle));
  }



}
