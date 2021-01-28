import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AllCaptainsComponent } from './all-captains.component';

describe('AllCaptainsComponent', () => {
  let component: AllCaptainsComponent;
  let fixture: ComponentFixture<AllCaptainsComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ AllCaptainsComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(AllCaptainsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
