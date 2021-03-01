import { NgModule } from '@angular/core';
import { ThemeModule } from 'src/app/@theme/theme.module';

import { ContractsRoutingModule } from './contracts-routing.module';
import { AllOwnersComponent } from './components/all-owners/all-owners.component';
import { PendingComponent } from './components/pending/pending.component';
import { ContractDetailsComponent } from './components/contract-details/contract-details.component';
import { OwnerDetailsComponent } from './components/owner-details/owner-details.component';


@NgModule({
  declarations: [AllOwnersComponent, PendingComponent, ContractDetailsComponent, OwnerDetailsComponent],
  imports: [
    ThemeModule,
    ContractsRoutingModule
  ]
})
export class ContractsModule { }
