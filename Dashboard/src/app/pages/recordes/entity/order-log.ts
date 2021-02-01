import { OrderLogRecords } from "./order-log-records";
import { OrderStatus } from "./order-status";

export interface OrderLog {
    orderStatus: OrderStatus;
    record: OrderLogRecords[];
}