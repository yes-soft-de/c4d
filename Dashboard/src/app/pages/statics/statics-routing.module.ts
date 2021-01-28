import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { AllCaptainsComponent } from './components/all-captains/all-captains.component';
import { StaticDetailsComponent } from './components/static-details/static-details.component';
import { StoreOwnersComponent } from './components/store-owners/store-owners.component';
import { TopCaptainsStoreOwnersComponent } from './components/top-captains-store-owners/top-captains-store-owners.component';

const routes: Routes = [
  { path: '', component: TopCaptainsStoreOwnersComponent },
  { path: 'all-captains', component: AllCaptainsComponent },
  { path: 'store-owners', component: StoreOwnersComponent },
  { path: 'view/:user/:userId', component: StaticDetailsComponent },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class StaticsRoutingModule { }
