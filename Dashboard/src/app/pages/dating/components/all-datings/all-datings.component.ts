import { Component, OnInit } from '@angular/core';
import { ToastrService } from 'ngx-toastr';
import { Subject } from 'rxjs';
import { takeUntil } from 'rxjs/operators';
import { DatingsResponse } from '../../entity/datings-response';
import { DatingsService } from '../../services/datings.service';

@Component({
  selector: 'app-all-datings',
  templateUrl: './all-datings.component.html',
  styleUrls: ['./all-datings.component.scss']
})
export class AllDatingsComponent implements OnInit {
  private destroy$: Subject<void> = new Subject<void>();
  datings: any[];
  datingsList: any[] = [];
  isClicked = false;
  config: any;

  constructor(
        private datingService: DatingsService,
        private toaster: ToastrService) { }

  ngOnInit() {
      this.getDatings();
  }

  getDatings() {
    this.datingService.allDatings()
    .pipe(takeUntil(this.destroy$)).subscribe(
      (datingsResponse: DatingsResponse) => {
        if (datingsResponse) {
          console.log('datingsResponse', datingsResponse);
          this.datings = datingsResponse.Data
          this.datingsList = datingsResponse.Data.reverse();
        }
      },
      error => this.handleError(error)          
    );
    this.config = {
      itemsPerPage: 5,
      currentPage: 1,
      totalItems: this.datingsList.length
    };
  }

  // Handle Response Error
  handleError(error) {
    this.datings = [];
    console.log(error);
    if (error.error.error) {
      this.toaster.error(error.error.error);
    } else if (error.error.msg) {
      this.toaster.error(error.error.msg);
    }
  }

  isDone(datingID, isDone) {
    this.isClicked = true;
    console.log(datingID, isDone);
    this.datingService.datingIsDone(datingID, isDone).subscribe(
      response => {
        this.isClicked = false;
        this.getDatings();
      }, error => {
        console.log(error);
        this.isClicked = false;
      }
    );
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
