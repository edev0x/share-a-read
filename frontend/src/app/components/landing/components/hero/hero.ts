import { ZardButtonComponent } from '@/shared/components/button';
import { Component } from '@angular/core';

@Component({
  selector: 'app-hero',
  imports: [ZardButtonComponent],
  templateUrl: './hero.html',
  styleUrl: './hero.css',
})
export class Hero {}
