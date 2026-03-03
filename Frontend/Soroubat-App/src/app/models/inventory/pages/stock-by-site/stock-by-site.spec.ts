import { ComponentFixture, TestBed } from '@angular/core/testing';

import { StockBySite } from './stock-by-site';

describe('StockBySite', () => {
  let component: StockBySite;
  let fixture: ComponentFixture<StockBySite>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [StockBySite]
    })
    .compileComponents();

    fixture = TestBed.createComponent(StockBySite);
    component = fixture.componentInstance;
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
