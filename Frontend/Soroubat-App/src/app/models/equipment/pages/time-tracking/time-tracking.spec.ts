import { ComponentFixture, TestBed } from '@angular/core/testing';

import { TimeTracking } from './time-tracking';

describe('TimeTracking', () => {
  let component: TimeTracking;
  let fixture: ComponentFixture<TimeTracking>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [TimeTracking]
    })
    .compileComponents();

    fixture = TestBed.createComponent(TimeTracking);
    component = fixture.componentInstance;
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
