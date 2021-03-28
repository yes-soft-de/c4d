import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { AllCaptainsComponent } from './components/all-captains/all-captains.component';
import { CaptainsDetailsComponent } from './components/captains-details/captains-details.component';
import { DayOffComponent } from './components/day-off/day-off.component';
import { OngoingComponent } from './components/ongoing/ongoing.component';
import { PaymentComponent } from './components/payment/payment.component';
import { PendingComponent } from './components/pending/pending.component';
import { RemainingCaptainsComponent } from './components/remaining-captains/remaining-captains.component';
import { AddTermComponent } from './components/terms-captain/add-term/add-term.component';
import { TermsCaptainComponent } from './components/terms-captain/terms-captain.component';
import { UpdateTermComponent } from './components/terms-captain/update-term/update-term.component';


const routes: Routes = [
  { path: '', component: AllCaptainsComponent },
  { path: 'ongoing', component: OngoingComponent },
  { path: 'pending', component: PendingComponent },
  { path: 'day-off', component: DayOffComponent },
  { path: 'view/:id', component: CaptainsDetailsComponent},
  { path: 'view/:dayOff/:id', component: CaptainsDetailsComponent},
  { path: 'payment', component: PaymentComponent},
  { path: 'remaining', component: RemainingCaptainsComponent},
  {
    path: 'terms',
    component: TermsCaptainComponent,
    children: [
      { path: 'add', component: AddTermComponent },
      { path: ':id', component: UpdateTermComponent }
    ]
  },
  { path: '', redirectTo: 'ongoing', pathMatch: 'full' }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class CaptainsRoutingModule { }
