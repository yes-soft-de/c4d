import { Component, OnInit } from '@angular/core';
import { SIDEBAR_MENU_ITEM } from '../sidebar-menu';

@Component({
  selector: 'app-pages',
  // template: `
  //   <router-outlet></router-outlet>`
  template: `
  <div class="row w-100">
    <div class="col-8 pr-0">
      <router-outlet></router-outlet>
    </div>
    <div class="col-4 px-0">
      <app-sidebar [menus]="menu"></app-sidebar>
    </div>
  </div>`
})
export class PagesComponent implements OnInit {
  menu = SIDEBAR_MENU_ITEM;
  constructor() { }

  ngOnInit(): void {

  }

}
