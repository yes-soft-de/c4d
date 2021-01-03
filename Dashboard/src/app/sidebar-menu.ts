export interface SidebarMenuItemsChildren {
    title?: string;
    link?: string;
    value?: string;
}
export interface SidebarMenuItems {
    title?: string;
    id?: string;
    link?: string;
    children?: SidebarMenuItemsChildren[];

}
export const SIDEBAR_MENU_ITEM: SidebarMenuItems[] = [
    {
        title: 'Dashboard',
        id: 'dashboard',
        // link: '/pages/iot-dashboard',
        children: [
            {
                title: 'Captains',
                // link: '/',
                value: 'captain'
            },
            {
                title: 'Order',
                // link: '/',
                value: 'order'
            },
            {
                title: 'Contracts',
                // link: '/',
                value: 'contract'
            },
        ]
    },
    {
        title: 'Captains',
        id: 'captains',
        // link: '/pages/iot-dashboard',
        children: [
            {
                title: 'Ongoing',
                link: '/captains/ongoing',
            },
            {
                title: 'Pending',
                link: '/captains/pending',
            },
            {
                title: 'Day Off',
                link: '/captains/day-off',
            },
        ]
    },
    {
        title: 'Orders',
        id: 'orders',
        children: [
            {
                title: 'Pending',
                link: '/orders/pending',
            },
        ]
    },
    {
        title: 'Contracts',
        id: 'contracts',
        children: [
            {
                title: 'Pending',
                link: '/contracts/pending',
            },
        ]
    },
    {
        title: 'Package',
        id: 'package',
        // link: '/pages/iot-dashboard',
        children: [
            {
                title: 'Add Package',
                link: '/packages/add',
            },
            {
                title: 'Packages',
                link: '/packages',
            },
        ]
    },
];