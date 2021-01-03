import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
import { Observable } from 'rxjs';
import { CaptianDetailsResponse } from 'src/app/pages/captains/entity/captain-details-response';
import { CaptainsService } from 'src/app/pages/captains/services/captains.service';
import { MessagesService } from '../../service/messages.service';

@Component({
  selector: 'app-chat',
  templateUrl: './chat.component.html',
  styleUrls: ['./chat.component.scss']
})
export class ChatComponent implements OnInit {
  messageForm: FormGroup;
  messages$: Observable<any>;

  constructor(private messageService: MessagesService,
              private captainService: CaptainsService,
              private formBuilder: FormBuilder,
              private activatedRoute: ActivatedRoute) { }

  ngOnInit(): void {
    this.captainService.captainDetails(Number(this.activatedRoute.snapshot.paramMap.get('id'))).subscribe(
      (captainResponse: CaptianDetailsResponse) => {
        console.log(captainResponse);
        if (captainResponse.Data.uuid) {
          this.messageService.getMessagesObservable(captainResponse.Data.uuid).subscribe(
            data => console.log('data', data)    
          );
        }
      }
    );
      // this.messages$ = this.messageService.getMessagesObservable('110bd060-4571-11eb-bc5e-0d4e2b107d0c');
      
    // Fetch Form Data
    this.messageForm = this.formBuilder.group({
      // message: ['', Validators.required],
    });


  }

  onSubmit() {

  }

}
