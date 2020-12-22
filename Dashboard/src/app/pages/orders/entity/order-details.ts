export interface OrderDetails {
    id: number;
    acceptedOrder: Array<any>;
    date: { timestamp: number };
    destination: [string];
    fromBranch: string;
    note: string;
    payment: string;
    recipientName: string;
    recipientPhone: string;
    source: [string];
    state: string;
    updateDate: { timestamp: number };
}