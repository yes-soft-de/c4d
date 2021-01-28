import { ComponentFixture, TestBed } from '@angular/core/testing';

import { TopOwnersComponent } from './top-owners.component';

describe('TopOwnersComponent', () => {
  let component: TopOwnersComponent;
  let fixture: ComponentFixture<TopOwnersComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ TopOwnersComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(TopOwnersComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
