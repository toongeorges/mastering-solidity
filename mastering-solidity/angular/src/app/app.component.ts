import { Component } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import { MaterialDesignModule } from './modules/material-design/material-design.module';
import { ConnectionBarComponent } from './components/connection-bar/connection-bar.component';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [
    RouterOutlet,
    MaterialDesignModule,
    ConnectionBarComponent
  ],
  templateUrl: './app.component.html',
  styleUrl: './app.component.scss'
})
export class AppComponent {
  title = 'angular';
}
