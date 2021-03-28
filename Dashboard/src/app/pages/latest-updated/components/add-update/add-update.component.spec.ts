import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AddUpdateComponent } from './add-update.component';

describe('AddUpdateComponent', () => {
  let component: AddUpdateComponent;
  let fixture: ComponentFixture<AddUpdateComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ AddUpdateComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(AddUpdateComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
