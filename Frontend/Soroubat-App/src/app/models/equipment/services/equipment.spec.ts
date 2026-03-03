import { TestBed } from '@angular/core/testing';

import { Equipment } from './equipment';

describe('Equipment', () => {
  let service: Equipment;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(Equipment);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
