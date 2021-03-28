import { NgModule } from '@angular/core';
import { ThemeModule } from 'src/app/@theme/theme.module';

import { CaptainsRoutingModule } from './captains-routing.module';
import { OngoingComponent } from './components/ongoing/ongoing.component';
import { PendingComponent } from './components/pending/pending.component';
import { DayOffComponent } from './components/day-off/day-off.component';
import { CaptainsDetailsComponent } from './components/captains-details/captains-details.component';
import { AllCaptainsComponent } from './components/all-captains/all-captains.component';
import { PaymentComponent } from './components/payment/payment.component';
import { RemainingCaptainsComponent } from './components/remaining-captains/remaining-captains.component';
import { TermsCaptainComponent } from './components/terms-captain/terms-captain.component';
import { AddTermComponent } from './components/terms-captain/add-term/add-term.component';
import { UpdateTermComponent } from './components/terms-captain/update-term/update-term.component';


@NgModule({
  declarations: [
    OngoingComponent, 
    PendingComponent, 
    DayOffComponent,
    AllCaptainsComponent, 
    CaptainsDetailsComponent, PaymentComponent, RemainingCaptainsComponent, TermsCaptainComponent, AddTermComponent, UpdateTermComponent
  ],
  imports: [
    ThemeModule,
    CaptainsRoutingModule
  ]
})
export class CaptainsModule { }
