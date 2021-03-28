import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AddSupportInfoComponent } from './add-support-info.component';

describe('AddSupportInfoComponent', () => {
  let component: AddSupportInfoComponent;
  let fixture: ComponentFixture<AddSupportInfoComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ AddSupportInfoComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(AddSupportInfoComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
