import { TestBed } from '@angular/core/testing';

import { SeedTokenFactoryService } from './seed-token-factory.service';

describe('SeedTokenFactoryService', () => {
  let service: SeedTokenFactoryService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(SeedTokenFactoryService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
