import { ComponentFixture, TestBed } from '@angular/core/testing';

import { TopCaptainsComponent } from './top-captains.component';

describe('TopCaptainsComponent', () => {
  let component: TopCaptainsComponent;
  let fixture: ComponentFixture<TopCaptainsComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ TopCaptainsComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(TopCaptainsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
