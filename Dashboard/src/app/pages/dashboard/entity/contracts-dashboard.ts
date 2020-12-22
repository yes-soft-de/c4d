export interface ContractsDashboard {
    id: number;
    endDate: { timestamp: number }
    packageName: string;
    packageNote: string;
    startDate: { timestamp: number }
    status: string;
    subscriptionNote: any;
    userName: string;
}