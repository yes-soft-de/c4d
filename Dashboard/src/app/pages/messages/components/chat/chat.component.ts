import { DOCUMENT } from '@angular/common';
import { Component, Inject, OnDestroy, OnInit, Renderer2 } from '@angular/core';
import { Action, DocumentSnapshot } from '@angular/fire/firestore';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { Observable, pipe, Subject } from 'rxjs';
import { takeUntil, takeWhile } from 'rxjs/operators';
import { CaptianDetailsResponse } from 'src/app/pages/captains/entity/captain-details-response';
import { CaptainsService } from 'src/app/pages/captains/services/captains.service';
import { OrderDetailsResponse } from 'src/app/pages/orders/entity/order-details-response';
import { OrdersService } from 'src/app/pages/orders/services/orders.service';
import { MessageModel } from '../../model/message-model';
import { MessagesService } from '../../service/messages.service';

@Component({
  selector: 'app-chat',
  templateUrl: './chat.component.html',
  styleUrls: ['./chat.component.scss']
})
export class ChatComponent implements OnInit, OnDestroy {
  private destroy$: Subject<void> = new Subject();
  messageForm: FormGroup;
  messages: MessageModel[];
  firstSender: any;
  secondSender: any;


  constructor(private messageService: MessagesService,
    private captainService: CaptainsService,
    private orderService: OrdersService,
    private formBuilder: FormBuilder,
    private toaster: ToastrService,
    private render: Renderer2,
    @Inject(DOCUMENT) private document: Document,
    private activatedRoute: ActivatedRoute) { 
      
    }

  ngOnInit(): void {
    // this.checkMessageBodyScrollHeight();
    // Fetch Form Data
    this.messageForm = this.formBuilder.group({
      message: ['', Validators.required],
      roomId: ['']
    });

    this.activatedRoute.params.subscribe(
      params => {
        if (params.client == 'captain') {
          this.captainService.captainDetails(Number(params.id)).subscribe(
            (captainResponse: CaptianDetailsResponse) => {
              console.log('Captain Room ID', captainResponse.Data.uuid);
              if (captainResponse.Data.uuid) {
                this.getMessages(captainResponse.Data.uuid);
              }
            }
          );
          // this.captainService.captainDetails(Number(params.id))
          // .then((captainResponse: CaptianDetailsResponse) => {
          //     console.log('Promise Captain Room ID', captainResponse.Data.uuid);
          //     if (captainResponse.Data.uuid) {
          //       this.getMessages(captainResponse.Data.uuid);
          //     }
          //   })
          // .catch(error => console.log('Error : ', error));
        }
        if (params.client == 'order') {
          this.orderService.orderDetails(Number(params.id)).subscribe(
            (ordersResponse: OrderDetailsResponse) => {
              if (ordersResponse.Data.uuid) {
                console.log('Order Room ID : ', ordersResponse.Data.uuid);
                this.getMessages(ordersResponse.Data.uuid);
              }
            }
          );
        }
      }
    );

  }


  getMessages(roomId: string) {
    // Check Room Id exists
    if (roomId) {
      this.messageForm.get('roomId').setValue(roomId);
      this.messageService.getMessagesObservable(roomId)
      .pipe(
        takeUntil(this.destroy$))
      .subscribe(
        (messages) => {
          // console.log('messages: ', messages);
          this.messages = [];
          messages.docs.forEach((e, i) => {
            // Get ALl Message by e.data()
            this.messages.push(e.data());
          });
          // Sort Messages Depending On Message Date
          this.messages.sort((a, b) => a.sentDate.localeCompare(b.sentDate));
          // console.log('after sort Messages : ', this.messages);
          // Check if the messages is not empty
          if (this.messages.length > 0) {
            this.secondSender = 'admin';
            for (let i = 0; i < this.messages.length - 1; i++) {
              // check if firstSender And secondSender still empty
              if (this.firstSender == null) {
                // Check if the this sender equal to next sender
                if (this.messages[i].sender != this.secondSender) {
                  this.firstSender = this.messages[i].sender;
                }
              }
              /* Second Way If firstSender And SecondSender is Undefined
              if (this.firstSender == null || this.secondSender == null) {
                // Check if the this sender equal to next sender
                if (this.messages[i].sender == this.messages[i + 1].sender) {
                  this.firstSender = this.messages[i].sender;
                } else {
                  // check if this sender not equal to The stored firstSender
                  if (this.messages[i].sender != this.firstSender) {
                    this.secondSender = this.messages[i].sender;
                  } else {
                    this.secondSender = this.messages[i + 1].sender;
                  }
                }
              }*/
            }}
        }, error => console.log('Error ', error),
        () => {
          // Sort Messages Depending On Message Date
          this.messages.sort((a, b) => a.sentDate.localeCompare(b.sentDate));
          console.log('after sort Messages : ', this.messages);
          // Check if the messages is not empty
          if (this.messages.length > 0) {
            this.secondSender = 'admin';
            for (let i = 0; i < this.messages.length - 1; i++) {
              // check if firstSender And secondSender still empty
              if (this.firstSender == null) {
                // Check if the this sender equal to next sender
                if (this.messages[i].sender != this.secondSender) {
                  this.firstSender = this.messages[i].sender;
                }
              }
              /* Second Way If firstSender And SecondSender is Undefined
              if (this.firstSender == null || this.secondSender == null) {
                // Check if the this sender equal to next sender
                if (this.messages[i].sender == this.messages[i + 1].sender) {
                  this.firstSender = this.messages[i].sender;
                } else {
                  // check if this sender not equal to The stored firstSender
                  if (this.messages[i].sender != this.firstSender) {
                    this.secondSender = this.messages[i].sender;
                  } else {
                    this.secondSender = this.messages[i + 1].sender;
                  }
                }
              }*/
            }
            console.log('firstSender : ', this.firstSender);
            console.log('secondSender : ', this.secondSender);
          }
        }
      );
    }
  }


 /* OLD ONE :
  getMessages(roomId: string) {
    // Check Room Id exists
    if (roomId) {
      this.messageForm.get('roomId').setValue(roomId);
      this.messageService.getMessagesObservable(roomId)
      .pipe(takeUntil(this.destroy$))
      .subscribe(
        (messages) => {
          this.messages = [];
          messages.docs.forEach((e, i) => {
            // Get ALl Message by e.data()
            this.messages.push(e.data());
          });
        }, error => console.log('Error ', error),
        () => {
          // Sort Messages Depending On Message Date
          this.messages.sort((a, b) => a.sentDate.localeCompare(b.sentDate));
          console.log(this.messages);
          // Check if the messages is not empty
          if (this.messages.length > 0) {
            this.secondSender = 'admin';
            for (let i = 0; i < this.messages.length - 1; i++) {          
              // check if firstSender And secondSender still empty
              if (this.firstSender == null) {
                // Check if the this sender equal to next sender
                if (this.messages[i].sender != this.secondSender) {
                  this.firstSender = this.messages[i].sender;
                }
              }
              // Second Way If firstSender And SecondSender is Undefined
              // if (this.firstSender == null || this.secondSender == null) {
              //   // Check if the this sender equal to next sender
              //   if (this.messages[i].sender == this.messages[i + 1].sender) {
              //     this.firstSender = this.messages[i].sender;
              //   } else {
              //     // check if this sender not equal to The stored firstSender
              //     if (this.messages[i].sender != this.firstSender) {
              //       this.secondSender = this.messages[i].sender;
              //     } else {
              //       this.secondSender = this.messages[i + 1].sender;
              //     }
              //   }
              // }
            }
            console.log(this.firstSender);
            console.log(this.secondSender);
          }
        }
      );
    }
  }*/


  // Scroll to latest message when messages display
  checkMessageBodyScrollHeight() {
    const elementExists = setInterval(() => {
      const messageBody = this.document.querySelector('.messages-body');
      if (messageBody.scrollHeight > 40) {
        messageBody.scrollTop = messageBody.scrollHeight;
        clearInterval(elementExists);
      }
    }, 100);
  }

  checkMessageDirectionForRtl() {
    if (true) {
      const elementExists = setInterval(() => {
        const messageBody = this.document.querySelector('.messages-body');
        if (messageBody.scrollHeight > 40) {
          messageBody.scrollTop = messageBody.scrollHeight;
          clearInterval(elementExists);
        }
      }, 100);
    }
  }
  
  
  ngOnDestroy() {
    this.destroy$.next();
    this.destroy$.complete();
  }

  onSubmit() {
    if (!this.messageForm.valid) {
      this.toaster.error('Error : Can\'t Send An Empty Message');
    } else {
      const formMessages = this.messageForm.getRawValue();
      console.log(formMessages);
      if (formMessages.roomId) {
        this.messageService.sendMessage(formMessages.roomId, formMessages.message, 'admin');
      } else {
        this.toaster.error('Error, Please Try Later');
      }
      this.messageForm.reset();
      this.getMessages(formMessages.roomId);
    }
  }
}
