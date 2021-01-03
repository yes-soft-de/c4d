import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Subject } from 'rxjs';
import { takeUntil } from 'rxjs/operators';
import { Packages } from '../../entity/packages';
import { PackagesResponse } from '../../entity/packages-response';
import { PackagesService } from '../../services/packages.service';

@Component({
  selector: 'app-package-details',
  templateUrl: './package-details.component.html',
  styleUrls: ['./package-details.component.scss']
})
export class PackageDetailsComponent implements OnInit {

  // @ViewChild('textarea') textarea: ElementRef;
  private destroy$: Subject<void> = new Subject<void>();
  packageDetails: Packages;
  active = true;

  constructor(private packageService: PackagesService,
              private activateRoute: ActivatedRoute) { }

  ngOnInit() {
    this.getPackageDetails();
  }

  getPackageDetails() {
    this.packageService.packageDetails(Number(this.activateRoute.snapshot.paramMap.get('id')))
      .pipe(takeUntil(this.destroy$))
      .subscribe(
        (packageDetails: PackagesResponse) => {
          if (packageDetails) {
            console.log('Package Details: ', packageDetails);
            this.packageDetails = packageDetails.Data[0];
          }
        },
        error => console.log('Error : ', error)
      );
  }

  acceptPackage(state: string, id: number) {
    this.active = false;
    const data = {
      id: id,
      status: state,
    };
    this.packageService.acceptPackage(data).subscribe(
      acceptResponse => {
        this.active = true;
        console.log(acceptResponse);
        this.getPackageDetails();
      }, error => {
        console.log(error);
        this.active = true;
      }
    );
  }




}
