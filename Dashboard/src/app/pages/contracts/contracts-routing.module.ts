import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { ContractDetailsComponent } from './components/contract-details/contract-details.component';
import { PendingComponent } from './components/pending/pending.component';
import {AllOwnersComponent} from './components/all-owners/all-owners.component';
import { OwnerDetailsComponent } from './components/owner-details/owner-details.component';
import {PaymentComponent} from './components/payment/payment.component';


const routes: Routes = [
  { path: '', component: AllOwnersComponent },
  { path: 'pending', component: PendingComponent },
  { path: 'view/:id', component: ContractDetailsComponent },
  { path: 'owner/:id', component: OwnerDetailsComponent },
  { path: 'payment', component: PaymentComponent },
  { path: '', redirectTo: 'pending', pathMatch: 'full' }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ContractsRoutingModule { }
