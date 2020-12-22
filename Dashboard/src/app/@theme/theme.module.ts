import { ModuleWithProviders, NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { HttpClientModule } from '@angular/common/http';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { RouterModule } from '@angular/router';
import { NgxPaginationModule } from 'ngx-pagination';

import { SidebarComponent } from './components/sidebar/sidebar.component';
import { FooterComponent } from './components/footer/footer.component';
import { NotFoundComponent } from './components/not-found/not-found.component';

const COMPONENTS = [
  SidebarComponent,
  FooterComponent
];

const MODULES = [
  CommonModule,
  HttpClientModule,
  FormsModule, 
  NgxPaginationModule,
  ReactiveFormsModule,  
];

@NgModule({
  declarations: [...COMPONENTS, NotFoundComponent],
  imports: [CommonModule, FormsModule, RouterModule],
  exports: [...COMPONENTS, ...MODULES]
})
export class ThemeModule { 
  static forRoot(): ModuleWithProviders<ThemeModule> {
    return {
      ngModule: ThemeModule
    };
  }
}
