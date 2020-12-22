import {Component} from '@angular/core';
import { SIDEBAR_MENU_ITEM } from './sidebar-menu';
import * as firebase from 'firebase';

const config = {
  apiKey: 'AIzaSyDguSjYN2B2GVKuN7wc4DtKc_D-QGdYBtA',
  databaseURL: 'https://angularchat-607dc-default-rtdb.firebaseio.com'
};


@Component({
  selector: 'app-root',
  // template: `
  // <div class="row w-100">
  //   <div class="col-8 pr-0">
  //     <router-outlet></router-outlet>
  //   </div>
  //   <div class="col-4 px-0">
  //     <app-sidebar [menus]="menu"></app-sidebar>
  //   </div>
  // </div>`
  template: `<router-outlet><router-outlet>`
})
export class AppComponent {
  menu = SIDEBAR_MENU_ITEM

  title = 'C4D Dashboard';
  
  constructor() {
    firebase.default.initializeApp(config);
   }

  ngOnInit(): void { }

}
