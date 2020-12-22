import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
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

  constructor(private captainService: CaptainsService,
              private router: Router,
              private activateRoute: ActivatedRoute) { }

  ngOnInit() {
    console.log('detail');
    this.captainService.captainDetails(Number(this.activateRoute.snapshot.paramMap.get('id')))
      .pipe(takeUntil(this.destroy$))
      .subscribe(
        (captainDetail: CaptianDetailsResponse) => {
          if (captainDetail) {
            console.log('Captain Details: ', captainDetail);
            this.captainDetails = captainDetail.Data;
          }
        },
        error => console.log('Error : ', error)
      );
  }

}
