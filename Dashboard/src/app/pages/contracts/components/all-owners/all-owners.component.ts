import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { Subject } from 'rxjs';
import { takeUntil } from 'rxjs/operators';
import {ContractsService} from '../../services/contracts.service';
import {AllOwnersResponse} from '../../entity/all-owners-response';
import {AllOwners} from '../../entity/all-owners';

@Component({
  selector: 'app-all-owners',
  templateUrl: './all-owners.component.html',
  styleUrls: ['./all-owners.component.scss']
})
export class AllOwnersComponent implements OnInit {
  private destroy$: Subject<void> = new Subject<void>();
  allOwners: AllOwners[];
  allOwnersList: AllOwners[] = [];
  config: any;
  name: string;

  constructor(
        private contractService: ContractsService,
        private router: Router,
        private toaster: ToastrService) { }

  ngOnInit() {
    this.contractService.allUsers('owner')
      .pipe(takeUntil(this.destroy$)).subscribe(
        (allOwnersResponse: AllOwnersResponse) => {
          if (allOwnersResponse) {
            console.log('allOwnersResponse', allOwnersResponse);
            this.allOwners = allOwnersResponse.Data
            this.allOwnersList = allOwnersResponse.Data.reverse();
          }
        },
        error => this.handleError(error)
      );
      this.config = {
        itemsPerPage: 5,
        currentPage: 1,
        totalItems: this.allOwnersList.length
      };
  }

  // Handle Response Error
  handleError(error) {
    this.allOwners = [];
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
      this.allOwnersList = [...this.allOwners];
    } else {
      this.allOwnersList = [];
      this.allOwnersList = this.allOwners.filter(res => {
        if (res.userName) {
          const userName = res.userName.toLocaleLowerCase().match(this.name.toLocaleLowerCase());
          if (userName) {
            return userName;
          }
        }
      })
    }
  }

}

