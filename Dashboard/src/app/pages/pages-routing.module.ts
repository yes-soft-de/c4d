import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { NotFoundComponent } from '../@theme/components';
import { AfterLoginService } from './admin-service/guard/after-login.service';
import { BeforeLoginService } from './admin-service/guard/before-login.service';
import { PagesComponent } from './pages.component';


const routes: Routes = [
  {
    path: '',
    component: PagesComponent,
    children: [
      {
        path: '',
        loadChildren: () => import('./dashboard/dashboard.module').then(m => m.DashboardModule),
        canActivate: [AfterLoginService]
      },
      {
        path: 'orders',
        loadChildren: () => import('./orders/orders.module').then(m => m.OrdersModule),
        canActivate: [AfterLoginService]
      },
      {
        path: 'captains',
        loadChildren: () => import('./captains/captains.module').then(m => m.CaptainsModule),
        canActivate: [AfterLoginService]
      },
      {
        path: 'contracts',
        loadChildren: () => import('./contracts/contracts.module').then(m => m.ContractsModule),
        canActivate: [AfterLoginService]
      },
      {
        path: 'chat',
        loadChildren: () => import('./messages/messages.module').then(m => m.MessagesModule),
        canActivate: [AfterLoginService]
      },
      {
        path: 'packages',
        loadChildren: () => import('./packages/packages.module').then(m => m.PackagesModule),
        canActivate: [AfterLoginService]
      },
      { path: '**', component: NotFoundComponent }
    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class PagesRoutingModule { }
