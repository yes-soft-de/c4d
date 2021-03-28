import { ComponentFixture, TestBed } from '@angular/core/testing';

import { LatestUpdatedComponent } from './latest-updated.component';

describe('LatestUpdatedComponent', () => {
  let component: LatestUpdatedComponent;
  let fixture: ComponentFixture<LatestUpdatedComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ LatestUpdatedComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(LatestUpdatedComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
