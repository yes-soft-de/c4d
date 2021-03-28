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
                translate: 'orders',
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
        title: 'Statistics',
        id: 'statistics',
        translate: 'statistics',
        icon: 'fa fa-bar-chart',
        // link: '/pages/iot-dashboard',
        children: [
            {
                title: 'Top 15 ( Captains & Store Owners )',
                translate: 'top-captains-storeOwners',
                link: '/statistics',
            },
            {
                title: 'Captains',
                translate: 'all-captains',
                link: '/statistics/all-captains',
            },
            {
                title: 'Store Owners',
                translate: 'store-owners',
                link: '/statistics/store-owners',
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
                title: 'All Captains',
                translate: 'all-captains',
                link: '/captains',
            },
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
            // {
            //     title: 'Remaining',
            //     translate: 'remaining-captains',
            //     link: '/captains/remaining',
            // },
            {
              title: 'Payment',
              translate: 'payment',
              link: '/captains/payment',
            },
            {
                title: 'Terms',
                translate: 'terms-captain',
                link: '/captains/terms',
            }
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
        title: 'Store Owners',
        translate: 'store-owners',
        id: 'store-owners',
        icon: 'fa fa-shopping-bag',
        children: [
            {
              title: 'All Owners',
              translate: 'all-owners',
              link: '/contracts',
            },
            {
                title: 'Pending',
                translate: 'pending',
                link: '/contracts/pending',
            },
            {
              title: 'Payment',
              translate: 'payment',
              link: '/contracts/payment',
            }
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
    {
        title: 'Reports',
        id: 'reports',
        translate: 'reports',
        icon: 'fa fa-files-o',
        // link: '/pages/iot-dashboard',
        children: [
            {
                title: 'All Reports',
                translate: 'all-reports',
                link: '/reports',
            },
        ]
    },
    {
        title: 'Datings',
        id: 'datings',
        translate: 'datings',
        icon: 'fa fa-calendar',
        // link: '/pages/iot-dashboard',
        children: [
            {
                title: 'All Datings',
                translate: 'all-datings',
                link: '/datings',
            },
        ]
    },
    {
        title: 'Direct Support',
        id: 'support',
        translate: 'direct-support',
        icon: 'fa fa-volume-control-phone',
        children: [
            {
                title: 'Support Information',
                translate: 'support-information',
                link: '/supports',
            },
        ]
    },
    {
        title: 'Latest Updated',
        id: 'updated',
        translate: 'updated',
        icon: 'fa fa-history',
        children: [
            {
                title: 'Latest Updated',
                translate: 'latest-updated',
                link: '/updated',
            },
        ]
    }
];
