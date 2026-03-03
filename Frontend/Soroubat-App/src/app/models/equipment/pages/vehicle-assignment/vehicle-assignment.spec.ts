import { ComponentFixture, TestBed } from '@angular/core/testing';

import { VehicleAssignment } from './vehicle-assignment';

describe('VehicleAssignment', () => {
  let component: VehicleAssignment;
  let fixture: ComponentFixture<VehicleAssignment>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [VehicleAssignment]
    })
    .compileComponents();

    fixture = TestBed.createComponent(VehicleAssignment);
    component = fixture.componentInstance;
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
