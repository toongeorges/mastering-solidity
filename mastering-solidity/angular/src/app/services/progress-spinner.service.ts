import { Injectable } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { ProgressSpinnerComponent } from '../components/progress-spinner/progress-spinner.component';

@Injectable({
  providedIn: 'root'
})
export class ProgressSpinnerService {

  constructor(private dialog: MatDialog) {}

  public showSpinnerUntilExecuted(
    promise: Promise<any>,
    onPromiseExecuted: () => void
  ) {
    const dialogRef = this.dialog.open(ProgressSpinnerComponent, {
      panelClass: 'transparent',
      disableClose: true
    });
    promise.then(() => {
      dialogRef.close();
      onPromiseExecuted();
    }).catch((error) => {
      console.error(error.message);
      dialogRef.close();
    });
  }
}
