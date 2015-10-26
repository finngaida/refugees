//
//  LocationsViewController.m
//  Refugees
//
//  Created by Finn Gaida on 19.09.15.
//  Copyright © 2015 Finn Gaida. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "LocationsViewController.h"

@interface LocationsViewController ()
@property (nonatomic) CLLocationManager *manager;
@end

@implementation LocationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _manager = [CLLocationManager new];
    
    if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedWhenInUse) {
        [self performSegueWithIdentifier:@"showAccess" sender:nil];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)hide:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
