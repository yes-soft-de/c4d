import { AfterViewInit, Component, ElementRef, HostListener, Inject, OnDestroy, OnInit } from '@angular/core';
import { TranslateService } from '@ngx-translate/core';
import { debounceTime } from 'rxjs/operators';
import { FooterComponent } from 'src/app/@theme/components';
import { LayoutService } from 'src/app/@theme/helper/layout.service';


@Component({
  selector: 'app-dashboard',
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.scss'],
  providers: [FooterComponent]
})
export class DashboardComponent implements OnInit, AfterViewInit {

  constructor(private layoutService: LayoutService, public translate: TranslateService) {}

  ngOnInit() {    
  }

  ngAfterViewInit() {
    this.layoutService.layoutState
      .pipe(debounceTime(350))
      .subscribe(
        layoutRespone => {
          let element: HTMLElement = document.getElementById(layoutRespone) as HTMLElement;
          element.click();    
        }
      );
  }
}
