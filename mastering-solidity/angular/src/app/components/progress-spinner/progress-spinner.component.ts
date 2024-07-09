import { Component } from '@angular/core';
import { MaterialDesignModule } from '../../modules/material-design/material-design.module';

@Component({
  selector: 'app-progress-spinner',
  standalone: true,
  imports: [
    MaterialDesignModule
  ],
  templateUrl: './progress-spinner.component.html',
  styleUrl: './progress-spinner.component.scss'
})
export class ProgressSpinnerComponent {

}
