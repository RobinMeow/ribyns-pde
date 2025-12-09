import { Component, signal } from '@angular/core';
import { RouterOutlet } from '@angular/router';

@Component({ selector: 'test', imports: [], template:`test works!`, styles:[] }) export class Test{}
@Component({
  selector: 'app-root',
  imports: [RouterOutlet, Test],
  template: `
    <h1>Welcome to {{ title() }}!</h1>

    <test />
    <router-outlet />
  `,
  styles: [],
})
export class App {
  protected readonly title = computed();
}
