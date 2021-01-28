import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { Subject } from 'rxjs';
import { takeUntil } from 'rxjs/operators';
import { StaticsService } from '../../../services/statics.service';

@Component({
  selector: 'app-top-owners',
  templateUrl: './top-owners.component.html',
  styleUrls: ['./top-owners.component.scss']
})
export class TopOwnersComponent implements OnInit {
  private destroy$: Subject<void> = new Subject<void>();
  owners: any[];
  ownersList: any[] = [];
  config: any;

  constructor(
        private staticService: StaticsService,
        private router: Router,
        private toaster: ToastrService) { }

  ngOnInit() {
    this.staticService.allTopOwners()
      .pipe(takeUntil(this.destroy$)).subscribe(
        ownersResponse => {
          if (ownersResponse) {
            console.log('ownersResponse', ownersResponse);
            this.owners = ownersResponse.Data
            this.ownersList = ownersResponse.Data;
          }
        },
        error => this.handleError(error)          
      );
      this.config = {
        itemsPerPage: 15,
        currentPage: 1,
        totalItems: this.ownersList.length
      };
  }

  // Handle Response Error
  handleError(error) {
    this.owners = [];
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
  pagesChanged(event) {
    this.config.currentPage = event;
  }


}
