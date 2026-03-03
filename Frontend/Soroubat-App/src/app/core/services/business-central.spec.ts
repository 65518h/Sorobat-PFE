import { TestBed } from '@angular/core/testing';

import { BusinessCentral } from './business-central';

describe('BusinessCentral', () => {
  let service: BusinessCentral;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(BusinessCentral);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
