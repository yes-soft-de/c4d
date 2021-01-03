import { Component, OnDestroy, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { Subject } from 'rxjs';
import { takeUntil } from 'rxjs/operators';
import { Captains } from '../../entity/captains';
import { CaptainsService } from '../../services/captains.service';

@Component({
  selector: 'app-day-off',
  templateUrl: './day-off.component.html',
  styleUrls: ['./day-off.component.scss']
})
export class DayOffComponent implements OnInit, OnDestroy {
  private destroy$: Subject<void> = new Subject<void>();
  dayOffCaptains: Captains[];
  dayOffCaptainsList: Captains[] = [];
  config: any;

  constructor(
        private captainService: CaptainsService,
        private router: Router,
        private toaster: ToastrService
  ) { }

  ngOnInit() {
    this.captainService.allDayOffCaptians()
      .pipe(takeUntil(this.destroy$)).subscribe(
        dayOffResponse => {
          if (dayOffResponse) {
            console.log(dayOffResponse);
            this.dayOffCaptains = dayOffResponse.Data
            this.dayOffCaptainsList = dayOffResponse.Data;
          }
        },
        error => {
          console.log(error);
          if (error.error.status_code == 404) {
            this.toaster.error(error.error.msg);
            setTimeout(() => {
              this.router.navigate(['/']);
            }, 2000);
          }
        }
      );
      this.config = {
        itemsPerPage: 5,
        currentPage: 1,
        totalItems: this.dayOffCaptainsList.length
      };
  }

  ngOnDestroy() {
    this.destroy$.next();
    this.destroy$.complete();
  }

  // Fetch The Page Number On Page Change
  pageChanged(event) {
    this.config.currentPage = event;
  }


}
