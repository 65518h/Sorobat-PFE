import { ComponentFixture, TestBed } from '@angular/core/testing';

import { StockTransfer } from './stock-transfer';

describe('StockTransfer', () => {
  let component: StockTransfer;
  let fixture: ComponentFixture<StockTransfer>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [StockTransfer]
    })
    .compileComponents();

    fixture = TestBed.createComponent(StockTransfer);
    component = fixture.componentInstance;
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
