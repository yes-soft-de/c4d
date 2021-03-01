import { DatePipe } from '@angular/common';
import { Injectable } from '@angular/core';
import { Action, AngularFirestore, DocumentChangeAction, DocumentChangeType, DocumentSnapshot, QuerySnapshot } from '@angular/fire/firestore';
import { interval, Observable } from 'rxjs';
import { startWith, switchMap } from 'rxjs/operators';
import { MessageModel } from '../model/message-model';

@Injectable({
  providedIn: 'root'
})
export class MessagesService {

  constructor(private datePipe: DatePipe,
              private firestore: AngularFirestore) { }

  // This sends the message
  sendMessage(chatRoomId: string, message: string, clientId: string): void {
    const chatMsg: MessageModel = {
      msg: {message: message},
      sender: clientId,
      sentDate: this.datePipe.transform(new Date(), 'yyyy-MM-ddTHH:mm:ss', 'TZD').toString()
      // sentDate: Date.now().toString()
    };
    this.firestore.collection('chat_rooms')
      .doc(chatRoomId)
      .collection('messages').add(chatMsg);
  }

  // This Listens to messages changes in the chat room
  getMessagesObservable(chatRoomId: string): Observable<QuerySnapshot<any>> {
    if (chatRoomId) {
      return interval(1000).pipe(
        startWith(0),
        switchMap(() => this.firestore.collection('chat_rooms')
          .doc(chatRoomId).collection('messages').get())
      );
      //  OLD ONE :
      // return this.firestore.collection('chat_rooms')
      //   .doc(chatRoomId).collection('messages').get();
    }
  }
}
