import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { CaptainsDashboardComponent } from './captains-dashboard.component';

describe('CaptainsDashboardComponent', () => {
  let component: CaptainsDashboardComponent;
  let fixture: ComponentFixture<CaptainsDashboardComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ CaptainsDashboardComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(CaptainsDashboardComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
