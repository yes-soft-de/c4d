import {Component, OnDestroy, OnInit} from '@angular/core';
import {FormBuilder, FormGroup, Validators} from '@angular/forms';
import {Subject, Subscription} from 'rxjs';
import {ContractsService} from '../../services/contracts.service';
import {ToastrService} from 'ngx-toastr';
import {takeUntil} from 'rxjs/operators';
import {AllOwnersResponse} from '../../entity/all-owners-response';
import {AllOwners} from '../../entity/all-owners';
import { PaymentsOfOwner } from '../../entity/payment-of-owner';

@Component({
  selector: 'app-payment',
  templateUrl: './payment.component.html',
  styleUrls: ['./payment.component.scss']
})
export class PaymentComponent implements OnInit, OnDestroy {
  private destroy$: Subject<void> = new Subject<void>();
  owners: AllOwners[];
  ownerPaymentDetails: PaymentsOfOwner;
  ownerPaymentDetailsList = [];
  uploadForm: FormGroup;
  isSubmitted = false;
  config: any;                                                // Config Variable For Pagination Configuration
  name: string;
  isClicked = false;
  ownersSubscription: Subscription;

  constructor(private ownerService: ContractsService,
              private formBuilder: FormBuilder,
              private toaster: ToastrService) { }

  ngOnInit() {
    // Get All Owners
    this.getAllOwners();

    this.uploadForm = this.formBuilder.group({
      ownerId: ['', Validators.required],
      amount: ['', Validators.required]
    });
  }

  ngOnDestroy() {
    this.ownersSubscription.unsubscribe();
  }

  // Get All Owners
  getAllOwners() {
    this.ownersSubscription = this.ownerService.allUsers('owner')
      .pipe(takeUntil(this.destroy$)).subscribe(
        (allOwnersResponse: AllOwnersResponse) => {
          if (allOwnersResponse) {
            console.log('allOwnersResponse', allOwnersResponse);
            this.owners = allOwnersResponse.Data;
          }
        },
        error => this.handleError(error)
      );
  }


  getOwnerPaymentDetails(ownerID: string) {
    this.ownerService.paymentsOfOwner(ownerID).subscribe(
      (ownerPaymentDetailsResponse: any) => {
        if (ownerPaymentDetailsResponse) {
          console.log('ownerPaymentDetailsResponse', ownerPaymentDetailsResponse.Data);
          this.ownerPaymentDetails = ownerPaymentDetailsResponse.Data;        
          this.ownerPaymentDetailsList = ownerPaymentDetailsResponse.Data.payments;
        }
      },
      error => this.handleError(error),
      () => {
        this.config = {
          id: 'amount_pagination',
          itemsPerPage: 5,
          currentPage: 1,
          totalItems: this.ownerPaymentDetailsList.length
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

    // get Owner Payment Details
    this.getOwnerPaymentDetails(event.target.value);
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
      console.log(formObject);
      this.ownerService.payment(formObject).subscribe(
        data => console.log(data),
        error => {
          this.isSubmitted = false;
          console.log(error);
        },
        () => {
          this.isSubmitted = false;
          this.uploadForm.get('amount').reset();
          this.getOwnerPaymentDetails(formObject.ownerId);
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
