import { NgModule } from '@angular/core';
import { ThemeModule } from 'src/app/@theme/theme.module';

import { ContractsRoutingModule } from './contracts-routing.module';
import { PendingComponent } from './components/pending/pending.component';
import { ContractDetailsComponent } from './components/contract-details/contract-details.component';


@NgModule({
  declarations: [PendingComponent, ContractDetailsComponent],
  imports: [
    ThemeModule,
    ContractsRoutingModule
  ]
})
export class ContractsModule { }
