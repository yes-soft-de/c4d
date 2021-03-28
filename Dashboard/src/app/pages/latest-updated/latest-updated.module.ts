import { NgModule } from '@angular/core';
import { ThemeModule } from 'src/app/@theme/theme.module';

import { LatestUpdatedRoutingModule } from './latest-updated-routing.module';
import { LatestUpdatedComponent } from './components/latest-updated/latest-updated.component';
import { AddUpdateComponent } from './components/add-update/add-update.component';


@NgModule({
  declarations: [LatestUpdatedComponent, AddUpdateComponent],
  imports: [
    ThemeModule,
    LatestUpdatedRoutingModule
  ]
})
export class LatestUpdatedModule { }
