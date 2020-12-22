import { Component, OnDestroy, OnInit } from '@angular/core';
import { Subject } from 'rxjs';
import { takeUntil } from 'rxjs/operators';
import { Captains } from '../../entity/captains';
import { CaptainsService } from '../../services/captains.service';

@Component({
  selector: 'app-pending',
  templateUrl: './pending.component.html',
  styleUrls: ['./pending.component.scss']
})
export class PendingComponent implements OnInit, OnDestroy {
  private destroy$: Subject<void> = new Subject<void>();
  pendingCaptains: Captains[];
  pendingCaptainsList: Captains[] = [];
  config: any;

  constructor(
    private captainService: CaptainsService
) { }

  ngOnInit() {
    this.captainService.allPendingCaptains('captain')
      .pipe(takeUntil(this.destroy$))
      .subscribe(
        pendingCaptains => {
          if (pendingCaptains) {
            this.pendingCaptains = pendingCaptains.Data;
            this.pendingCaptainsList = pendingCaptains.Data;
          }
          console.log(pendingCaptains);
        },
        error => console.log('Error : ', error)
      );
      this.config = {
        itemsPerPage: 5,
        currentPage: 1,
        totalItems: this.pendingCaptainsList.length
      }
  }

  ngOnDestroy() {
    this.destroy$.next();
    this.destroy$.complete();
  }

  pageChanged(event) {
    this.config.currentPage = event;
  }
  
}
