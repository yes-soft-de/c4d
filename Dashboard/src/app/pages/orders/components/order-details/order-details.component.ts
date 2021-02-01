import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, ParamMap } from '@angular/router';
import { Subject } from 'rxjs';
import { share, takeUntil } from 'rxjs/operators';
import { OrderDetails } from '../../entity/order-details';
import { OrderDetailsResponse } from '../../entity/order-details-response';
import { OrdersService } from '../../services/orders.service';
import { google } from '@google/maps';

@Component({
  selector: 'app-order-details',
  templateUrl: './order-details.component.html',
  styleUrls: ['./order-details.component.scss']
})
export class OrderDetailsComponent implements OnInit {

  private destroy$: Subject<void> = new Subject<void>();
  orderDetails: OrderDetails;
  marker: any;

  constructor(private orderService: OrdersService,
              // private router: Router,/
              private activateRoute: ActivatedRoute) { }

  ngOnInit() {
    // this.orderService.getPosition().then(pos => {
    //     console.log(pos);
    //     console.log(`Positon: ${pos.lng} ${pos.lat}`);
    // });
    this.activateRoute.paramMap.subscribe((params: ParamMap) => {
      let id = parseInt(params.get('id'));
      console.log(params);
      this.orderService.orderDetails(id)
      .pipe(takeUntil(this.destroy$))
      .subscribe(
        (orderDetail: OrderDetailsResponse) => {
          if (orderDetail) {
            console.log('Order Details: ', orderDetail);
            this.orderDetails = orderDetail.Data;
            // this.getGeoLocation(this.orderDetails.fromBranch.location.lat, this.orderDetails.fromBranch.location.lat);
          }
        },
        error => console.log('Error : ', error)
      );
    });

  }


  getGeoLocation(lat: number, lng: number) {
    if (navigator.geolocation) {
        let geocoder = new google.maps.Geocoder();
        let latlng = new google.maps.LatLng(lat, lng);
        let request = {
            latLng: latlng
        };
        console.log('geocoder', geocoder);
        console.log('latlng', latlng);
        console.log('request', request);
        geocoder.geocode(request, (results, status) => {
            if (status == google.maps.GeocoderStatus.OK) {
                let result = results[0];
                let rsltAdrComponent = result.address_components;
                let resultLength = rsltAdrComponent.length;
                if (result != null) {
                    this.marker.buildingNum = rsltAdrComponent.find(x => x.types == 'street_number').long_name;
                    this.marker.streetName = rsltAdrComponent.find(x => x.types == 'route').long_name;
                } else {
                    alert("No address available!");
                }
            }
        });
    }
}

// mapClicked($event: MouseEvent) {
//   this.marker.lat = $event.coords.lat;
//   this.marker.lng = $event.coords.lng;
//   this.getGeoLocation(this.marker.lat, this.marker.lng);
//   console.log("Lat: " + this.marker.lat + " Long: " + this.marker.lng)
// }


}
