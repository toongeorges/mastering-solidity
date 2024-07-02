import { Component, Inject } from '@angular/core';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import { ProgressSpinnerService } from '../../../services/progress-spinner.service';
import { ethers } from 'ethers';
import { FormsModule } from '@angular/forms';
import { MaterialDesignModule } from '../../../modules/material-design/material-design.module';

export interface ChangeOwnerData {
  address: string;
  name: string;
  symbol: string;
  newOwnerAddress: string;
  contract: ethers.Contract;
  onChangeOwner: () => void;
}

@Component({
  selector: 'app-change-owner-dialog',
  standalone: true,
  imports: [
    FormsModule,
    MaterialDesignModule
  ],
  templateUrl: './change-owner-dialog.component.html',
  styleUrl: './change-owner-dialog.component.scss'
})
export class ChangeOwnerDialogComponent {
  constructor(
    public dialogRef: MatDialogRef<ChangeOwnerDialogComponent>,
    @Inject(MAT_DIALOG_DATA) public data: ChangeOwnerData,
    private progressSpinnerService: ProgressSpinnerService
  ) {}

  onChangeOwner() {
    this.dialogRef.close();
  }

  onCancel() {
    this.dialogRef.close();
  }
}
