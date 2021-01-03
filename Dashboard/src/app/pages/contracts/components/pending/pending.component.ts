import { Component, OnDestroy, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
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
    private captainService: ContractsService,
    private router: Router,
    private toaster: ToastrService
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
        error => {
          console.log(error);
          if (error.error.status_code == 404) {
            this.toaster.error(error.error.msg);
            setTimeout(() => {
              this.router.navigate(['/']);
            }, 2000);
          }
        }
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
