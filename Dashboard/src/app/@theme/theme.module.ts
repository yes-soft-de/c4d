import { ModuleWithProviders, NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { HttpClientModule } from '@angular/common/http';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { RouterModule } from '@angular/router';
import { NgxPaginationModule } from 'ngx-pagination';
import { TranslateModule } from '@ngx-translate/core';
import { GoogleChartsModule } from 'angular-google-charts';

import { SidebarComponent } from './components/sidebar/sidebar.component';
import { FooterComponent } from './components/footer/footer.component';
import { NotFoundComponent } from './components/not-found/not-found.component';
import { HeaderComponent } from './components/header/header.component';


const COMPONENTS = [
  SidebarComponent,
  FooterComponent,
  HeaderComponent
];


const MODULES = [
  CommonModule,
  HttpClientModule,
  FormsModule, 
  NgxPaginationModule,
  ReactiveFormsModule,  
  TranslateModule,
  GoogleChartsModule
];


@NgModule({
  declarations: [...COMPONENTS, NotFoundComponent, HeaderComponent],
  imports: [CommonModule, FormsModule, RouterModule, TranslateModule],
  exports: [...COMPONENTS, ...MODULES]
})
export class ThemeModule { 
  static forRoot(): ModuleWithProviders<ThemeModule> {
    return {
      ngModule: ThemeModule
    };
  }
}
