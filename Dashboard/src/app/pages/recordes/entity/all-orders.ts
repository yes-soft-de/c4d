export interface AllOrders {
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
    }[];
    date: { timestamp: number };
    destination: [string];
    fromBranch: {brancheName: string};
    branchCity: string;
    brancheName: string;    
    location: string;
    kilometer: string;
    note: string;
    payment: string;
    recipientName: string;
    recipientPhone: string;
    record: {
        id: number; 
        orderID: string;
        state: string; 
        startTime: { timestamp: number }
    };
    source: [string];
    state: string;
    updateDate: { timestamp: number };
    ownerID: string;
    uuid: null
}