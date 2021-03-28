import { Component, HostListener, Inject, Input, OnInit, Renderer2 } from '@angular/core';
import { Router } from '@angular/router';
import { TranslateService } from '@ngx-translate/core';
import { forkJoin, Observable } from 'rxjs';
import { takeUntil } from 'rxjs/operators';
import { AuthService } from 'src/app/pages/admin-service/auth/auth.service';
import { TokenService } from 'src/app/pages/admin-service/token/token.service';
import { DashboardService } from 'src/app/pages/dashboard/services/dashboard.service';
import { OrdersService } from 'src/app/pages/orders/services/orders.service';
import { SidebarMenuItems } from 'src/app/sidebar-menu';
import { LayoutService } from '../../helper/layout.service';
import { DatePipe, DOCUMENT } from '@angular/common';


@Component({
  selector: 'app-header',
  templateUrl: './header.component.html',
  styleUrls: ['./header.component.scss'],
  providers: [DatePipe]
})
export class HeaderComponent implements OnInit {

  @Input() menus: SidebarMenuItems[];
  loggedIn: boolean;
  orders: any[] = [];
  ordersListFilter: any[] = [];
  name: string;
  disabled = false;
  selectLang:string="";
  TransLang=[];

  constructor(private orderService: OrdersService,
              private dashboardService: DashboardService,
              private tokenService: TokenService, 
              private authService: AuthService,
              private layoutService: LayoutService,
              private translate: TranslateService,
              private router: Router,
              private datePipe: DatePipe,
              @Inject(DOCUMENT) private document: Document,
              private render: Renderer2) {
    translate.setDefaultLang('en');
    translate.addLangs(['en', 'ar']);
    this.selectLang = 'en';
    translate.use('en');
  }

  ngOnInit() {
    this.getTransLanguage();
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

  setTransLanguage() {
    console.log('set new language', this.selectLang);
    const htmlTag = this.document.querySelector('html') as HTMLElement;    
    const loaderIcon = this.document.querySelector('.lds-ring') as HTMLElement;    
    this.collapseMenu();
    if (this.selectLang == 'ar') {
      // set all project direction
      this.render.setStyle(htmlTag, 'direction', 'rtl');
      // set sidebar direction
      // this.render.setStyle(this.document.querySelector('.main-sidebar'), 'right', 'unset');
      // set sidebar button direction
      this.document.querySelectorAll('.btn.btn-link').forEach(e => {
        this.render.setStyle(e, 'text-align', 'right');
      });
      // set sidebar button icon direction
      this.document.querySelectorAll('.fa-custom').forEach(e => {
        this.render.setStyle(e, 'right', 'unset');
        this.render.setStyle(e, 'left', '10px');
      });
      // set sidebar form direction to ltr 
      this.render.setStyle(this.document.querySelector('.mobile-search-form'), 'direction', 'ltr');
      this.render.setStyle(this.document.querySelector('.input-group-prepend'), 'display', 'flex');
      this.render.addClass(this.document.querySelector('.input-group-text'), 'input-group-text-custom');
      // this.render.setStyle(this.document.querySelector('.search-result'), 'left', 'unset');
      // this.render.setStyle(this.document.querySelector('.search-result'), 'right', '-65vw');
      // change bootstrap link to bootstrap-rtl version link
      this.document.querySelectorAll('link').forEach((e, k, i) => {
        if (e.href.search('bootstrap.min.css') > 0) {
          e.href = 'assets/css/bootstrap-rtl.min.css';
          e.removeAttribute('integrity');
          e.removeAttribute('crossorigin');
        }
      });
    } else {
      this.render.setStyle(htmlTag, 'direction', 'ltr');
      // this.render.setStyle(this.document.querySelector('.main-sidebar'), 'right', '0');      
      // this.render.setStyle(this.document.querySelector('.search-result'), 'right', 'unset');
      // this.render.setStyle(this.document.querySelector('.search-result'), 'left', '-65vw');
      this.document.querySelectorAll('.btn.btn-link').forEach(e => {
        this.render.setStyle(e, 'text-align', 'left');
      });
      this.document.querySelectorAll('.fa-custom').forEach(e => {
        this.render.setStyle(e, 'right', '10px');
        this.render.setStyle(e, 'left', 'unset');
      });
      // this.render.setStyle(this.document.querySelector('.custom-search-form'), 'direction', 'ltr');
      this.render.removeClass(this.document.querySelector('.input-group-text'), 'input-group-text-custom');
      this.document.querySelectorAll('link').forEach((e, k, i) => {
        console.log(e.href);
        if (e.href.search('bootstrap-rtl.min.css') > 0) {
          e.href = 'https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css';
          e.setAttribute('integrity', 'sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm');
          e.setAttribute('crossorigin', 'anonymous');
        }
      });
    }
    this.translate.use(this.selectLang);
  }

  getTransLanguage(){
    this.TransLang = [...this.translate.getLangs()];
  }

  logout() {
    this.tokenService.deleteToken();
    this.authService.changeAuthStatus(false);
    this.router.navigate(['/login']);
  }

  clicked(value = null) {
    this.collapseMenu();
    if (value) {
      this.layoutService.changeLayout(value);
      this.router.navigate(['/']);
    }
  }

  select(id: number) {
    this.collapseMenu();
    this.disabled = false;
    // empty search input
    this.render.setProperty(this.document.getElementById('inlineFormInputGroupUsername2'), 'value', '');
    this.router.navigate(['/orders/view/', id]);
  }

  collapseMenu() {

    const screenWidth = window.innerWidth;
    console.log('screenWidth', screenWidth);
    if (screenWidth < 768) {
      setTimeout(() => {
        this.render.addClass(this.document.querySelector('.navbar-toggler'), 'collapsed');
        this.render.removeClass(this.document.getElementById('navbarSupportedContent'), 'show');
      }, 1000);
    }
  }

  @HostListener('document:keydown.escape', ['$event']) onKeydownHandler(event: KeyboardEvent) {
    this.disabled = false;
    this.render.setProperty(this.document.getElementById('inlineFormInputGroupUsername2'), 'value', '');
  }

  isTyping() {
    let wordSearch = this.name;
    setTimeout(() => {
      if (wordSearch == this.name) {
            if (this.name) {
              // If Stop Typing Cllapse Menu
              this.collapseMenu();
            }else{
                //code here
                console.log('still type');
            }
        }
    }, 1000);
  }

  applyFilter(event) {
    // Check IF user Still Typing
    this.isTyping();
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
