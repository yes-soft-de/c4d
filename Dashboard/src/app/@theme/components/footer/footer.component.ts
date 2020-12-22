import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { AuthService } from 'src/app/pages/admin-service/auth/auth.service';
import { TokenService } from 'src/app/pages/admin-service/token/token.service';

@Component({
  selector: 'app-footer',
  templateUrl: './footer.component.html',
  styleUrls: ['./footer.component.scss']
})
export class FooterComponent implements OnInit {

  loggedIn: boolean;
  
  constructor(private tokenService: TokenService, 
              private authService: AuthService,
              private router: Router) { }

  ngOnInit(): void {
    this.authService.authState.subscribe(
      loggedIn => this.loggedIn = loggedIn
    );
  }

  logout() {
    this.tokenService.deleteToken();
    this.authService.changeAuthStatus(false);
    this.router.navigate(['/login']);
  }

}
