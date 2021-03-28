import { NgModule } from '@angular/core';
import { ThemeModule } from 'src/app/@theme/theme.module';

import { SupportsRoutingModule } from './supports-routing.module';
import { AddSupportInfoComponent } from './components/add-support-info/add-support-info.component';


@NgModule({
  declarations: [AddSupportInfoComponent],
  imports: [
    ThemeModule,
    SupportsRoutingModule
  ]
})
export class SupportsModule { }
