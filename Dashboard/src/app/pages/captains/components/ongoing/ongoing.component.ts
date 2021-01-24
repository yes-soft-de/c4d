import { Component, OnDestroy, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { of, Subject } from 'rxjs';
import { takeUntil } from 'rxjs/operators';
import { Captains } from '../../entity/captains';
import { CaptainsService } from '../../services/captains.service';

@Component({
  selector: 'app-ongoing',
  templateUrl: './ongoing.component.html',
  styleUrls: ['./ongoing.component.scss']
})
export class OngoingComponent implements OnInit, OnDestroy {
  private destroy$: Subject<void> = new Subject<void>();
  ongoingCaptains: Captains[];
  ongoingCaptainsList: Captains[] = [];
  config: any;

  constructor(
          private captainsService: CaptainsService,
          private router: Router,
          private activatedRoute: ActivatedRoute,
          private toaster: ToastrService) { }

  ngOnInit(): void {
    this.captainsService.allOngoingCaptains('ongoing')
      .pipe(takeUntil(this.destroy$))
      .subscribe(
        ongingCaptains => {
          if (ongingCaptains) {
            this.ongoingCaptains = ongingCaptains.Data;
            this.ongoingCaptainsList = ongingCaptains.Data;
            console.log(ongingCaptains);
          }
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
        totalItems: this.ongoingCaptainsList.length
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
