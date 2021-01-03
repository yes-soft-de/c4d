import { DatePipe } from '@angular/common';
import { Component, Input, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { forkJoin, Observable } from 'rxjs';
import { takeUntil } from 'rxjs/operators';
import { AuthService } from 'src/app/pages/admin-service/auth/auth.service';
import { TokenService } from 'src/app/pages/admin-service/token/token.service';
import { DashboardService } from 'src/app/pages/dashboard/services/dashboard.service';
import { OrdersService } from 'src/app/pages/orders/services/orders.service';
import { SidebarMenuItems } from 'src/app/sidebar-menu';
import { LayoutService } from '../../helper/layout.service';

@Component({
  selector: 'app-sidebar',
  templateUrl: './sidebar.component.html',
  styleUrls: ['./sidebar.component.scss'],
  providers: [DatePipe]
})
export class SidebarComponent implements OnInit {

  @Input() menus: SidebarMenuItems[];
  loggedIn: boolean;
  orders: any[] = [];
  ordersListFilter: any[] = [];
  name: string;
  disabled = false;


  constructor(private orderService: OrdersService,
              private dashboardService: DashboardService,
              private tokenService: TokenService, 
              private authService: AuthService,
              private layoutService: LayoutService,
              private router: Router,
              private datePipe: DatePipe) { }

  ngOnInit() {
    const orderDashboardObs: Observable<any> = this.dashboardService.ordersDashboard();
    const pendingOrderObs: Observable<any> = this. orderService.allPendingOrders();
    const joinObservable: Observable<any> = forkJoin([orderDashboardObs, pendingOrderObs]);
    joinObservable.subscribe(
      data => {
        data[0].Data.map((captians, index) => {          
          if (index >= 3) {
            this.orders.push(captians);
          }
        });
        data[1].Data.map((captians, index) => {          
          this.orders.push(captians);
          this.ordersListFilter = this.orders;
        });
        console.log('ordersListFilter', this.ordersListFilter);
      }, error => console.log(error)      
    );

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

  select(id: number) {
    this.disabled = false;
    this.router.navigate(['/orders/view/', id]);
  }

  applyFilter() {
    if (this.name == '') {
      this.disabled = false;
    } else {
      this.disabled = true;
    }
    // if the search input value is empty
    if (!this.name) {
      this.ordersListFilter = [...this.orders];
    } else {
      this.ordersListFilter = [];
      this.ordersListFilter = this.orders.filter(res => {
        if (res.orderDate) {
          const orderDate = (this.datePipe.transform(new Date(res.orderDate.timestamp * 1000), 'yyyy-MM-dd')).toString().match(this.name.toLocaleLowerCase());
          if (orderDate) {
            return orderDate;
          } 
        } 
        if (res.id) {
          const id = res.id.toString().match(this.name.toLocaleLowerCase());
          if (id) {
            return id;
          }
        }
         if (res.orderID) {
          const orderID = res.orderID.toString().match(this.name.toLocaleLowerCase());
          if (orderID) {
            // display the Name Column
            return orderID;
          } 
        }
         if (res.date) {
          const date = (this.datePipe.transform(new Date(res.date.timestamp * 1000), 'yyyy-MM-dd')).toString().match(this.name.toLocaleLowerCase());
          if (date) {
            return date;
          }
        }
        if (res.recipientName)  {
          const recipientName = res.recipientName.toLocaleLowerCase().match(this.name.toLocaleLowerCase());
          if (recipientName) {
            return recipientName;
          }
        }

      });
    }
  }

}
