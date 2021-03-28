import {Component, EventEmitter, OnDestroy, OnInit, ViewChild} from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import {ActivatedRoute, NavigationEnd, Router} from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import {Subject, Subscription} from 'rxjs';
import { takeUntil } from 'rxjs/operators';
import { CaptainsService } from '../../services/captains.service';
import {AddTermComponent} from './add-term/add-term.component';

@Component({
  selector: 'app-terms-captain',
  templateUrl: './terms-captain.component.html',
  styleUrls: ['./terms-captain.component.scss']
})
export class TermsCaptainComponent implements OnInit, OnDestroy {
  private destroy$: Subject<void> = new Subject<void>();
  termCaptains: any[];
  termCaptainsList: any[] = [];
  config: any;
  name: string;
  noData = false;
  termCaptainSubscription: Subscription;

  constructor(
          private captainsService: CaptainsService,
          private router: Router,
          private activatedRoute: ActivatedRoute,
          private toaster: ToastrService) { }

  ngOnInit(): void {
    // check if route is change
    this.router.events.subscribe(route => {
      if (route instanceof NavigationEnd && route.urlAfterRedirects == '/captains/terms') {
        console.log('yes route  is change to end', route);
        this.getTermsCaptain();
      }
    });
    // run termCaptainData if the page is refresh from browser
    this.getTermsCaptain();
  }


  getTermsCaptain() {
    this.termCaptainSubscription = this.captainsService.getTermsCaptain()
      .pipe(takeUntil(this.destroy$))
      .subscribe(
        ongingCaptains => {
          if (ongingCaptains) {
            this.noData = false;
            this.termCaptains = ongingCaptains.Data;
            this.termCaptainsList = ongingCaptains.Data;
            console.log(ongingCaptains);
          }
        },
        error => this.handleError(error),
        () => {
          this.config = {
            itemsPerPage: 5,
            currentPage: 1,
            totalItems: this.termCaptainsList.length
          };
        }
      );
  }


  handleError(error) {
    console.log('status code 404', error.error.status_code == '404');
    if (error) {
      if (error?.error?.status_code == '404') {
        this.noData = true;
      }
    }
  }

  ngOnDestroy() {
    this.destroy$.next();
    this.destroy$.complete();
    this.termCaptainSubscription.unsubscribe();
  }

  pageChanged(event) {
    this.config.currentPage = event;
  }
  applyFilter() {
    // Filter Code
  }

}
