import { NgModule } from '@angular/core';
import { ThemeModule } from 'src/app/@theme/theme.module';

import { MessagesRoutingModule } from './messages-routing.module';
import { ChatComponent } from './components/chat/chat.component';
import { DatePipe } from '@angular/common';
import { MessagesService } from './service/messages.service';


@NgModule({
  declarations: [ChatComponent],
  imports: [
    ThemeModule,
    MessagesRoutingModule
  ],
  providers: [MessagesService, DatePipe]
})
export class MessagesModule { }
