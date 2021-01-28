import { NgModule } from '@angular/core';
import { ThemeModule } from 'src/app/@theme/theme.module';

import { ReportsRoutingModule } from './reports-routing.module';
import { AllReportsComponent } from './components/all-reports/all-reports.component';


@NgModule({
  declarations: [AllReportsComponent],
  imports: [
    ThemeModule,
    ReportsRoutingModule
  ]
})
export class ReportsModule { }
