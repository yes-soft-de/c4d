import { NgModule } from '@angular/core';
import { ThemeModule } from 'src/app/@theme/theme.module';
import { RegisterRoutingModule } from './register-routing.module';

import { LoginComponent } from './components/login/login.component';
import { RegisterComponent } from './register.component';

import { RegisterService } from './service/register.service';


@NgModule({
  declarations: [
    LoginComponent,
    RegisterComponent,
  ],
  imports: [
    RegisterRoutingModule,
    ThemeModule
  ],
  providers: [RegisterService]
})
export class RegisterModule { }
