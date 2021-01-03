import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { AppRoutingModule } from './app-routing.module';
import { ThemeModule } from './@theme/theme.module';

import { AppComponent } from './app.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { ToastrModule } from 'ngx-toastr';
import { AngularFireModule } from '@angular/fire';
import { AngularFirestore, AngularFirestoreModule } from '@angular/fire/firestore';
import { AngularFireDatabaseModule } from '@angular/fire/database';
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: "AIzaSyDOAu8tqavfWnEit8vuOr7JyxRt2XHjEcs",
  authDomain: "yes-soft-6866a.firebaseapp.com",
  databaseURL: "https://yes-soft-6866a.firebaseio.com",
  projectId: "yes-soft-6866a",
  storageBucket: "yes-soft-6866a.appspot.com",
  messagingSenderId: "396882908080",
  appId: "1:396882908080:web:e86f986ae56c6070fabc75",
  measurementId: "G-HPC10T199F"
};

@NgModule({
  declarations: [
    AppComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    BrowserAnimationsModule, // required animations module
    ToastrModule.forRoot(), // ToastrModule added
    ThemeModule.forRoot(),
    AngularFireModule.initializeApp(firebaseConfig),
    AngularFirestoreModule,
    AngularFireDatabaseModule,
  ],
  providers: [AngularFirestore],
  exports: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
