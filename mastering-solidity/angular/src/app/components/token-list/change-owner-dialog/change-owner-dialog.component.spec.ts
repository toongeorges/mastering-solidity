import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ChangeOwnerDialogComponent } from './change-owner-dialog.component';

describe('ChangeOwnerDialogComponent', () => {
  let component: ChangeOwnerDialogComponent;
  let fixture: ComponentFixture<ChangeOwnerDialogComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ChangeOwnerDialogComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(ChangeOwnerDialogComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
