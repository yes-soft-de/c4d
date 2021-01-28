import { NgModule } from '@angular/core';
import { ThemeModule } from 'src/app/@theme/theme.module';

import { DatingRoutingModule } from './dating-routing.module';
import { AllDatingsComponent } from './components/all-datings/all-datings.component';


@NgModule({
  declarations: [AllDatingsComponent],
  imports: [
    ThemeModule,
    DatingRoutingModule
  ]
})
export class DatingModule { }
