import { NgModule } from '@angular/core';
import { ThemeModule } from 'src/app/@theme/theme.module';

import { OrdersRoutingModule } from './orders-routing.module';
import { PendingComponent } from './components/pending/pending.component';
import { OrderDetailsComponent } from './components/order-details/order-details.component';


@NgModule({
  declarations: [PendingComponent, OrderDetailsComponent],
  imports: [
    ThemeModule,
    OrdersRoutingModule
  ]
})
export class OrdersModule { }
