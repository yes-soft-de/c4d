import { ContractsDashboard } from "./contracts-dashboard";

export interface ContractsDashboardResponse {
    Data: [
        { countPendingContracts: number; },
        { countDoneContracts: number; },
        { NewUsersThisMonth: number; },
        ContractsDashboard
    ];
}