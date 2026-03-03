import { TestBed } from '@angular/core/testing';

import { PurchaseRequest } from './purchase-request';

describe('PurchaseRequest', () => {
  let service: PurchaseRequest;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(PurchaseRequest);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
