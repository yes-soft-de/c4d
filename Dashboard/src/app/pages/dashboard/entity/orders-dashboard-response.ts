import { OrdersDashboard } from "./order-dashboard";

export interface OrdersDashboardResponse {
    Data: [
        { countpendingOrders: number; },
        { countOngoingOrders: number; },
        { ordersCount: number; },
        OrdersDashboard
    ];
}