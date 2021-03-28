import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { LatestUpdatedComponent } from './components/latest-updated/latest-updated.component';
import {AddUpdateComponent} from './components/add-update/add-update.component';

const routes: Routes = [
  { path: '', component: LatestUpdatedComponent },
  { path: 'add', component: AddUpdateComponent }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class LatestUpdatedRoutingModule { }
