import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { AddPackageComponent } from './components/add-package/add-package.component';
import { ListPackagesComponent } from './components/list-packages/list-packages.component';
import { PackageDetailsComponent } from './components/package-details/package-details.component';

const routes: Routes = [
  { path: '', component: ListPackagesComponent },
  { path: 'add', component: AddPackageComponent },
  { path: 'view/:id', component: PackageDetailsComponent }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class PackagesRoutingModule { }
