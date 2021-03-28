import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { Subject } from 'rxjs';
import { takeUntil } from 'rxjs/operators';
import { StaticsService } from '../../services/statics.service';

@Component({
  selector: 'app-all-captains',
  templateUrl: './all-captains.component.html',
  styleUrls: ['./all-captains.component.scss']
})
export class AllCaptainsComponent implements OnInit {
  private destroy$: Subject<void> = new Subject<void>();
  captains: any[];
  captainsList: any[] = [];
  name: string;
  config: any;

  constructor(
        private staticService: StaticsService,
        private router: Router,
        private toaster: ToastrService) { }

  ngOnInit() {
    this.staticService.allUsers('captain')
      .pipe(takeUntil(this.destroy$)).subscribe(
        captainsResponse => {
          if (captainsResponse) {
            console.log('captainsResponse', captainsResponse);
            this.captains = captainsResponse.Data
            this.captainsList = captainsResponse.Data.reverse();
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

  applyFilter() {
    if (!this.name) {
      this.captainsList = [...this.captains];
    } else {
      this.captainsList = [];
      this.captainsList = this.captains.filter(res => {
        if (res.name) {
          const name = res.name.toLocaleLowerCase().match(this.name.toLocaleLowerCase());
          if (name) {
            return name;
          }
        }
      })
    }
  }

}

