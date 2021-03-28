import { Component, OnInit } from '@angular/core';
import { Subject } from 'rxjs';
import { takeUntil } from 'rxjs/operators';
import { DashboardService } from '../../services/dashboard.service';
import { ContractsDashboardResponse } from '../../entity/contracts-dashboard-response';
import { ContractsDashboard } from '../../entity/contracts-dashboard';
import { DatePipe } from '@angular/common';

@Component({
  selector: 'app-contracts-dashboard',
  templateUrl: './contracts-dashboard.component.html',
  styleUrls: ['./contracts-dashboard.component.scss'],
  providers: [DatePipe]
})
export class ContractsDashboardComponent implements OnInit {
  private destroy$: Subject<void> = new Subject<void>();
  countPendingContracts: number;
  countDoneContracts: number;
  NewUsersThisMonth: number;
  contracts: any[] = [];
  latestcontractsNumber = 5;
  config: any;

  constructor(private dashboardService: DashboardService, private datePipe: DatePipe) { }

  ngOnInit() {
    console.log('config : ', this.config);
    let year = new Date().getUTCFullYear().toString(),
        month = (new Date().getUTCMonth() + 1).toString();
        console.log('Y-M : ', year, month);
    this.dashboardService.contractsDashboard(year, month)
    .pipe(takeUntil(this.destroy$))
    .subscribe(
      (contractsResponse: ContractsDashboardResponse) => {
        if (contractsResponse) {
          console.log('contractsResponse', contractsResponse);
          this.countPendingContracts = contractsResponse.Data[0].countPendingContracts;
          this.countDoneContracts = contractsResponse.Data[1].countDoneContracts;
          this.NewUsersThisMonth = contractsResponse.Data[2].NewUsersThisMonth;
          contractsResponse.Data.map((contracts, index) => {          
            if (index >= 3) {
              this.contracts.push(contracts);
            }
          });
        }      
      }, error => console.log(error),
      () => {
        if (this.contracts.length > 0) {
          this.config = {
            itemsPerPage: 5,
            currentPage: 1,
            totalItems: this.contracts.length 
          };
        }
      }
    );
  }

  // Fetch The Page Number On Page Change
  pageChanged(event) {
    this.config.currentPage = event;
  }

  ngOnDestroy() {
    this.destroy$.next();
    this.destroy$.complete();
  }  

}
