import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ConnectionBarComponent } from './connection-bar.component';

describe('ConnectionBarComponent', () => {
  let component: ConnectionBarComponent;
  let fixture: ComponentFixture<ConnectionBarComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ConnectionBarComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(ConnectionBarComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
