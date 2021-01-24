export interface SidebarMenuItemsChildren {
    title?: string;
    link?: string;
    translate?: string;
    value?: string;
}
export interface SidebarMenuItems {
    title?: string;
    id?: string;
    link?: string;
    children?: SidebarMenuItemsChildren[];
    translate?: string;
    icon?: string;
}
export const SIDEBAR_MENU_ITEM: SidebarMenuItems[] = [
    {
        title: 'Dashboard',
        id: 'dashboard',
        translate: 'dashboard',
        icon: 'fa fa-tachometer',
        // link: '/pages/iot-dashboard',
        children: [
            {
                title: 'Captains',
                translate: 'captains',
                // link: '/',
                value: 'captain'
            },
            {
                title: 'Order',
                translate: 'order',
                // link: '/',
                value: 'order'
            },
            {
                title: 'Contracts',
                translate: 'contracts',
                // link: '/',
                value: 'contract'
            },
        ]
    },
    {
        title: 'Captains',
        id: 'captains',
        translate: 'captains',
        icon: 'fa fa-users',
        // link: '/pages/iot-dashboard',
        children: [
            {
                title: 'Ongoing',
                translate: 'ongoing',
                link: '/captains/ongoing',
            },
            {
                title: 'Pending',
                translate: 'pending',
                link: '/captains/pending',
            },
            {
                title: 'Day Off',
                translate: 'day-off',
                link: '/captains/day-off',
            },
        ]
    },
    {
        title: 'Orders',
        id: 'orders',
        translate: 'orders',
        icon: 'fa fa-tags',
        children: [
            {
                title: 'Pending',                
                translate: 'pending',
                link: '/orders/pending',
            },
        ]
    },
    {
        title: 'Contracts',
        translate: 'contracts',
        id: 'contracts',
        icon: 'fa fa-shopping-bag',
        children: [
            {
                title: 'Pending',                
                translate: 'pending',
                link: '/contracts/pending',
            },
        ]
    },
    {
        title: 'Package',
        id: 'package',
        translate: 'package',
        icon: 'fa fa-suitcase',
        // link: '/pages/iot-dashboard',
        children: [
            {
                title: 'Add Package',
                translate: 'add-package',
                link: '/packages/add',
            },
            {
                title: 'Packages',
                translate: 'packages',
                link: '/packages',
            },
        ]
    },
        {
        title: 'Recordes',
        id: 'recordes',
        translate: 'recordes',
        icon: 'fa fa-file-text',
        // link: '/pages/iot-dashboard',
        children: [
            {
                title: 'Orders',
                translate: 'orders',
                link: '/recordes/orders',
            },
            {
                title: 'Captains',
                translate: 'captains',
                link: '/recordes/captains',
            },
            {
                title: 'Owners',
                translate: 'owners',
                link: '/recordes/owners',
            },
        ]
    },
];