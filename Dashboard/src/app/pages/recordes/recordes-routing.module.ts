import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { CaptainsComponent } from './components/captains/captains.component';
import { OrdersLogComponent } from './components/orders-log/orders-log.component';
import { OrdersComponent } from './components/orders/orders.component';
import { OwnersComponent } from './components/owners/owners.component';

const routes: Routes = [
  { path: 'orders', component: OrdersComponent },
  { path: 'captains', component: CaptainsComponent },
  { path: 'owners', component: OwnersComponent }, 
  { path: 'orders-log/:id', component: OrdersLogComponent }, 
  { path: '', redirectTo: 'orders', pathMatch: 'full' }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class RecordesRoutingModule { }
