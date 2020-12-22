import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { CaptainsDetailsComponent } from './captains-details.component';

describe('CaptainsDetailsComponent', () => {
  let component: CaptainsDetailsComponent;
  let fixture: ComponentFixture<CaptainsDetailsComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ CaptainsDetailsComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(CaptainsDetailsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
