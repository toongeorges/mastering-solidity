import { Component, Inject } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { MaterialDesignModule } from '../../../modules/material-design/material-design.module';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import { ProgressSpinnerService } from '../../../services/progress-spinner.service';
import { ethers } from 'ethers';

export interface MintData {
  address: string;
  name: string;
  symbol: string;
  amount: string;
  contract: ethers.Contract;
  onMint: () => void;
}

@Component({
  selector: 'app-mint-dialog',
  standalone: true,
  imports: [
    FormsModule,
    MaterialDesignModule
  ],
  templateUrl: './mint-dialog.component.html',
  styleUrl: './mint-dialog.component.scss'
})
export class MintDialogComponent {
  constructor(
    public dialogRef: MatDialogRef<MintDialogComponent>,
    @Inject(MAT_DIALOG_DATA) public data: MintData,
    private progressSpinnerService: ProgressSpinnerService
  ) {}

  onMint() {
    this.dialogRef.close();
    console.log(`minted ${this.data.amount} tokens`);
  }

  onCancel() {
    this.dialogRef.close();
  }
}
