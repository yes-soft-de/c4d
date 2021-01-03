import { NgModule } from '@angular/core';
import { ThemeModule } from 'src/app/@theme/theme.module';

import { MessagesRoutingModule } from './messages-routing.module';
import { ChatComponent } from './components/chat/chat.component';


@NgModule({
  declarations: [ChatComponent],
  imports: [
    ThemeModule,
    MessagesRoutingModule
  ]
})
export class MessagesModule { }
