import { NgModule } from '@angular/core';
import { ThemeModule } from 'src/app/@theme/theme.module';

import { StaticsRoutingModule } from './statics-routing.module';
import { TopCaptainsStoreOwnersComponent } from './components/top-captains-store-owners/top-captains-store-owners.component';
import { TopOwnersComponent } from './components/top-captains-store-owners/top-owners/top-owners.component';
import { TopCaptainsComponent } from './components/top-captains-store-owners/top-captains/top-captains.component';
import { AllCaptainsComponent } from './components/all-captains/all-captains.component';
import { StoreOwnersComponent } from './components/store-owners/store-owners.component';
import { StaticDetailsComponent } from './components/static-details/static-details.component';


@NgModule({
  declarations: [
    TopCaptainsStoreOwnersComponent, 
    TopOwnersComponent, 
    TopCaptainsComponent, 
    AllCaptainsComponent, 
    StoreOwnersComponent, 
    StaticDetailsComponent
  ],
  imports: [
    ThemeModule,
    StaticsRoutingModule
  ]
})
export class StaticsModule { }
