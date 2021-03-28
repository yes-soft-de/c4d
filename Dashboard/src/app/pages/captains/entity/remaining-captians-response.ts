import { CaptainDetails } from "./captain-details";

export interface RemainingCaptainsResponse {
    Data: {
        response: CaptainDetails[];
    }
}