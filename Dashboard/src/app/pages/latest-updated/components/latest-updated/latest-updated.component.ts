import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { ToastrService } from 'ngx-toastr';
import { LatestUpdated } from '../../entity/latest-updated';
import { LatestUpdatedResponse } from '../../entity/latest-updated-response';
import { LatestUpdatedsService } from '../../services/latest-updateds.service';

@Component({
  selector: 'app-latest-updated',
  templateUrl: './latest-updated.component.html',
  styleUrls: ['./latest-updated.component.scss']
})
export class LatestUpdatedComponent implements OnInit {
  uploadForm: FormGroup;
  latestUpdated: LatestUpdated[];
  latestUpdatedList: LatestUpdated[] = [];
  buttonText = 'send';
  isSubmitted = false;
  isUpdated = false;
  config: any;
  noData = false;

  constructor(private latestUpdatedService: LatestUpdatedsService,
              private toaster: ToastrService) { }

  ngOnInit(): void {
    // init reactive form
    this.uploadForm = new FormGroup({
      title: new FormControl('', Validators.required),
      content: new FormControl('', Validators.required)
    });

    this.getAllUpdated();
  }

  // get all latest udpated
  getAllUpdated() {
    this.latestUpdatedService.getLatestUpdated().subscribe(
      (data: LatestUpdatedResponse) => {
        if (data) {
          this.noData = false;
          this.latestUpdated = data.Data.reverse();
          this.latestUpdatedList = this.latestUpdated;
          console.log(data);
        }
      }, error => this.handleError(error),
      () => {
        this.config = {
          itemsPerPage: 5,
          currentPage: 1,
          totalItems: this.latestUpdatedList.length
        };
      }
    );
  }

  handleError(error) {
    console.log('status code 404', error.error.status_code == '404');
    if (error) {
      if (error.error.status_code == '404') {
        this.noData = true;
      }
    }
  }

  // detatch page changed
  pageChanged(event) {
    this.config.currentPage = event;
  }

  // fill the form
  fillingForm(data: LatestUpdated) {
    this.isUpdated = true;
    this.buttonText = 'update';
    // init reactive form
    this.uploadForm = new FormGroup({
      id: new FormControl(data.id),
      title: new FormControl(data.title, Validators.required),
      content: new FormControl(data.content, Validators.required)
    });
  }

  onSubmit() {
    this.isSubmitted = true;
    if (!this.uploadForm.valid) {
      this.toaster.error('Form Not Valid');
      this.isSubmitted = false;
      return;
    }
    const formObject = this.uploadForm.getRawValue();
    if (this.isUpdated) {
      this.latestUpdatedService.updateLatestUpdate(formObject).subscribe(
        data => {
          console.log('data updated', data);
          this.toaster.success('Updated Successfully');
          this.isSubmitted = false;
          // make update to false
          this.isUpdated = false;
          // change button text
          this.buttonText = 'send';
          // rerender all latest update table
          this.getAllUpdated();
          // empty form fields
          this.uploadForm.reset();
        }
        );
      } else {
        this.latestUpdatedService.createLatestUpdate(formObject).subscribe(
          data => {
            this.toaster.success('Created Successfully');
            this.isSubmitted = false;
            // rerender all latest update table
            this.getAllUpdated();
            // empty form fields
            this.uploadForm.reset();
          }
        );
    }

  }

}
