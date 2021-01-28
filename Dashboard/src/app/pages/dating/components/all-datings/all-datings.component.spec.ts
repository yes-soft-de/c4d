import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AllDatingsComponent } from './all-datings.component';

describe('AllDatingsComponent', () => {
  let component: AllDatingsComponent;
  let fixture: ComponentFixture<AllDatingsComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ AllDatingsComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(AllDatingsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
