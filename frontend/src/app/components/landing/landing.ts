import { Component } from '@angular/core';
import { Navbar } from '@/components/landing/components/navbar/navbar';
import { Features } from '@/components/landing/components/features/features';
import { Hero } from '@/components/landing/components/hero/hero';
import { Footer } from '@/components/landing/components/footer/footer';

@Component({
  selector: 'app-landing',
  imports: [
    Navbar,
    Hero,
    Footer
  ],
  templateUrl: './landing.html',
  styleUrl: './landing.css',
})
export class Landing {
}
