import { NgModule } from '@angular/core';
import { ThemeModule } from 'src/app/@theme/theme.module';

import { CaptainsRoutingModule } from './captains-routing.module';
import { OngoingComponent } from './components/ongoing/ongoing.component';
import { PendingComponent } from './components/pending/pending.component';
import { DayOffComponent } from './components/day-off/day-off.component';
import { CaptainsComponent } from './captains.component';
import { CaptainsDetailsComponent } from './components/captains-details/captains-details.component';
import { AllCaptainsComponent } from './components/all-captains/all-captains.component';


@NgModule({
  declarations: [
    OngoingComponent, 
    PendingComponent, 
    DayOffComponent, 
    CaptainsComponent, 
    AllCaptainsComponent, 
    CaptainsDetailsComponent
  ],
  imports: [
    ThemeModule,
    CaptainsRoutingModule
  ]
})
export class CaptainsModule { }
