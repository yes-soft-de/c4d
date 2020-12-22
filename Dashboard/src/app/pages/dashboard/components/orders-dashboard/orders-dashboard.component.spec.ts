import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { OrdersDashboardComponent } from './orders-dashboard.component';

describe('OrdersDashboardComponent', () => {
  let component: OrdersDashboardComponent;
  let fixture: ComponentFixture<OrdersDashboardComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ OrdersDashboardComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(OrdersDashboardComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
