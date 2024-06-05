import { ComponentFixture, TestBed } from '@angular/core/testing';

import { NewTokenDialogComponent } from './new-token-dialog.component';

describe('NewTokenDialogComponent', () => {
  let component: NewTokenDialogComponent;
  let fixture: ComponentFixture<NewTokenDialogComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [NewTokenDialogComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(NewTokenDialogComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
