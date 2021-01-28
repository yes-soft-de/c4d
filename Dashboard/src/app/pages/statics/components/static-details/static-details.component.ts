import { DOCUMENT } from '@angular/common';
import { Component, ElementRef, Inject, OnDestroy, OnInit, ViewChild } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
import { ChartType, getPackageForChart, ScriptLoaderService } from 'angular-google-charts';
import { ToastrService } from 'ngx-toastr';
import { interval, Subject } from 'rxjs';
import { takeUntil } from 'rxjs/operators';
import { StaticsService } from '../../services/statics.service';

@Component({
  selector: 'app-static-details',
  templateUrl: './static-details.component.html',
  styleUrls: ['./static-details.component.scss']
})
export class StaticDetailsComponent implements OnInit, OnDestroy {
  private destroy$: Subject<void> = new Subject();
  statisticForm: FormGroup;
  user: string;
  userId: number;
  isChartExists = false;
  statisticsDetails: any[];
  intervalCounter: any;
  chartData = [];
  chartColumns = ['Count Orders In Day', 'Month'];
  // example
  myOptions = {
    colors: ['#457b9d'],
    is3D: true,
    // backgroundColor: {
    //   fill: '#457b9d'
    // }
  };
  chart = {
    type: 'ColumnChart',
    data: this.chartData,
    columnNames: this.chartColumns,
    options: this.myOptions  
  };

  constructor(private staticService: StaticsService,
              private loaderService: ScriptLoaderService,
              private activatedRoute: ActivatedRoute,
              private formBuilder: FormBuilder,
              private toaster: ToastrService,
              @Inject(DOCUMENT) private document: Document) { }

  ngOnInit(): void {    
    this.statisticForm = this.formBuilder.group({
      selectDate: [''],
    });

    this.activatedRoute.params.subscribe(
      params => {
        this.user = params.user;
        this.userId = params.userId;
        console.log(this.user, this.userId);
        // Get Statistics
        this.getStatistic();
      }
    );
  }


  // Get Captian Statistic
  getStatistic(year = new Date().getUTCFullYear().toString(), 
               month = (new Date().getUTCMonth() + 1).toString()) {
    this.staticService.statisticDetails(year, month, this.userId, this.user)
    .pipe(takeUntil(this.destroy$))
    .subscribe(
      statisticsResponse => {
        if (statisticsResponse) {
          console.log('Statistics details', statisticsResponse.Data);
          this.statisticsDetails = statisticsResponse;
          // clear the cart data array 
          statisticsResponse.Data[1].map(e => {
            this.chartData.push([e.countOrdersInDay.toString(), (new Date(e.date.timestamp).getUTCMonth() + 1)]);
          });
        }
      }, error => console.log('Error :', error),
      () => {
        // Check If Chart Data Is Not Empty
        if (this.chartData.length !== 0) {
          console.log('chartData', this.chartData);
          // Element Exists Check
          this.isElementExists();
        }
      }
    )
  }


  changeDate(event) {
    // empty the chart data array
    this.chartData = [];
    const selectedMonth = (new Date(event.target.value).getUTCMonth() + 1).toString();
    const currentYear = new Date(event.target.value).getUTCFullYear().toString();
    console.log(selectedMonth, currentYear);
    this.getStatistic(currentYear, selectedMonth);
  }


  // Check If Chart Element Exists
  isElementExists() {
    let second = 0;
    this.intervalCounter = setInterval(() => {
      second++;
      const chartElement = this.document.querySelector('.google-chart div');
      this.isChartExists = false;
      console.log('Google Chart Is Rendering');
      // after 10 second display new message to user
      if (second == 50) {
          // Check IF Chart Is Exists Or Not
          this.toaster.success('Google Chart Is Rendering, Please Wait');
      }
      if (second == 200) {
        // Check IF Chart Is Exists Or Not
        this.toaster.success('You have a slow network, Please Wait');
      }
      if (chartElement) {
        console.log('Chart is exists');
        this.isChartExists = true;
        second = 0;
        clearInterval(this.intervalCounter);
      }
    }, 100);
  }


  // Handle Response Error
  handleError(error) {
    // this.isClicked = false;
    console.log(error);
    if (error.error.error) {
      this.toaster.error(error.error.error);
    } else if (error.error.msg) {
      this.toaster.error(error.error.msg);
    }
  }

  
  ngOnDestroy() {
    // Clear Interval
    clearInterval(this.intervalCounter);
    // Destory Observable
    this.destroy$.next();
    this.destroy$.complete();
  }

}
