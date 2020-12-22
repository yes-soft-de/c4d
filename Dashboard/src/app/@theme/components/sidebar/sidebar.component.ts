import { Component, Input, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { takeUntil } from 'rxjs/operators';
import { AuthService } from 'src/app/pages/admin-service/auth/auth.service';
import { TokenService } from 'src/app/pages/admin-service/token/token.service';
import { OrdersService } from 'src/app/pages/orders/services/orders.service';
import { SidebarMenuItems } from 'src/app/sidebar-menu';
import { LayoutService } from '../../helper/layout.service';

@Component({
  selector: 'app-sidebar',
  templateUrl: './sidebar.component.html',
  styleUrls: ['./sidebar.component.scss']
})
export class SidebarComponent implements OnInit {

  @Input() menus: SidebarMenuItems[];
  loggedIn: boolean;
  ordersListFilter: any[] = [];


  constructor(private orderService: OrdersService,
              private tokenService: TokenService, 
              private authService: AuthService,
              private layoutService: LayoutService,
              private router: Router) { }

  ngOnInit() {
    // this.orderService.allPendingOrders()
    // .subscribe(
    //   ordersResponse => {
        
    //   },
    //   error => console.log(error),
    //   () => {
    //     this.ordersListFilter = 
    //   }
    // );

    this.authService.authState.subscribe(
      loggedIn => this.loggedIn = loggedIn
    );
  }


  logout() {
    this.tokenService.deleteToken();
    this.authService.changeAuthStatus(false);
    this.router.navigate(['/login']);
  }


  clicked(value = null) {
    if (value) {
      this.layoutService.changeLayout(value);
      this.router.navigate(['/']);
    }
  }

}
