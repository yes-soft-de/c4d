export interface CaptainTotalBounce {
    NetProfit: number;
    bank: {
        id: number;
        userID: string;
        bankName: string;
        accountID: string;
        userName: string;
        stcPay: string;
    }
    bounce: number;
    countOrdersDeliverd: number;
    payments: {
        id: number; 
        captainId: string; 
        amount: number;
        date: { timestamp: number }
    }[];
    sumPayments: null
    total: number;

}