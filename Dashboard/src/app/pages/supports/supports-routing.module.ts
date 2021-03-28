import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { AddSupportInfoComponent } from './components/add-support-info/add-support-info.component';

const routes: Routes = [
  { path: '', component: AddSupportInfoComponent }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class SupportsRoutingModule { }
