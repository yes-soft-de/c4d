import { DOCUMENT } from '@angular/common';
import { Component, HostListener, Inject, OnInit, Renderer2 } from '@angular/core';
import { SIDEBAR_MENU_ITEM } from '../sidebar-menu';

@Component({
  selector: 'app-pages',
  // template: `
  //   <router-outlet></router-outlet>`
  template: `
  <div *ngIf="isMobile" id="mobile_header" class="d-md-none">
    <app-header [menus]="menu"></app-header>
  </div>
  <div id="parent_body_div" class="row w-100">
    <div id="body_div" class="col-8 pr-0">
      <router-outlet></router-outlet>
    </div>
    <div *ngIf="!isMobile" id="sidebar_div" class="col-4 px-0 d-none d-md-block">
      <app-sidebar [menus]="menu"></app-sidebar>
    </div>
  </div>`
})
export class PagesComponent implements OnInit {
  menu = SIDEBAR_MENU_ITEM;
  isMobile = false;

  constructor(@Inject(DOCUMENT) private document: Document,
              private render: Renderer2) { }

  ngOnInit(): void {
    this.onResize();
  }

  
  onResize() {
    const screenWidth = window.innerWidth;
    if (screenWidth < 768) {
      this.isMobile = true;
      this.render.removeClass(this.document.getElementById('body_div'), 'col-8');
      this.render.addClass(this.document.getElementById('body_div'), 'col-12');
      if (screenWidth < 576) {
        this.render.removeClass(this.document.getElementById('parent_body_div'), 'row');
        this.render.addClass(this.document.getElementById('parent_body_div'), 'pb-5');
        this.render.removeClass(this.document.getElementById('body_div'), 'pr-0')        
        this.render.removeClass(this.document.getElementById('body_div'), 'col-12');
      }
    } else {
      this.isMobile = false;
    }
  }


  toggleSidebar() {
    // this.render.addClass(this.document.getElementById('sidebar_div'), 'd-none');
    // this.render.removeClass(this.document.getElementById('body_div'), 'col-8');
    // this.render.addClass(this.document.getElementById('body_div'), 'col-12');
  }

}
