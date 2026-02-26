import { TestBed } from '@angular/core/testing';
import { provideHttpClient } from '@angular/common/http';
import { provideHttpClientTesting, HttpTestingController } from '@angular/common/http/testing';

import { JobTaskService } from './job-task';
import { JobTask } from '../models/job-task.model'; 
describe('JobTaskService', () => {
  let service: JobTaskService;
  let httpMock: HttpTestingController;

  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [JobTaskService, provideHttpClient(), provideHttpClientTesting()],
    });
    service = TestBed.inject(JobTaskService);
    httpMock = TestBed.inject(HttpTestingController);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });

  afterEach(() => {
    httpMock.verify(); 
  });
});
