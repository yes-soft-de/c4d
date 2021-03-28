import { Component, OnInit } from '@angular/core';
import {FormControl, FormGroup, Validators} from '@angular/forms';
import {CaptainsService} from '../../../services/captains.service';
import {ActivatedRoute, Router} from '@angular/router';
import {ToastrService} from 'ngx-toastr';
import {SupportInformationRequest} from '../../../../supports/entity/support-info-request';

@Component({
  selector: 'app-update-term',
  templateUrl: './update-term.component.html',
  styleUrls: ['./update-term.component.scss']
})
export class UpdateTermComponent implements OnInit {
  updateTermForm: FormGroup;
  isSubmited = false;
  termsCaptain: {content: string};

  constructor(private captainService: CaptainsService,
              private router: Router,
              private activatedRoute: ActivatedRoute,
              private toaster: ToastrService) { }


  ngOnInit(): void {
    this.activatedRoute.paramMap.subscribe(param => {
      console.log(param.get('id'));
      this.getTermCaptainByID(param.get('id'));
    });
    this.updateTermForm = new FormGroup({
      content: new FormControl('', Validators.required)
    });
  }

  getTermCaptainByID(id) {
      console.log('run');
      this.captainService.getTermCaptainById(id).subscribe(
      (data: {Data: any}) => {
          console.log('d', data);
          this.termsCaptain = data.Data;
          this.fillingFormInputs(data.Data);
        }
      );
  }


  fillingFormInputs(data: {id: string, content: string}) {
    this.updateTermForm = new FormGroup({
      id: new FormControl(data.id),
      content: new FormControl(data.content, Validators.required),
    });
  }

  onSubmit() {
    this.isSubmited = true;
    if (!this.updateTermForm.valid) {
      this.toaster.error('Form Not Valid !');
      this.isSubmited = false;
      return;
    }
    const formObject = this.updateTermForm.getRawValue();
    this.captainService.updateTermCaptain(formObject).subscribe(
      data => {
        this.updateTermForm.reset();
        this.isSubmited = false;
        this.toaster.success('Updated Successfully');
        console.log('Update Data', data);
        this.router.navigate(['../'], {relativeTo: this.activatedRoute});
      }
    );
  }


}
