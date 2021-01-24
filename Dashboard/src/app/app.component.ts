import {Component} from '@angular/core';
import { TranslateService } from '@ngx-translate/core';
import { SIDEBAR_MENU_ITEM } from './sidebar-menu';



@Component({
  selector: 'app-root', 
  template: `<router-outlet><router-outlet>`
})
export class AppComponent {
  menu = SIDEBAR_MENU_ITEM;
  title = 'C4D Dashboard';
  
  constructor(public translate: TranslateService) {   
  }


}
