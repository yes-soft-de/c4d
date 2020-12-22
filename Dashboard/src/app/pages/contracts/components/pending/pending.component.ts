import { Component, OnDestroy, OnInit } from '@angular/core';
import { Subject } from 'rxjs';
import { takeUntil } from 'rxjs/operators';
import { Contracts } from '../../entity/contracts';
import { ContractsService } from '../../services/contracts.service';

@Component({
  selector: 'app-pending',
  templateUrl: './pending.component.html',
  styleUrls: ['./pending.component.scss']
})
export class PendingComponent implements OnInit, OnDestroy {
  private destroy$: Subject<void> = new Subject<void>();
  pendingContracts: Contracts[];
  pendingContractsList: Contracts[] = [];
  config: any;

  constructor(
    private captainService: ContractsService
) { }

  ngOnInit() {
    this.captainService.allPendingContracts()
      .pipe(takeUntil(this.destroy$))
      .subscribe(
        pendingContracts => {
          if (pendingContracts) {
            this.pendingContracts = pendingContracts.Data;
            this.pendingContractsList = pendingContracts.Data;
          }
          console.log(pendingContracts);
        },
        error => console.log('Error : ', error)
      );
      this.config = {
        itemsPerPage: 5,
        currentPage: 1,
        totalItems: this.pendingContractsList.length
      }
  }

  ngOnDestroy() {
    this.destroy$.next();
    this.destroy$.complete();
  }

  pageChanged(event) {
    this.config.currentPage = event;
  }
}
