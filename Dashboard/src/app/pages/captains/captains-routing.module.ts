import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { CaptainsDetailsComponent } from './components/captains-details/captains-details.component';
import { DayOffComponent } from './components/day-off/day-off.component';
import { OngoingComponent } from './components/ongoing/ongoing.component';
import { PendingComponent } from './components/pending/pending.component';


const routes: Routes = [
  { path: 'ongoing', component: OngoingComponent },
  { path: 'pending', component: PendingComponent },
  { path: 'day-off', component: DayOffComponent },
  { path: 'view/:id', component: CaptainsDetailsComponent},
  { path: '', redirectTo: 'ongoing', pathMatch: 'full' }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class CaptainsRoutingModule { }
