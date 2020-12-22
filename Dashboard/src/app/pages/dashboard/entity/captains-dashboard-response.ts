import { CaptainsDashboard } from "./captians-dashboard";

export interface CaptainsDashboardResponse {
    Data: [
        { countPendingCaptains: number; },
        { countOngoingCaptains: number; },
        { countDayOfCaptains: number; },
        CaptainsDashboard
    ]
}
