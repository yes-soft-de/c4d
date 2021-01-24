import { DatePipe, formatDate } from '@angular/common';
import { HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { HelperService } from 'src/app/@theme/helper/helper.service';
import { AdminConfig } from '../../AdminConfig';

@Injectable({
  providedIn: 'root'
})
export class TokenService {
  expireTime = HelperService.timeToMillisecond("02:00:00");
  private iss = {
    //login: AdminConfig.loginAPI,
    username: ''
  };

  constructor() { 
    console.log('Expire Time To Delete Your Token is : ', HelperService.millisecondToTime(this.expireTime));    
  }

  handle(username, token) {
    this.iss.username = username;
    // this.setToken(token);
    this.setTokenWithExpiry("token", token, this.expireTime);
  }

  // Store The Token In The Cookie
  // setToken(token) {
  //   localStorage.setItem('token', token);
  // }

    // GET The Token From The Cookie
  // getToken() {
  //   return localStorage.getItem('token');
  // }

    // Delete The Token From The Cookie
  deleteToken() {
    localStorage.removeItem('token');
  }

  isValid() {
    const token = this.getTokenWithExpiry('token');
    if (token) {
      const payload = this.payload(token);
      return (Object.values(this.iss).indexOf(payload.username) > -1 || token != '') ? true : false;
    }
    return false;
  }

  payload(token) {
    const payload = token.split('.')[1];
    return this.decode(payload);
  }

  // decode the token to fetch the data from it
  decode(payload) {
    return JSON.parse(atob(payload));
  }

  loggedIn() {
    return this.isValid();
  }

  setTokenWithExpiry(key, value, ttl) {
    const now = new Date()
    // `item` is an object which contains the original value
    // as well as the time when it's supposed to expire
    const item = {
      value: value,
      expiry: now.getTime() + ttl,
    }
    localStorage.setItem(key, JSON.stringify(item))
  }


  getTokenWithExpiry(key) {
    const itemStr = localStorage.getItem(key)
    // if the item doesn't exist, return null

    if (!itemStr) {
      return null
    }
    const item = JSON.parse(itemStr)
    const now = new Date()
    // compare the expiry time of the item with the current time
    if (now.getTime() > item.expiry) {
      // If the item is expired, delete the item from storage
      // and return null
      localStorage.removeItem(key)
      return null
    }
    return item.value
  }


  httpOptions() {
    const token = this.getTokenWithExpiry('token');
    if (token) {
      return {
        headers: new HttpHeaders({
          'Content-Type': 'application/json',
          Authorization: `Bearer ` + token
       })
      }
    }    
  }
}
