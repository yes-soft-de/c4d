import { Component, OnInit } from '@angular/core';
import { Subject } from 'rxjs';
import { takeUntil } from 'rxjs/operators';
import { DashboardService } from '../../services/dashboard.service';
import { ContractsDashboardResponse } from '../../entity/contracts-dashboard-response';
import { ContractsDashboard } from '../../entity/contracts-dashboard';

@Component({
  selector: 'app-contracts-dashboard',
  templateUrl: './contracts-dashboard.component.html',
  styleUrls: ['./contracts-dashboard.component.scss']
})
export class ContractsDashboardComponent implements OnInit {
  private destroy$: Subject<void> = new Subject<void>();
  countPendingContracts: number;
  countDoneContracts: number;
  countCancelledContracts: number;
  contracts: any[] = [];
  latestcontractsNumber = 5;
  constructor(private dashboardService: DashboardService) { }

  ngOnInit(): void {
    this.dashboardService.contractsDashboard()
    .pipe(takeUntil(this.destroy$))
    .subscribe((contractsResponse: ContractsDashboardResponse) => {
      if (contractsResponse) {
        console.log(contractsResponse);
        this.countPendingContracts = contractsResponse.Data[0].countPendingContracts;
        this.countDoneContracts = contractsResponse.Data[1].countDoneContracts;
        this.countCancelledContracts = contractsResponse.Data[2].countCancelledContracts;
        contractsResponse.Data.map((contracts, index) => {          
          if (index >= 3) {
            this.contracts.push(contracts);
          }
        });
      }      
    });
  }

  ngOnDestroy() {
    this.destroy$.next();
    this.destroy$.complete();
  }  

}
