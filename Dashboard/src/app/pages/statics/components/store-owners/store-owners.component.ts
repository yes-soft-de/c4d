import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { Subject } from 'rxjs';
import { takeUntil } from 'rxjs/operators';
import { StoreOwners } from '../../entity/store-owners';
import { StoreOwnersResponse } from '../../entity/store-owners-response';
import { StaticsService } from '../../services/statics.service';

@Component({
  selector: 'app-store-owners',
  templateUrl: './store-owners.component.html',
  styleUrls: ['./store-owners.component.scss']
})
export class StoreOwnersComponent implements OnInit {
  private destroy$: Subject<void> = new Subject<void>();
  storeOwners: StoreOwners[];
  storeOwnersList: StoreOwners[] = [];
  config: any;
  name: string;

  constructor(
        private staticService: StaticsService,
        private router: Router,
        private toaster: ToastrService) { }

  ngOnInit() {
    this.staticService.allUsers('owner')
      .pipe(takeUntil(this.destroy$)).subscribe(
        (storeOwnersResponse: StoreOwnersResponse) => {
          if (storeOwnersResponse) {
            console.log('storeOwnersResponse', storeOwnersResponse);
            this.storeOwners = storeOwnersResponse.Data
            this.storeOwnersList = storeOwnersResponse.Data.reverse();
          }
        },
        error => this.handleError(error)          
      );
      this.config = {
        itemsPerPage: 5,
        currentPage: 1,
        totalItems: this.storeOwnersList.length
      };
  }

  // Handle Response Error
  handleError(error) {
    this.storeOwners = [];
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
      this.storeOwnersList = [...this.storeOwners];
    } else {
      this.storeOwnersList = [];
      this.storeOwnersList = this.storeOwners.filter(res => {
        if (res.userName) {
          const userName = res.userName.toLocaleLowerCase().match(this.name.toLocaleLowerCase());
          if (userName) {
            return userName;
          }
        }
      });
    }
  }

}

