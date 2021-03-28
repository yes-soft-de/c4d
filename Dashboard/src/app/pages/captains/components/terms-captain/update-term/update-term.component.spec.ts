import { ComponentFixture, TestBed } from '@angular/core/testing';

import { UpdateTermComponent } from './update-term.component';

describe('UpdateTermComponent', () => {
  let component: UpdateTermComponent;
  let fixture: ComponentFixture<UpdateTermComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ UpdateTermComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(UpdateTermComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
