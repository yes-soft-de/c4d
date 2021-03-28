import {Component, EventEmitter, OnInit, Output} from '@angular/core';
import {FormControl, FormGroup, Validators} from '@angular/forms';
import {CaptainsService} from '../../../services/captains.service';
import {ToastrService} from 'ngx-toastr';
import {ActivatedRoute, Router} from '@angular/router';

@Component({
  selector: 'app-add-term',
  templateUrl: './add-term.component.html',
  styleUrls: ['./add-term.component.scss']
})
export class AddTermComponent implements OnInit {
  addTermForm: FormGroup;
  isSubmited = false;

  constructor(private captainService: CaptainsService,
              private router: Router,
              private activatedRoute: ActivatedRoute,
              private toaster: ToastrService) { }


  ngOnInit(): void {
    this.addTermForm = new FormGroup({
      content: new FormControl('', Validators.required)
    });
  }

  onSubmit() {
        // this.router.navigate(['../'], {relativeTo: this.activatedRoute});
    this.isSubmited = true;
    if (!this.addTermForm.valid) {
      this.toaster.error('Form Not Valid !');
      this.isSubmited = false;
      return;
    }
    const formObject = this.addTermForm.getRawValue();
    this.captainService.postTermCaptain(formObject).subscribe(
      data => {
        this.addTermForm.reset();
        this.isSubmited = false;
        this.toaster.success('Created Successfully');
        console.log('Create Data', data);
        this.router.navigate(['../'], {relativeTo: this.activatedRoute});
      }
    );
  }


}
