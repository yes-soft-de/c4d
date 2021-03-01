import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { Subject } from 'rxjs';
import { takeUntil } from 'rxjs/operators';
import { CaptainsService } from '../../services/captains.service';

@Component({
  selector: 'app-all-captains',
  templateUrl: './all-captains.component.html',
  styleUrls: ['./all-captains.component.scss']
})
export class AllCaptainsComponent implements OnInit {
  private destroy$: Subject<void> = new Subject<void>();
  captains: any[];
  captainsList: any[] = [];
  config: any;

  constructor(
        private captainService: CaptainsService,
        private router: Router,
        private toaster: ToastrService) { }

  ngOnInit() {
    this.captainService.allUsers('captain')
      .pipe(takeUntil(this.destroy$)).subscribe(
        captainsResponse => {
          if (captainsResponse) {
            console.log('captainsResponse', captainsResponse);
            this.captains = captainsResponse.Data
            this.captainsList = captainsResponse.Data;
          }
        },
        error => this.handleError(error)          
      );
      this.config = {
        itemsPerPage: 5,
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
  pageChanged(event) {
    this.config.currentPage = event;
  }


}

