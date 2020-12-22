import { NgModule } from '@angular/core';
import { ThemeModule } from 'src/app/@theme/theme.module';

import { DashboardRoutingModule } from './dashboard-routing.module';
import { DashboardComponent } from './dashboard.component';
import { CaptainsDashboardComponent } from './components/captains-dashboard/captains-dashboard.component';
import { OrdersDashboardComponent } from './components/orders-dashboard/orders-dashboard.component';
import { ContractsDashboardComponent } from './components/contracts-dashboard/contracts-dashboard.component';


@NgModule({
  declarations: [DashboardComponent, CaptainsDashboardComponent, OrdersDashboardComponent, ContractsDashboardComponent],
  imports: [
    ThemeModule,
    DashboardRoutingModule
  ]
})
export class DashboardModule { }
