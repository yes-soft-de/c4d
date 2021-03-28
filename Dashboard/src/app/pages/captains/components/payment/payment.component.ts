import {Component, Input, OnInit} from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ToastrService } from 'ngx-toastr';
import { Subject, Subscription } from 'rxjs';
import { takeUntil } from 'rxjs/operators';
import { CaptainTotalBounce } from '../../entity/captain-total-bounce';
import { Captains } from '../../entity/captains';
import { CaptainsResponse } from '../../entity/captains-response';
import { CaptainsService } from '../../services/captains.service';

@Component({
  selector: 'app-payment',
  templateUrl: './payment.component.html',
  styleUrls: ['./payment.component.scss']
})
export class PaymentComponent implements OnInit {
  // @Input() removeTitle = false;
  private destroy$: Subject<void> = new Subject<void>();
  captains: Captains[];
  captainTotalBounce: CaptainTotalBounce;
  captainTotalBounceList = [];
  captainID: string;
  profileID: string;
  bank: string;
  currentTotal: number;
  nextPay: string;
  sumPayments: string;
  totalAmountOfSubscriptions: number;
  uploadForm: FormGroup;
  captainPaymentAmount: any = [];
  isSubmitted = false;
  config: any;                                                // Config Variable For Pagination Configuration
  name: string;
  isClicked = false;
  captainsSubscription: Subscription;

  constructor(private captainService: CaptainsService,
              private formBuilder: FormBuilder,
              private toaster: ToastrService) { }

  ngOnInit() {
    // Get All Owners
    this.getAllCaptains();

    this.uploadForm = this.formBuilder.group({
      captainId: ['', Validators.required],
      amount: ['', Validators.required]
    });
  }

  ngOnDestroy() {
    this.captainsSubscription.unsubscribe();
  }

  // Get All Owners
  getAllCaptains() {
    this.captainsSubscription = this.captainService.allUsers('captain')
    .pipe(takeUntil(this.destroy$)).subscribe(
      captainsResponse => {
        if (captainsResponse) {
          console.log('captainsResponse', captainsResponse);
          this.captains = captainsResponse.Data;
        }
      },
      error => this.handleError(error)
    );
  }


  getCaptianTotalBounce(captainID: string) {
    this.captainService.captianTotalBounce(captainID).subscribe(
      (captainTotalBounceResponse: any) => {
        if (captainTotalBounceResponse) {
          console.log('captainTotalBounceResponse', captainTotalBounceResponse.Data);
          this.captainTotalBounce = captainTotalBounceResponse.Data;
          this.captainTotalBounceList = captainTotalBounceResponse.Data.payments;
        }
      },
      error => {
        this.handleError(error);
      }, () => {
        this.config = {
          itemsPerPage: 5,
          currentPage: 1,
          totalItems: this.captainTotalBounceList.length
        };
      }
    );
  }


  // get All Episodes For Specific Owner
  changeOwner(event) {
    this.isClicked = true;
    this.uploadForm.patchValue(event.target.value, {
      onlySelf: true
    });
    this.captains.map(e => {
      if (e.id == event.target.value) {
        this.profileID = event.target.value;
        this.captainID = e.captainID;
      }
    });

    // get Owner Payment Details
    this.getCaptianTotalBounce(event.target.value);
  }


  // Fetch The Page Number On Page Change
  pageChanged(event) {
    this.config.currentPage = event;
  }



  mySubmit() {
    this.isSubmitted = true;
    if (!this.uploadForm.valid) {
      this.toaster.error('Error : Form Not Valid');
      this.isSubmitted = false;
      return false;
    } else {
      const formObject = this.uploadForm.getRawValue();
      formObject.captainId = this.captainID;
      console.log(formObject);
      this.captainService.payment(formObject).subscribe(
        data => console.log(data),
        error => {
          this.isSubmitted = false;
          console.log(error);
        },
        () => {
          this.isSubmitted = false;
          this.uploadForm.get('amount').reset();
          this.getCaptianTotalBounce(this.profileID);
        }
      );
    }
  }


  // Handle Response Error
  handleError(error) {
    this.isClicked = false;
    console.log(error);
    if (error.error.error) {
      this.toaster.error(error.error.error);
    } else if (error.error.msg) {
      this.toaster.error(error.error.msg);
    }
  }

}
