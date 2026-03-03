import { ComponentFixture, TestBed } from '@angular/core/testing';

import { RequestHeader } from './request-header';

describe('RequestHeader', () => {
  let component: RequestHeader;
  let fixture: ComponentFixture<RequestHeader>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [RequestHeader]
    })
    .compileComponents();

    fixture = TestBed.createComponent(RequestHeader);
    component = fixture.componentInstance;
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
