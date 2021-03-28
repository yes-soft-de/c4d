import { Component, OnInit } from '@angular/core';
import {FormControl, FormGroup, Validators} from '@angular/forms';
import {SupportInformationRequest} from '../../../supports/entity/support-info-request';
import {SupportsService} from '../../../supports/services/supports.service';
import {ToastrService} from 'ngx-toastr';
import {SupportInformationRequestResponse} from '../../../supports/entity/support-info-request-response';
import {LatestUpdatedsService} from '../../services/latest-updateds.service';
import {Router} from '@angular/router';

@Component({
  selector: 'app-add-update',
  templateUrl: './add-update.component.html',
  styleUrls: ['./add-update.component.scss']
})
export class AddUpdateComponent implements OnInit {
  addUpdateForm: FormGroup;
  isSubmited = false;

  constructor(private updateService: LatestUpdatedsService,
              private router: Router,
              private toaster: ToastrService) { }


  ngOnInit(): void {
    this.addUpdateForm = new FormGroup({
      title: new FormControl('', Validators.required),
      content: new FormControl('', Validators.required)
    });

  }

  onSubmit() {
    this.isSubmited = true;
    if (!this.addUpdateForm.valid) {
      this.toaster.error('Form Not Valid !');
      this.isSubmited = false;
      return;
    }
    const formObject = this.addUpdateForm.getRawValue();
    this.updateService.createLatestUpdate(formObject).subscribe(
      data => {
        this.isSubmited = false;
        this.toaster.success('Created Successfully');
        this.router.navigate(['updated']);
        console.log('Create Data', data);
      }
    );
  }

}
