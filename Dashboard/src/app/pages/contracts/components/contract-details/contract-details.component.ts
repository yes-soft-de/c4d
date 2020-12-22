import { DatePipe } from '@angular/common';
import { Component, ElementRef, OnInit, ViewChild } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Subject } from 'rxjs';
import { takeUntil } from 'rxjs/operators';
import { HelperService } from 'src/app/@theme/helper/helper.service';
import { ContractDetailsResponse } from '../../entity/contract-details-response';
import { Contracts } from '../../entity/contracts';
import { ContractsService } from '../../services/contracts.service';

@Component({
  selector: 'app-contract-details',
  templateUrl: './contract-details.component.html',
  styleUrls: ['./contract-details.component.scss'],
  providers: [DatePipe]
})
export class ContractDetailsComponent implements OnInit {
  @ViewChild('textarea') textarea: ElementRef;
  private destroy$: Subject<void> = new Subject<void>();
  contractDetails: Contracts;
  active = true;

  constructor(private contractService: ContractsService,
              private datePipe: DatePipe,
              private activateRoute: ActivatedRoute) { }

  ngOnInit() {
    this.getContractDetails();
  }

  getContractDetails() {
    this.contractService.contractDetails(Number(this.activateRoute.snapshot.paramMap.get('id')))
      .pipe(takeUntil(this.destroy$))
      .subscribe(
        (contractDetail: ContractDetailsResponse) => {
          if (contractDetail) {
            console.log('Contract Details: ', contractDetail);
            this.contractDetails = contractDetail.Data[0];
          }
        },
        error => console.log('Error : ', error)
      );
  }

  acceptContract(state: string, id: number) {
    this.active = false;
    const startDate = new Date(this.contractDetails.startDate.timestamp * 1000);
    const dateAfterOneMonth = startDate.setMonth(startDate.getMonth() + 1);
    const data = {
      id: id,
      status: state,
      endDate: this.datePipe.transform(dateAfterOneMonth, 'yyyy-MM-dd'),
      note: this.textarea.nativeElement.value
    };

    this.contractService.contractAccept(data).subscribe(
      acceptResponse => {
        this.active = true;
        console.log(acceptResponse);
        this.getContractDetails();
      }, error => {
        console.log(error);
        this.active = true;
      }
    );
  }



}
