import { ComponentFixture, TestBed } from '@angular/core/testing';
import { describe, it, expect, beforeEach } from 'vitest';

import { TaskProgress } from './task-progress';

describe('TaskProgress', () => {
  let component: TaskProgress;
  let fixture: ComponentFixture<TaskProgress>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [TaskProgress]
    })
    .compileComponents();

    fixture = TestBed.createComponent(TaskProgress);
    component = fixture.componentInstance;
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
