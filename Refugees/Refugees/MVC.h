//
//  MVC.h
//  Refugees
//
//  Created by Noah on 19.09.15.
//  Copyright © 2015 Refugees Welcome. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MVC : UIViewController <MKMapViewDelegate,CLLocationManagerDelegate> {
    
    
}

@property(nonatomic,strong) MKMapView *mapView;
@property(nonatomic, strong) CLLocationManager *locationManager;

@end
