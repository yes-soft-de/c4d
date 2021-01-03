import { NgModule } from '@angular/core';
import { ThemeModule } from 'src/app/@theme/theme.module';

import { PackagesRoutingModule } from './packages-routing.module';
import { ListPackagesComponent } from './components/list-packages/list-packages.component';
import { AddPackageComponent } from './components/add-package/add-package.component';
import { PackageDetailsComponent } from './components/package-details/package-details.component';


@NgModule({
  declarations: [ListPackagesComponent, AddPackageComponent, PackageDetailsComponent],
  imports: [
    ThemeModule,
    PackagesRoutingModule
  ]
})
export class PackagesModule { }
