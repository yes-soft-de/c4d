import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { Subject } from 'rxjs';
import { takeUntil } from 'rxjs/operators';
import { TopCaptains } from '../../../entity/top-captains';
import { TopCaptiansResponse } from '../../../entity/top-captains-response';
import { StaticsService } from '../../../services/statics.service';

@Component({
  selector: 'app-top-captains',
  templateUrl: './top-captains.component.html',
  styleUrls: ['./top-captains.component.scss']
})
export class TopCaptainsComponent implements OnInit {
  private destroy$: Subject<void> = new Subject<void>();
  captains: TopCaptains[];
  captainsList: TopCaptains[] = [];
  config: any;

  constructor(
        private staticService: StaticsService,
        private router: Router,
        private toaster: ToastrService) { }

  ngOnInit() {
    this.staticService.allTopCaptains()
      .pipe(takeUntil(this.destroy$)).subscribe(
        (captainsResponse: TopCaptiansResponse) => {
          if (captainsResponse) {
            console.log('captainsResponse', captainsResponse);
            this.captains = captainsResponse.Data
            this.captainsList = captainsResponse.Data;
          }
        },
        error => this.handleError(error)          
      );
      this.config = {
        itemsPerPage: 15,
        currentPage: 1,
        totalItems: this.captainsList.length
      };
  }

  // Handle Response Error
  handleError(error) {
    this.captains = [];
    console.log(error);
    if (error.error.error) {
      this.toaster.error(error.error.error);
    } else if (error.error.msg) {
      this.toaster.error(error.error.msg);
    }
  }

  ngOnDestroy() {
    this.destroy$.next();
    this.destroy$.complete();
  }

  // Fetch The Page Number On Page Change
  pagedChanged(event) {
    this.config.currentPage = event;
  }


}
