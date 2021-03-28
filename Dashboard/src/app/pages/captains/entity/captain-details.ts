export interface CaptainDetails {
    id: number;
    name: string;
    age: number;
    bounce: number;
    captainID: string;
    car: string;
    countOrdersDeliverd: [{countOrdersDeliverd: number}];
    drivingLicence: string;
    image: string;
    isOnline: string;
    location: string;
    rating: { rate: number };
    salary: number;
    state: string;
    status: string;
    uuid: string;
    totalBounce: {
        NetProfit: number;
        bank: string;
        bounce: number;
        countOrdersDeliverd: number;
        payments: [];
        sumPayments: string;
        total: number;
    };
    accountID: string;
    bankName: string;
    stcPay: string;
}
