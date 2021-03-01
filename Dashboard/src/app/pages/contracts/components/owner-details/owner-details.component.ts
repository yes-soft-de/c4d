import { DatePipe } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Subject } from 'rxjs';
import { takeUntil } from 'rxjs/operators';
import { AllOwners } from '../../entity/all-owners';
import { ContractsService } from '../../services/contracts.service';

@Component({
  selector: 'app-owner-details',
  templateUrl: './owner-details.component.html',
  styleUrls: ['./owner-details.component.scss'],
  providers: [DatePipe]
})
export class OwnerDetailsComponent implements OnInit {
  private destroy$: Subject<void> = new Subject<void>();
  ownerDetails: AllOwners;
  ownerDetailsBranches = [];
  active = true;
  config: any;

  constructor(private contractService: ContractsService,
              private datePipe: DatePipe,
              private activateRoute: ActivatedRoute) { }


  ngOnInit() {
    this.getOwnerDetails();
  }


  getOwnerDetails() {
    console.log('userId: ', this.activateRoute.snapshot.paramMap.get('id'));
    this.contractService.ownerDetails(this.activateRoute.snapshot.paramMap.get('id'))
      .pipe(takeUntil(this.destroy$))
      .subscribe(
        (ownerDetail: any) => {
          if (ownerDetail) {
            console.log('Owner Details: ', ownerDetail);
            this.ownerDetails = ownerDetail.Data;
            ownerDetail.Data.branches.map((e, i) => {
              this.ownerDetailsBranches.push({id: i + 1, brancheName: e.brancheName});
            });
            
            this.config = {
              itemsPerPage: 5,
              currentPage: 1,
              totalItems: this.ownerDetails.branches.length
            };
          }
        },
        error => console.log('Error : ', error)
    );
  }

    // Fetch The Page Number On Page Change
    pageChanged(event) {
      this.config.currentPage = event;
    }
  



}
