//
//  MVC.m
//  Refugees
//
//  Created by Noah on 19.09.15.
//  Copyright © 2015 Refugees Welcome. All rights reserved.
//

#import "MVC.h"

@interface MVC ()

@end

@implementation MVC
{
@private
    BOOL shouldCenterLocation;
}
@synthesize mapView;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;

        // Use one or the other, not both. Depending on what you put in info.plist
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
    
    mapView = [[MKMapView alloc]init];
    mapView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    mapView.delegate = self;
    mapView.showsUserLocation = YES;
    mapView.mapType = MKMapTypeStandard;
    mapView.zoomEnabled = YES;
    mapView.scrollEnabled = YES;
    
    [self.view addSubview:mapView];
    
    
    [mapView setCenterCoordinate:mapView.userLocation.location.coordinate animated:NO];
    
    CLLocationCoordinate2D startCenter =
    CLLocationCoordinate2DMake(51.165691,10.451526);
    //Hamburg- CLLocationCoordinate2DMake(53.556591,9.993617);
    
    CLLocationDistance regionWidth = 500000;
    CLLocationDistance regionHeight = 500000;
    MKCoordinateRegion startRegion =
    MKCoordinateRegionMakeWithDistance(startCenter,
                                       regionWidth,
                                       regionHeight);
    [self.mapView setRegion:startRegion
                   animated:NO];
    shouldCenterLocation = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
