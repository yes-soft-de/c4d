import { Injectable } from '@angular/core';
import { ActivatedRouteSnapshot, CanActivate, Router, RouterStateSnapshot } from '@angular/router';
import { Observable } from 'rxjs';
import { AuthService } from '../auth/auth.service';
import {TokenService} from '../token/token.service';

@Injectable({
  providedIn: 'root'
})
export class BeforeLoginService implements CanActivate {

  constructor(private authService: AuthService, private tokenService: TokenService,
    private router: Router) { }

  canActivate(
    next: ActivatedRouteSnapshot,
    state: RouterStateSnapshot): Observable<boolean> | Promise<boolean> | boolean {
      return !this.tokenService.loggedIn(); 
  }
}
