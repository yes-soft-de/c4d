import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { ContractDetailsComponent } from './components/contract-details/contract-details.component';
import { PendingComponent } from './components/pending/pending.component';


const routes: Routes = [
  { path: 'pending', component: PendingComponent },
  { path: 'view/:id', component: ContractDetailsComponent },
  { path: '', redirectTo: 'pending', pathMatch: 'full' }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ContractsRoutingModule { }
