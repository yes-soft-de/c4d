import { NgModule } from '@angular/core';
import { ThemeModule } from 'src/app/@theme/theme.module';

import { RecordesRoutingModule } from './recordes-routing.module';
import { OrdersComponent } from './components/orders/orders.component';
import { CaptainsComponent } from './components/captains/captains.component';
import { OwnersComponent } from './components/owners/owners.component';
import { OrdersLogComponent } from './components/orders-log/orders-log.component';


@NgModule({
  declarations: [OrdersComponent, CaptainsComponent, OwnersComponent, OrdersLogComponent],
  imports: [
    ThemeModule,
    RecordesRoutingModule
  ]
})
export class RecordesModule { }
