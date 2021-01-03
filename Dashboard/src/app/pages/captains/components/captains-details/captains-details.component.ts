import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { Subject } from 'rxjs';
import { takeUntil } from 'rxjs/operators';
import { CaptainDetails } from '../../entity/captain-details';
import { CaptianDetailsResponse } from '../../entity/captain-details-response';
import { CaptainsService } from '../../services/captains.service';

@Component({
  selector: 'app-captains-details',
  templateUrl: './captains-details.component.html',
  styleUrls: ['./captains-details.component.scss']
})
export class CaptainsDetailsComponent implements OnInit {
  private destroy$: Subject<void> = new Subject<void>();
  captainDetails: CaptainDetails;
  uploadForm: FormGroup;
  isSubmitted = false; 
  display = true;

  constructor(private captainService: CaptainsService,
              private formBuilder: FormBuilder,
              private toaster: ToastrService,
              private router: Router,
              private activateRoute: ActivatedRoute) { }

  ngOnInit() {
    this.uploadForm = this.formBuilder.group({
      salary: ['', Validators.required],
      bounce: ['', Validators.required]
    });
    // Get Captian Details Informations
    this.getCaptianDetails();
  }


  getCaptianDetails() {
    this.captainService.captainDetails(Number(this.activateRoute.snapshot.paramMap.get('id')))
    .pipe(takeUntil(this.destroy$))
    .subscribe(
      (captainDetail: CaptianDetailsResponse) => {
        if (captainDetail) {
          console.log('Captain Details: ', captainDetail);
          this.captainDetails = captainDetail.Data;
          this.updateFormValues();
        }
      },
      error => console.log('Error : ', error)
    );
  }

  updateFormValues() {
    this.uploadForm.patchValue({
      salary: this.captainDetails.salary,
      bounce: this.captainDetails.bounce
    });
  }


  focus() {
    this.display = false;
  }

  blur() {
    console.log('blur');
    setTimeout(() => {
      this.display = true;
    }, 1000);
  }

  mySubmit() {
    this.isSubmitted = true;
    if (!this.uploadForm.valid) {
      this.toaster.error('Error : Form Not Valid');
    } else {
      const formData = this.uploadForm.getRawValue();
      formData.status = this.captainDetails.status;
      formData.captainID = this.captainDetails.captainID;
      console.log('formData', formData);
      this.captainService.updateCaptainSalaryBounce(formData).subscribe(
        updateResponse => {
          console.log('updateResponse', updateResponse);
          this.isSubmitted = false;
          this.getCaptianDetails();
        }, error => {
          this.isSubmitted = false;
          console.log(error);
        }
      );
    }

  }

}
