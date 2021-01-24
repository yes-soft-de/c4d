export interface OrderLog {
    id: number;
    date: { timestamp: number };
    state: string;
    orderID: string;
}