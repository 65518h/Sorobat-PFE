import { ComponentFixture, TestBed } from '@angular/core/testing';

import { StockRequest } from './stock-request';

describe('StockRequest', () => {
  let component: StockRequest;
  let fixture: ComponentFixture<StockRequest>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [StockRequest]
    })
    .compileComponents();

    fixture = TestBed.createComponent(StockRequest);
    component = fixture.componentInstance;
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
