import { Injectable } from '@angular/core';
import { Subject } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class LayoutService {
  private layout: Subject<any> = new Subject<any>();
  layoutState = this.layout.asObservable();

  constructor() { }

  changeLayout(value) {
    this.layout.next(value);
  }
}
