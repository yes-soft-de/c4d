import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { PackagesService } from '../../services/packages.service';

@Component({
  selector: 'app-add-package',
  templateUrl: './add-package.component.html',
  styleUrls: ['./add-package.component.scss']
})
export class AddPackageComponent implements OnInit {
  isSubmitted = false;
  uploadForm: FormGroup;
  fileSelected = false;
  
  constructor(
            private packageService: PackagesService, 
            private formBuilder: FormBuilder,
            private toaster: ToastrService,
            private router: Router,
            private activatedRoute: ActivatedRoute) { }

  ngOnInit(): void {
    // Fetch Form Data
    this.uploadForm = this.formBuilder.group({
      name: ['', Validators.required],
      cost: ['', Validators.required],
      note: [''],
      carCount: ['', Validators.required],
      city: ['', Validators.required],
      orderCount: ['', Validators.required],
      status: ['', Validators.required],
      branch: ['', Validators.required],
    });
  }

  changeStatus(event) {
    this.uploadForm.get('status').setValue(event.target.value, {
      onlySelf : true
    });
  }

  mySubmit() {
    this.isSubmitted = true;
    
    if (!this.uploadForm.valid) {
      this.toaster.error('Error : Form Not Valid');
      return false;
    } else {
      // Fetch All Form Data On Json Type
      const formObject = this.uploadForm.getRawValue();
      console.log(formObject);
      this.packageService.createPackage(formObject).subscribe(
        (createResponse: any) => console.log(createResponse),
        error => {
          this.isSubmitted = false;
          console.log('Error : ', error);
        },
        () => {
          this.router.navigate(['../'], {relativeTo: this.activatedRoute});
        }
      );
    }
  }
}
