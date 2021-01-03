export interface Captains {
    id?: number;
    age?: number;
    bounce?: number;
    captainID?: string;
    car?: string;
    countOrdersDeliverd?: number;
    drivingLicence?: string;
    image?: string;
    location?: string;
    name?: string;
    rating?: { rate: number };
    salary?: number;
    state?: string;
    status?: string;
    totalBounce: { bounce: number }
}