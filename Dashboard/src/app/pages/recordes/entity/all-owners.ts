export interface AllOwners {
    id: number;
    userName: string;
    branchCity: string;
    branchcount: string;
    brancheName: string;
    captainName: string;
    date: { timestamp: number };
    destination: [string]
    free: boolean;
    fromBranch: number;
    image: string;
    location: [string]
    payment: string;
    source: [string];
    status: string;
    captainID: string;
    orderID: number;
    userID: string;
}