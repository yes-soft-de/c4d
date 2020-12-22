import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { ContractsDashboardComponent } from './contracts-dashboard.component';

describe('ContractsDashboardComponent', () => {
  let component: ContractsDashboardComponent;
  let fixture: ComponentFixture<ContractsDashboardComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ ContractsDashboardComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ContractsDashboardComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
