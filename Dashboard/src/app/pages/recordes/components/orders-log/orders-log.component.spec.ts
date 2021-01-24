import { ComponentFixture, TestBed } from '@angular/core/testing';

import { OrdersLogComponent } from './orders-log.component';

describe('OrdersLogComponent', () => {
  let component: OrdersLogComponent;
  let fixture: ComponentFixture<OrdersLogComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ OrdersLogComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(OrdersLogComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
