import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { AfterLoginService } from './pages/admin-service/guard/after-login.service';
import { BeforeLoginService } from './pages/admin-service/guard/before-login.service';


const routes: Routes = [
  {
    path: 'login',
    loadChildren: () => import('./pages/register/register.module').then(m => m.RegisterModule),
    // canActivate: [BeforeLoginService]
  },
  { 
    path: '', 
    loadChildren: () => import('./pages/pages.module').then(m => m.PagesModule),
    // canActivate: [AfterLoginService]
  },

];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
