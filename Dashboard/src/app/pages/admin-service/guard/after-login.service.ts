import { Route } from '@angular/compiler/src/core';
import { Injectable } from '@angular/core';
import { ActivatedRouteSnapshot, CanActivate, Router, RouterStateSnapshot } from '@angular/router';
import { Observable } from 'rxjs';
import { TokenService } from '../token/token.service';

@Injectable({
  providedIn: 'root'
})
export class AfterLoginService implements CanActivate {

  constructor(private tokenService: TokenService,
    private router: Router) { }

  canActivate(
    next: ActivatedRouteSnapshot,
    state: RouterStateSnapshot): Observable<boolean> | Promise<boolean> | boolean {
      let flag = this.tokenService.loggedIn();
      if(flag){
        return flag ;
      } else {
        this.router.navigate(['/login']);
        return;
      }
      return flag;
  }
}
