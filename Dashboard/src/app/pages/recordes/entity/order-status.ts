export interface OrderStatus {
    id: number;
    completionTime: string;         // 33 minutes 13 seconds
    date: { timestamp: number };
    finalOrder: string;
    orderID: string;
    startTime: string;
    state: string;
}