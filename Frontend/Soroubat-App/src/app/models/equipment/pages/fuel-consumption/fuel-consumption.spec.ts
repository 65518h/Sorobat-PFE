import { ComponentFixture, TestBed } from '@angular/core/testing';

import { FuelConsumption } from './fuel-consumption';

describe('FuelConsumption', () => {
  let component: FuelConsumption;
  let fixture: ComponentFixture<FuelConsumption>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [FuelConsumption]
    })
    .compileComponents();

    fixture = TestBed.createComponent(FuelConsumption);
    component = fixture.componentInstance;
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
