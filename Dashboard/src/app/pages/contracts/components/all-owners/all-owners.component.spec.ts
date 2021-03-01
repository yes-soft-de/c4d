import { ComponentFixture, TestBed } from '@angular/core/testing';

import { StoreOwnersComponent } from './store-owners.component';

describe('StoreOwnersComponent', () => {
  let component: StoreOwnersComponent;
  let fixture: ComponentFixture<StoreOwnersComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ StoreOwnersComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(StoreOwnersComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
