export interface OrderLogRecords {
    id: number;
    date?: { timestamp: number };
    state?: string;
    orderID?: string;
    completionTime?: string;         // 33 minutes 13 seconds
    finalOrder?: string;
    startTime?: { timestamp: number };   
}