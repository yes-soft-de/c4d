import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { ChatComponent } from './components/chat/chat.component';

const routes: Routes = [
  { path: 'view/:client/:id', component: ChatComponent },
  { path: 'view/:client/:id/:uuid', component: ChatComponent }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class MessagesRoutingModule { }
