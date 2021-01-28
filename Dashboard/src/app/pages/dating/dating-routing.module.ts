import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { AllDatingsComponent } from './components/all-datings/all-datings.component';

const routes: Routes = [
  { path: '', component: AllDatingsComponent }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class DatingRoutingModule { }
