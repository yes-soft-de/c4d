import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AddTermComponent } from './add-term.component';

describe('AddTermComponent', () => {
  let component: AddTermComponent;
  let fixture: ComponentFixture<AddTermComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ AddTermComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(AddTermComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
