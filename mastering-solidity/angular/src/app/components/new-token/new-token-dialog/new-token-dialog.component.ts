import { Component, Inject } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { MaterialDesignModule } from '../../../modules/material-design/material-design.module';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';

export interface NewToken {
  name: string;
  symbol: string;
  onCreateNewToken: () => void;
}

@Component({
  selector: 'app-new-token-dialog',
  standalone: true,
  imports: [
    FormsModule,
    MaterialDesignModule
  ],
  templateUrl: './new-token-dialog.component.html',
  styleUrl: './new-token-dialog.component.scss'
})
export class NewTokenDialogComponent {
  constructor(
    public dialogRef: MatDialogRef<NewTokenDialogComponent>,
    @Inject(MAT_DIALOG_DATA) public data: NewToken
  ) {}

  onCreate() {
    this.dialogRef.close();
  }

  onCancel() {
    this.dialogRef.close();
  }
}
