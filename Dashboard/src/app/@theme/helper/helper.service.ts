import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class HelperService {

  constructor() { }



  // the time inserted as : 02:14:30
  public static timeToMillisecond(time) {
    var timeParts = time.split(":");
    let result = (+timeParts[0] * (60000 * 60)) + (+timeParts[1] * 60000) + (+timeParts[2] * 1000);
    return result;
  }


  // Convert millisecond To Time
  public static millisecondToTime(duration: number) {
    let milliseconds = Number((duration % 1000) / 100);
    let seconds: any = Math.floor((duration / 1000) % 60);
    let minutes: any = Math.floor((duration / (1000 * 60)) % 60);
    let hours: any = Math.floor((duration / (1000 * 60 * 60)) % 24);

    hours = (hours < 10) ? "0" + hours : hours;
    minutes = (minutes < 10) ? "0" + minutes : minutes;
    seconds = (seconds < 10) ? "0" + seconds : seconds;
  
    return hours + ":" + minutes + ":" + seconds + "." + milliseconds;
  }


}
