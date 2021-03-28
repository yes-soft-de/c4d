import { Component, OnDestroy, OnInit } from '@angular/core';
import { Subject } from 'rxjs';
import { findIndex, takeUntil } from 'rxjs/operators';
import { CaptainsDashboardResponse } from '../../entity/captains-dashboard-response';
import { DashboardService } from '../../services/dashboard.service';

@Component({
  selector: 'app-captains-dashboard',
  templateUrl: './captains-dashboard.component.html',
  styleUrls: ['./captains-dashboard.component.scss']
})
export class CaptainsDashboardComponent implements OnInit, OnDestroy {
  private destroy$: Subject<void> = new Subject<void>();
  countPendingCaptains: number;
  countOngoingCaptains: number;
  countDayOfCaptains: number;
  captains: any[] = [];
  latestCaptainsNumber = 5;
  constructor(private dashboardService: DashboardService) { }

  ngOnInit(): void {
    this.dashboardService.captainsDashboard()
    .pipe(takeUntil(this.destroy$))
    .subscribe((captainsResponse: CaptainsDashboardResponse) => {
      if (captainsResponse) {
        console.log(captainsResponse);
        this.countPendingCaptains = captainsResponse.Data[0].countPendingCaptains;
        this.countOngoingCaptains = captainsResponse.Data[1].countOngoingCaptains;
        this.countDayOfCaptains = captainsResponse.Data[2].countDayOfCaptains;
        captainsResponse.Data.map((captians, index) => {
          if (index >= 3) {
            this.captains.push(captians);
          }
        });
      }
    });
  }

  ngOnDestroy() {
    this.destroy$.next();
    this.destroy$.complete();
  }

}
