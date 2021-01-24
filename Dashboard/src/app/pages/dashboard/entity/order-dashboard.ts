export interface OrdersDashboard {
    acceptedOrderDate: { timestamp: number };
    captainID: string;
    destination: [string];
    drivingLicence: string;
    duration: { timestamp: number };
    image: string;
    name: string;
    note: string;
    orderDate: { timestamp: number };
    orderID: number;
    ownerID: string;
    fromBranch: { brancheName: string };
    payment: string;
    recipientName: string;
    recipientPhone: string;
    source: [string];
    state: string;
    updateOrderDate: { timestamp: number };
}