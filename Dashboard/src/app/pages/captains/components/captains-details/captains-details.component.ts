import { DOCUMENT } from '@angular/common';
import { HttpClient } from '@angular/common/http';
import { Component, Inject, OnInit, Renderer2 } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router, RoutesRecognized } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { Subject } from 'rxjs';
import { filter, pairwise, takeUntil } from 'rxjs/operators';
import { TokenService } from 'src/app/pages/admin-service/token/token.service';
import { AdminConfig } from 'src/app/pages/AdminConfig';
import { ContractsRoutingModule } from 'src/app/pages/contracts/contracts-routing.module';
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
  intervalCounter: any;

  constructor(private captainService: CaptainsService,
              private httpClient: HttpClient,
              private tokenService: TokenService,
              private formBuilder: FormBuilder,
              private toaster: ToastrService,
              private router: Router,
              private activateRoute: ActivatedRoute,
              @Inject(DOCUMENT) private document: Document,
              private render: Renderer2) { }

  ngOnInit() {
    this.changeElementExistsWidth();
    this.activateRoute.params.subscribe(
      urlSegment => {
        if (urlSegment.dayOff) {
          this.getDayOffCaptainDetails();
        } else {
          this.getCaptianDetails();
        }
      }
    );
    this.uploadForm = this.formBuilder.group({
      salary: ['', Validators.required],
      bounce: ['', Validators.required]
    });
  }

  // Observable getCaptainDetails
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

  // private async getCaptianDetails() {
  //   const data = await this.httpClient.get(
  //     `${AdminConfig.captainDetailAPI}/${Number(this.activateRoute.snapshot.paramMap.get('id'))}`,
  //     this.tokenService.httpOptions()
  //   ).toPromise();
  //   console.log('Promise Captain Details: ', data);
  //   this.captainDetails = data.Data;
  //   this.updateFormValues();
    // console.log('Promise Captain Details', data);
    // this.captainService.captainDetails(Number(this.activateRoute.snapshot.paramMap.get('id')))
    // .then(
    //   (captainDetail: CaptianDetailsResponse) => {
    //     if (captainDetail) {
    //       console.log('Promise Captain Details: ', captainDetail);
    //       this.captainDetails = captainDetail.Data;
    //       this.updateFormValues();
    //     }
    //   }).catch(error => console.log('Error : ', error));
  // }

  getDayOffCaptainDetails() {
    this.captainService.dayOffCaptainDetails(Number(this.activateRoute.snapshot.paramMap.get('id')))
    .pipe(takeUntil(this.destroy$))
    .subscribe(
      (captainDetail: CaptianDetailsResponse) => {
        if (captainDetail) {
          console.log('Day Off Captain Details: ', captainDetail);
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

  refresh() {
    console.log('click refresh');
    this.activateRoute.params.subscribe(
      urlSegment => {
        if (urlSegment.dayOff) {
          this.getDayOffCaptainDetails();
        } else {
          this.getCaptianDetails();
        }
      }
    );
  }

  // Check If Chart Element Exists
  changeElementExistsWidth() {
    let second = 0;
    this.intervalCounter = setInterval(() => {
      second++;
      const Element = this.document.querySelector('#refresh_button');
      if (Element) {
        second = 0;
        this.render.setStyle(Element, 'width', Element.previousElementSibling.clientWidth + 'px');
        clearInterval(this.intervalCounter);
      }
    }, 100);
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
