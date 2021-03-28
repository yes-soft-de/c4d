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
      {
        path: 'recordes',
        loadChildren: () => import('./recordes/recordes.module').then(m => m.RecordesModule),
        canActivate: [AfterLoginService]
      },
      {
        path: 'statistics',
        loadChildren: () => import('./statics/statics.module').then(m => m.StaticsModule),
        canActivate: [AfterLoginService]
      },
      {
        path: 'supports',
        loadChildren: () => import('./supports/supports.module').then(m => m.SupportsModule),
        canActivate: [AfterLoginService]
      },
      {
        path: 'reports',
        loadChildren: () => import('./reports/reports.module').then(m => m.ReportsModule),
        canActivate: [AfterLoginService]
      },
      {
        path: 'datings',
        loadChildren: () => import('./dating/dating.module').then(m => m.DatingModule),
        canActivate: [AfterLoginService]
      },
      {
        path: 'updated',
        loadChildren: () => import('./latest-updated/latest-updated.module').then(m => m.LatestUpdatedModule),
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
