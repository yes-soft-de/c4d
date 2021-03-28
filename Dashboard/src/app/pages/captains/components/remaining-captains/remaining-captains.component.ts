import { Component, OnDestroy, OnInit } from '@angular/core';
import { Subject } from 'rxjs';
import { takeUntil } from 'rxjs/operators';
import { CaptainDetails } from '../../entity/captain-details';
import { CaptainsService } from '../../services/captains.service';

@Component({
  selector: 'app-remaining-captains',
  templateUrl: './remaining-captains.component.html',
  styleUrls: ['./remaining-captains.component.scss']
})
export class RemainingCaptainsComponent implements OnInit, OnDestroy {
  private destroy$: Subject<void> = new Subject();
  remainingCaptains: CaptainDetails[];
  remainingCaptainsList: CaptainDetails[] = [];
  name: string;
  config: any;

  constructor(private captianService: CaptainsService) { }

  ngOnInit(): void {
    this.getRemainingCaptians();
  }

  getRemainingCaptians() {
    this.captianService.remainingCaptians()
    .pipe(takeUntil(this.destroy$))
    .subscribe(
      data => {
        console.log(data);
        this.remainingCaptains = data.Data.response;
        this.remainingCaptainsList = this.remainingCaptains;
      }, error => console.log(error),
      () => {
        this.config = {
          itemsPerPage: 5,
          currentPage: 1,
          totalItems: this.remainingCaptainsList.length
        };
      });
  }

  pageChanged(event) {
    this.config.currentPage = event;
  }

  applyFilter() {
    if (!this.name) {
      this.remainingCaptainsList = [...this.remainingCaptains];
    } else {
      this.remainingCaptainsList = [];
      this.remainingCaptainsList = this.remainingCaptains.filter(res => {

      });
    }
  }

  ngOnDestroy() {
    this.destroy$.next();
    this.destroy$.complete();
  }


}
