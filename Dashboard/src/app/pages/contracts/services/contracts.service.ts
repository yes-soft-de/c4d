import { HttpClient, HttpErrorResponse } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, throwError } from 'rxjs';
import { catchError, map } from 'rxjs/operators';
import { TokenService } from '../../admin-service/token/token.service';
import { AdminConfig } from '../../AdminConfig';
import { ContractDetailsResponse } from '../entity/contract-details-response';
import { ContractsResponse } from '../entity/contracts-response';
import { AllOwnersResponse } from '../entity/all-owners-response';

@Injectable({
  providedIn: 'root'
})
export class ContractsService {


  constructor(
    private httpClient: HttpClient,
    private tokenService: TokenService) {}

  private static errorHandle(error: HttpErrorResponse) {
  return throwError(error || 'Server Error');
  }

  allUsers(userType: string): Observable<AllOwnersResponse> {
    return this.httpClient.get<AllOwnersResponse>(
      `${AdminConfig.allUsersAPI}/${userType}`,
      this.tokenService.httpOptions()
    ).pipe(catchError(ContractsService.errorHandle));
  }

  ownerDetails(ownerID): Observable<any> {
    return this.httpClient.get<any>(
      `${AdminConfig.ownerDetailsAPI}/${ownerID}`,
      this.tokenService.httpOptions()
    ).pipe(catchError(ContractsService.errorHandle));
  }

  // Get All Day Off Captains
  allPendingContracts(): Observable<ContractsResponse> {
    return this.httpClient.get<ContractsResponse>(
      AdminConfig.pendingContractsAPI,
      this.tokenService.httpOptions()
    ).pipe(catchError(ContractsService.errorHandle));
  }

  contractDetails(contractID: number): Observable<ContractDetailsResponse> {
    return this.httpClient.get<ContractDetailsResponse>(
      `${AdminConfig.contractDetailsAPI}/${contractID}`,
      this.tokenService.httpOptions()
    ).pipe(catchError(ContractsService.errorHandle));
  }

  contractAccept(data): Observable<any> {
    return this.httpClient.put<any>(
      AdminConfig.contractAcceptAPI,
      JSON.stringify(data),
      this.tokenService.httpOptions()
    ).pipe(catchError(ContractsService.errorHandle));
  }

  payment(data): Observable<any> {
    return this.httpClient.post(
      AdminConfig.paymentAPI,
      JSON.stringify(data),
      this.tokenService.httpOptions()
    ).pipe(catchError(ContractsService.errorHandle));
  }

  paymentsOfOwner(ownerID: string): Observable<any> {
    return this.httpClient.get<any>(
      `${AdminConfig.paymentOfOwnerAPI}/${ownerID}`,
      this.tokenService.httpOptions()
    ).pipe(catchError(ContractsService.errorHandle));
  }

}
