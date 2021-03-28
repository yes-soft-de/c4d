import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { ToastrService } from 'ngx-toastr';
import { from } from 'rxjs';
import { SupportInformationRequest } from '../../entity/support-info-request';
import { SupportInformationRequestResponse } from '../../entity/support-info-request-response';
import { SupportsService } from '../../services/supports.service';

@Component({
  selector: 'app-add-support-info',
  templateUrl: './add-support-info.component.html',
  styleUrls: ['./add-support-info.component.scss']
})
export class AddSupportInfoComponent implements OnInit {
  addSupportForm: FormGroup;
  isSubmited = false;
  noData = false;
  buttonText = 'update';
  supportInformation: SupportInformationRequest;

  constructor(private supportService: SupportsService,
              private toaster: ToastrService) { }


  ngOnInit(): void {
    this.addSupportForm = new FormGroup({
      phone: new FormControl('', Validators.required),
      phone2: new FormControl('', Validators.required),
      whatsapp: new FormControl('', Validators.required),
      fax: new FormControl('', Validators.required),
      bank: new FormControl('', Validators.required),
      stc: new FormControl('', Validators.required),
      email: new FormControl('', [Validators.required, Validators.email])
    });
    // run to get support data
    this.getSupportInformation();
  }


  // Get Support Information Data
  getSupportInformation() {
    this.supportService.getSupportInformation().subscribe(
      (data: SupportInformationRequestResponse) => {
        console.log('data', data);
        this.noData = false;
        this.supportInformation = data.Data[0];
        this.fillingFormInputs(data.Data[0]);
      }, error => this.handleError(error)
    );
  }


  handleError(error) {
    console.log('status code 404', error?.error?.status_code == '404');
    if (error) {
      if (error?.error?.status_code == '404') {
        this.noData = true;
        this.buttonText = 'create';
      }
    }
  }

  fillingFormInputs(data: SupportInformationRequest) {
    this.addSupportForm = new FormGroup({
      id: new FormControl(data.id),
      phone: new FormControl(data.phone, Validators.required),
      phone2: new FormControl(data.phone2, Validators.required),
      whatsapp: new FormControl(data.whatsapp, Validators.required),
      fax: new FormControl(data.fax, Validators.required),
      bank: new FormControl(data.bank, Validators.required),
      stc: new FormControl(data.stc, Validators.required),
      email: new FormControl(data.email, [Validators.required, Validators.email])
    });
  }

  onSubmit() {
    this.isSubmited = true;
    if (!this.addSupportForm.valid) {
      this.toaster.error('Form Not Valid !');
      this.isSubmited = false;
      return;
    }
    const formObject = this.addSupportForm.getRawValue();
    if (this.noData) {
      this.supportService.createSupportInformation(formObject).subscribe(
        data => {
          this.isSubmited = false;
          this.buttonText = 'update';
          this.toaster.success('Create Successfully');
          console.log('Create Data', data);
          this.getSupportInformation();
        }
      );
    } else {
      this.supportService.updateSupportInformation(formObject).subscribe(
        data => {
          this.isSubmited = false;
          this.toaster.success('Updated Successfully');
          console.log('updated Data', data);
        }
      );
    }
  }

}
