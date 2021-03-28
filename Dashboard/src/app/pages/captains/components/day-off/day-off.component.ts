import { Component, OnDestroy, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { Subject } from 'rxjs';
import { takeUntil } from 'rxjs/operators';
import { Captains } from '../../entity/captains';
import { CaptainsService } from '../../services/captains.service';
import {FormControl, FormGroup, Validators} from '@angular/forms';

@Component({
  selector: 'app-day-off',
  templateUrl: './day-off.component.html',
  styleUrls: ['./day-off.component.scss']
})
export class DayOffComponent implements OnInit, OnDestroy {
  private destroy$: Subject<void> = new Subject<void>();
  addDayOffForm: FormGroup;
  captains: Captains[];
  dayOffCaptains: Captains[];
  dayOffCaptainsList: Captains[] = [];
  isSubmited = false;
  activateDate = false;
  config: any;

  constructor(
        private captainService: CaptainsService,
        private router: Router,
        private toaster: ToastrService
  ) { }

  ngOnInit() {
    this.addDayOffForm = new FormGroup({
      captainId: new FormControl('', Validators.required),
      state: new FormControl('', Validators.required),
      startDate: new FormControl('', Validators.required),
      endDate: new FormControl('', Validators.required)
    });
    // Get All Captains
    this.getAllCaptains();
    // Get All Day Off Captains
    this.getCaptainsDayOff();
  }

  getAllCaptains() {
    this.captainService.allUsers('captain').subscribe(captainsResponse => this.captains = captainsResponse.Data);
  }

  getCaptainsDayOff() {
    this.captainService.allDayOffCaptians()
      .pipe(takeUntil(this.destroy$)).subscribe(
      dayOffResponse => {
        if (dayOffResponse) {
          console.log(dayOffResponse);
          this.dayOffCaptains = dayOffResponse.Data.reverse();
          this.dayOffCaptainsList = dayOffResponse.Data.reverse();
        }
      },
      error => this.handleError(error),
      () => {
        this.config = {
          itemsPerPage: 5,
          currentPage: 1,
          totalItems: this.dayOffCaptainsList.length
        };
      }
    );
  }

  handleError(error) {
    console.log(error);
    if (error.error.status_code == 404) {
      this.toaster.error(error.error.msg);
      setTimeout(() => {
        this.router.navigate(['/']);
      }, 2000);
    }
  }

  ngOnDestroy() {
    this.destroy$.next();
    this.destroy$.complete();
  }

  changeCaptain(event) {
    this.addDayOffForm.patchValue(event.target.value, {
      onlySelf: true
    });
  }

  changeCaptainState(event) {
    const captainId = this.addDayOffForm.get('captainId').value;
    const state = this.addDayOffForm.get('state').value;
    if (event.target.value == 'work') {
      this.activateDate = false;
      this.addDayOffForm = new FormGroup({
        captainId: new FormControl(captainId, Validators.required),
        state: new FormControl(state, Validators.required),
      });
    } else {
      this.activateDate = true;
      this.addDayOffForm = new FormGroup({
        captainId: new FormControl(captainId, Validators.required),
        state: new FormControl(state, Validators.required),
        startDate: new FormControl('', Validators.required),
        endDate: new FormControl('', Validators.required)
      });
    }
    this.addDayOffForm.patchValue(event.target.value, {
      onlySelf: true
    });
  }

  // Fetch The Page Number On Page Change
  pageChanged(event) {
    this.config.currentPage = event;
  }

  onSubmit() {
    this.isSubmited = true;
    if (!this.addDayOffForm.valid) {
      this.toaster.error('Sorry, Form Not Valid');
      this.isSubmited = false;
      return;
    }
    const formObject = this.addDayOffForm.getRawValue();
    console.log(formObject);
    this.captainService.giveCaptainDayOff(formObject).subscribe(
      createResponse => {
        this.isSubmited = false;
        this.addDayOffForm.reset();     // reset form inputs
        if (this.activateDate) {
          this.toaster.success('The Captain Was Successfully Granted a Day Off');
        } else {
          this.toaster.success('Captain\'s Day off removed successfully');
        }
        this.getCaptainsDayOff();       // Rerender all Captains in Day Off
      }
    );
  }

}
