export interface PaymentsOfOwner {
    amount: string; 
    date: { timestamp: number };
    sumPayments: string;
    totalAmountOfSubscriptions: number;
    currentTotal: number;
    bankName: string;
    accountID: string;
    payments: {
        id: number; 
        captainId: string; 
        amount: number;
        date: { timestamp: number }
    }[];
    bank: {
        id: number;
        userID: string;
        bankName: string;
        accountID: string;
        userName: string;
        stcPay: string;
    }
    nextPay: string;
}