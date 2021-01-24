import { ComponentFixture, TestBed } from '@angular/core/testing';

import { CaptainsComponent } from './captains.component';

describe('CaptainsComponent', () => {
  let component: CaptainsComponent;
  let fixture: ComponentFixture<CaptainsComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ CaptainsComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(CaptainsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
