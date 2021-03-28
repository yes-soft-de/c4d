import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { Subject } from 'rxjs';
import { takeUntil } from 'rxjs/operators';
import { Packages } from '../../entity/packages';
import { PackagesService } from '../../services/packages.service';

@Component({
  selector: 'app-list-packages',
  templateUrl: './list-packages.component.html',
  styleUrls: ['./list-packages.component.scss']
})
export class ListPackagesComponent implements OnInit {
  private destroy$: Subject<void> = new Subject<void>();
  packages: Packages[];
  packagesList: Packages[] = [];
  config: any;

  constructor(
        private packageService: PackagesService,
        private router: Router,
        private toaster: ToastrService
  ) { }

  ngOnInit() {
    this.packageService.allPackages()
      .pipe(takeUntil(this.destroy$)).subscribe(
        packagesResponse => {
          if (packagesResponse) {
            console.log('packagesResponse', packagesResponse);
            this.packages = packagesResponse.Data
            this.packagesList = packagesResponse.Data.reverse();
          }
        },
        error => this.handleError(error)          
      );
      this.config = {
        itemsPerPage: 5,
        currentPage: 1,
        totalItems: this.packagesList.length
      };
  }

  // Handle Response Error
  handleError(error) {
    this.packages = [];
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
