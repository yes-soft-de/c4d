import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { OrderDetailsComponent } from './components/order-details/order-details.component';
import { PendingComponent } from './components/pending/pending.component';


const routes: Routes = [
  { path: 'pending', component: PendingComponent },
  { path: 'view/:id', component: OrderDetailsComponent },
  { path: '', redirectTo: 'pending', pathMatch: 'full' }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class OrdersRoutingModule { }
