import { Component, OnInit } from '@angular/core';
import { Action, DocumentSnapshot } from '@angular/fire/firestore';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
import { Observable, Subject } from 'rxjs';
import { CaptianDetailsResponse } from 'src/app/pages/captains/entity/captain-details-response';
import { CaptainsService } from 'src/app/pages/captains/services/captains.service';
import { MessageModel } from '../../model/message-model';
import { MessagesService } from '../../service/messages.service';

@Component({
  selector: 'app-chat',
  templateUrl: './chat.component.html',
  styleUrls: ['./chat.component.scss']
})
export class ChatComponent implements OnInit {
  messageForm: FormGroup;
  messages: MessageModel[];

  constructor(private messageService: MessagesService,
    private captainService: CaptainsService,
    private formBuilder: FormBuilder,
    private activatedRoute: ActivatedRoute) { }

  ngOnInit(): void {
    this.messageService.getMessagesObservable('110bd060-4571-11eb-bc5e-0d4e2b107d0c').subscribe(
      (messages) => {
        this.messages = [];
        messages.docs.forEach(e => {
          this.messages.push(e.data());
        });
      }
    );

    // Fetch Form Data
    this.messageForm = this.formBuilder.group({
      message: ['', Validators.required],
    });


  }

  onSubmit() {
  }
}
