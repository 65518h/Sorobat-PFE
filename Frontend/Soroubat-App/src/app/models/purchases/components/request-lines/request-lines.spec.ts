import { ComponentFixture, TestBed } from '@angular/core/testing';

import { RequestLines } from './request-lines';

describe('RequestLines', () => {
  let component: RequestLines;
  let fixture: ComponentFixture<RequestLines>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [RequestLines]
    })
    .compileComponents();

    fixture = TestBed.createComponent(RequestLines);
    component = fixture.componentInstance;
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
