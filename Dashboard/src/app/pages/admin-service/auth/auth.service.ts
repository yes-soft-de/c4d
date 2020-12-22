import { Injectable } from '@angular/core';
import { TokenService } from '../token/token.service';
import { BehaviorSubject } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class AuthService {

  private loggedIn = new BehaviorSubject<boolean>(this.tokenService.loggedIn());
  authState = this.loggedIn.asObservable();

  constructor(private tokenService: TokenService) { }

  // change loggedIn value
  changeAuthStatus(value: boolean) {
    this.loggedIn.next(value);
  }


}
