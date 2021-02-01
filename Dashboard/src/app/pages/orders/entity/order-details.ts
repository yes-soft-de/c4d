export interface OrderDetails {
    id: number;
    acceptedOrder: {
        id: number; 
        acceptedOrderDate: { timestamp: number };
        captainID: string;
        duration: { timestamp: number };
        state: string;
        captainName: string;
        car: string;
        image: string;
    };
    date: { timestamp: number };
    destination: [string];
    fromBranch: {
        brancheName: string;
        city: string;
        id: number;
        location: {
            lat: number;
            lon: number
        }
    };
    note: string;
    payment: string;
    recipientName: string;
    recipientPhone: string;
    record: [
        {
            id: number; 
            orderID?: string;
            state?: string; 
            date?: { timestamp: number }
        }
    ];
    source: [string];
    state: string;
    updateDate: { timestamp: number };
    uuid: string;
}