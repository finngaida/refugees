//
//  MVC.m
//  Refugees
//
//  Created by Noah on 19.09.15.
//  Copyright © 2015 Refugees Welcome. All rights reserved.
//

#import "MVC.h"
#import <QuartzCore/QuartzCore.h>
#import "MyAnnotation.h"

@interface MVC ()

@end

@implementation MVC
{
@private
    BOOL shouldCenterLocation;
}
@synthesize mapView, locationManager, mapLocations, coordinate;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    backroundImg = [[UIImageView alloc]init];
    backroundImg.frame = self.view.frame;
    backroundImg.image = [UIImage imageNamed:@"MapView"];
    backroundImg.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:backroundImg];
    
    [self loadmap];
    
    topOverlay = [[UIImageView alloc]init];
    topOverlay.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height/2);
    topOverlay.image = [UIImage imageNamed:@"topOverlay"];
    topOverlay.contentMode = UIViewContentModeScaleAspectFill;
    topOverlay.transform = CGAffineTransformMakeRotation(0);
    topOverlay.layer.shadowOpacity = 0.3;
    topOverlay.layer.shadowRadius = 7;
    topOverlay.layer.shadowOffset = CGSizeMake(0, 0);
    [self.view addSubview:topOverlay];
    
    botOverlay = [[UIImageView alloc]init];
    botOverlay.frame = CGRectMake(0, self.view.bounds.size.height/2, self.view.bounds.size.width, self.view.bounds.size.height/2);
    botOverlay.image = [UIImage imageNamed:@"botOverlay"];
    botOverlay.contentMode = UIViewContentModeScaleAspectFit;
    botOverlay.layer.shadowOpacity = 0.3;
    botOverlay.layer.shadowRadius = 7;
    botOverlay.layer.shadowOffset = CGSizeMake(0, 0);
    [self.view addSubview:botOverlay];
    
    midOverlay = [[UIImageView alloc]init];
    midOverlay.frame = CGRectMake(0, 474, self.view.bounds.size.width, 195);
    midOverlay.image = [UIImage imageNamed:@"midOverlay"];
    midOverlay.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:midOverlay];
    
    logoImg = [[UIImageView alloc]init];
    logoImg.frame = CGRectMake(54, 19, 264, 74);
    logoImg.image = [UIImage imageNamed:@"logo"];
    logoImg.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:logoImg];
    
    heartImg = [[UIImageView alloc]init];
    heartImg.frame = CGRectMake(152, 100, 70, 65);
    heartImg.image = [UIImage imageNamed:@"heart"];
    heartImg.contentMode = UIViewContentModeScaleAspectFit;
    heartImg.alpha = 1;
    [self.view addSubview:heartImg];
    
    heartImg_high = [[UIImageView alloc]init];
    heartImg_high.frame = CGRectMake(152, 100, 70, 65);
    heartImg_high.image = [UIImage imageNamed:@"heart_high"];
    heartImg_high.contentMode = UIViewContentModeScaleAspectFit;
    heartImg_high.alpha = 0;
    [self.view addSubview:heartImg_high];
    
    coverView = [[UIView alloc]init];
    coverView.frame = CGRectMake(1, 320, 41, 30);
    coverView.backgroundColor = [UIColor colorWithRed:0.937f green:0.925f blue:0.925f alpha:1.00f];
    [self.view addSubview:coverView];
    
    coverView2 = [[UIView alloc]init];
    coverView2.frame = CGRectMake(333, 320, 41, 30);
    coverView2.backgroundColor = [UIColor colorWithRed:0.937f green:0.925f blue:0.925f alpha:1.00f];
    [self.view addSubview:coverView2];
    
    if (hamburger) {
        newsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        newsBtn.frame = CGRectMake(15, 483, 97, 69);
        [newsBtn setImage:[UIImage imageNamed:@"news"] forState:UIControlStateNormal];
        [newsBtn addTarget:self action:@selector(createDetail:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:newsBtn];
        
        statsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        statsBtn.frame = CGRectMake(148, 518, 80, 84);
        [statsBtn setImage:[UIImage imageNamed:@"stats"] forState:UIControlStateNormal];
        [statsBtn addTarget:self action:@selector(createDetail:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:statsBtn];
        
        storysBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        storysBtn.frame = CGRectMake(282, 482, 70, 84);
        [storysBtn setImage:[UIImage imageNamed:@"people"] forState:UIControlStateNormal];
        [storysBtn addTarget:self action:@selector(createDetail:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:storysBtn];
    }else {
        guideBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        guideBtn.frame = CGRectMake(15, 467, 88, 98);
        [guideBtn setImage:[UIImage imageNamed:@"sign"] forState:UIControlStateNormal];
        [guideBtn addTarget:self action:@selector(createDetail:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:guideBtn];
        
        gameBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        gameBtn.frame = CGRectMake(148, 550, 81, 48);
        [gameBtn setImage:[UIImage imageNamed:@"gaming"] forState:UIControlStateNormal];
        [gameBtn addTarget:self action:@selector(createDetail:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:gameBtn];
        
        emergencyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        emergencyBtn.frame = CGRectMake(275, 472, 89, 89);
        [emergencyBtn setImage:[UIImage imageNamed:@"saver"] forState:UIControlStateNormal];
        [emergencyBtn addTarget:self action:@selector(createDetail:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:emergencyBtn];
    }
    
    fbBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    fbBtn.frame = CGRectMake(144, 627, 44, 40);
    [fbBtn setImage:[UIImage imageNamed:@"facebook"] forState:UIControlStateNormal];
    [fbBtn addTarget:self action:@selector(openSocial:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fbBtn];
    
    twtBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    twtBtn.frame = CGRectMake(188, 627, 44, 40);
    [twtBtn setImage:[UIImage imageNamed:@"twitter"] forState:UIControlStateNormal];
    [twtBtn addTarget:self action:@selector(openSocial:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:twtBtn];
    
    mapOverlay = [UIButton buttonWithType:UIButtonTypeCustom];
    mapOverlay.frame = CGRectMake(43, 190, self.view.bounds.size.width-86, self.view.bounds.size.width-86);
    mapOverlay.layer.cornerRadius = (self.view.bounds.size.width-86)/2;
    [mapOverlay addTarget:self action:@selector(openMap) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mapOverlay];
    

    
}
BOOL annotationsSet;

-(void)openMap {
    
        [mapOverlay setHidden:YES];
        self.locationManager = [[CLLocationManager alloc] init];
        [self.locationManager requestWhenInUseAuthorization];
    

    
    [UIView animateWithDuration:0.2 animations:^{
        coverView.alpha = 0;
        coverView2.alpha = 0;
    }];
    
    [UIView animateWithDuration:1 delay:0.15  options:UIViewAnimationOptionCurveEaseInOut animations:^{
        topOverlay.transform = CGAffineTransformMakeTranslation(0, -self.view.bounds.size.height/2);
        logoImg.transform = CGAffineTransformMakeTranslation(0, -self.view.bounds.size.height/2);
        heartImg.frame = CGRectMake(152, 100-self.view.bounds.size.height/2, 70, 65);
        heartImg_high.frame = CGRectMake(152, 100-self.view.bounds.size.height/2, 70, 65);
        
        botOverlay.transform = CGAffineTransformMakeTranslation(0, +self.view.bounds.size.height/2);
        fbBtn.transform = CGAffineTransformMakeTranslation(0, +self.view.bounds.size.height/2);
        twtBtn.transform = CGAffineTransformMakeTranslation(0, +self.view.bounds.size.height/2);
        midOverlay.transform = CGAffineTransformMakeTranslation(0, +self.view.bounds.size.height/2);
        
        if (!hamburger) {
            guideBtn.transform = CGAffineTransformMakeTranslation(0, +self.view.bounds.size.height/2);
            gameBtn.transform = CGAffineTransformMakeTranslation(0, +self.view.bounds.size.height/2);
            emergencyBtn.transform = CGAffineTransformMakeTranslation(0, +self.view.bounds.size.height/2);

        }else {
            storysBtn.transform = CGAffineTransformMakeTranslation(0, +self.view.bounds.size.height/2);
            newsBtn.transform = CGAffineTransformMakeTranslation(0, +self.view.bounds.size.height/2);
            statsBtn.transform = CGAffineTransformMakeTranslation(0, +self.view.bounds.size.height/2);
        }



    }completion:^(BOOL finished){
        
        if (!annotationsSet) {
            [self addAnnotations];
        }
    }];

}

-(void)addAnnotations {
    annotationsSet = YES;
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *myfile = [mainBundle pathForResource: @"Locations" ofType: @"json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:myfile];
    
    NSError *error;
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data
                                                     options:0
                                                       error:&error];
    
    if (error != nil)
    {
        // handle the error as you want
    }
    
    CLLocationCoordinate2D location;                         // coordinates of the annotation
    NSMutableArray *newAnnotations = [NSMutableArray array]; // an array in which we'll save our annotations temporarily
    MyAnnotation *newAnnotation;                        // the pointer to the annotation we're adding
    
    // iterate through the array, adding an annotation to our our array of new annotations
    
    for (NSDictionary *dictionary in array)
    {
        // retrieve latitude and longitude from the dictionary entry
        
        location.latitude = [dictionary[@"lat"] doubleValue];
        location.longitude = [dictionary[@"lng"] doubleValue];
        
        // create the annotation
        
        newAnnotation = [[MyAnnotation alloc] init];
        newAnnotation.title = dictionary[@"name"];
        newAnnotation.subtitle = dictionary[@"adresse"];
        newAnnotation.opening = dictionary[@"opening"];
        newAnnotation.coordinate = location;
        
        // add it to our array
        //
        // incidentally, generally I just add it to the mapview directly, but
        // given that you have a didAddAnnotationViews, we'll just build up
        // an array and add them all to the map view in one step after we're
        // done iterating through the JSON results
        
        [newAnnotations addObject:newAnnotation];
        
        
    }
    
    // when done, add the annotations
    
    [self.mapView addAnnotations:newAnnotations];
    
}



-(void)closeMap {

    [UIView animateWithDuration:0.2 delay:0.9 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        coverView.alpha = 1;
        coverView2.alpha = 1;
    }completion:^(BOOL finished){
     [mapOverlay setHidden:NO];
    }];
    
    [UIView animateWithDuration:1 delay:0.0  options:UIViewAnimationOptionCurveEaseInOut animations:^{
        topOverlay.transform = CGAffineTransformMakeTranslation(0, 0);
        logoImg.transform = CGAffineTransformMakeTranslation(0, 0);
        heartImg.frame = CGRectMake(152, 100, 70, 65);
        heartImg_high.frame = CGRectMake(152, 100, 70, 65);
        
        botOverlay.transform = CGAffineTransformMakeTranslation(0, 0);
        fbBtn.transform = CGAffineTransformMakeTranslation(0, 0);
        twtBtn.transform = CGAffineTransformMakeTranslation(0, 0);
        midOverlay.transform = CGAffineTransformMakeTranslation(0, 0);
        
        if (!hamburger) {
            guideBtn.transform = CGAffineTransformMakeTranslation(0, 0);
            gameBtn.transform = CGAffineTransformMakeTranslation(0, 0);
            emergencyBtn.transform = CGAffineTransformMakeTranslation(0, 0);
            
        }else {
            storysBtn.transform = CGAffineTransformMakeTranslation(0, 0);
            newsBtn.transform = CGAffineTransformMakeTranslation(0, 0);
            statsBtn.transform = CGAffineTransformMakeTranslation(0, 0);
        }
        
        [self locateUser];
        
    }completion:nil];

}


-(void)alertAppeard {
    [UIView animateWithDuration:0.3 animations:^{
        heartImg.alpha = 0;
        heartImg_high.alpha = 1;
    }completion:^(BOOL finished){
        [self animateHeart];
    }];

}

-(void)animateHeart {

    [UIView animateWithDuration:0.2 delay:0.0 usingSpringWithDamping:0.3 initialSpringVelocity:16 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        heartImg_high.transform = CGAffineTransformMakeScale(1.2, 1.2);
    }completion:nil];
    [UIView animateWithDuration:0.3 delay:0.5 usingSpringWithDamping:0.8 initialSpringVelocity:12 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        heartImg_high.transform = CGAffineTransformMakeScale(1, 1);
    }completion:^(BOOL finished){
        [self animateHeart];
    }];
}

-(IBAction)openSocial:(id)sender {
    
    if (sender == fbBtn) {
        NSString *fbURL = @"fb://profile/379148348868863";
        NSString *fbURLS = @"https://www.facebook.com/jugendhackt";
        BOOL canOpenURL = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:fbURL]];
        
        if(canOpenURL) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:fbURL]];
        } else {
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:fbURLS]];
        }

    }
    
    if (sender == twtBtn) {
        NSString *fbURL = @"twitter://user?screen_name=jhacktnord";
        NSString *fbURLS = @"https://twitter.com/jhacktnord";
        BOOL canOpenURL = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:fbURL]];
        
        if(canOpenURL) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:fbURL]];
        } else {
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:fbURLS]];
        }

    }
}

-(IBAction)createDetail:(id)sender {
    
    UIButton *senderBtn = (UIButton*)sender;
    
    [UIView animateWithDuration:0.2 delay:0 usingSpringWithDamping:0.45 initialSpringVelocity:13 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        senderBtn.transform = CGAffineTransformMakeScale(0.85, 0.85);
    }completion:NULL];
    
    [UIView animateWithDuration:0.4 delay:0.2 usingSpringWithDamping:0.3 initialSpringVelocity:12 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        senderBtn.transform = CGAffineTransformMakeScale(1, 1);
    }completion:NULL];
    
    [self alertAppeard];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadmap {
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    [self.locationManager startUpdatingLocation];

    // Use one or the other, not both. Depending on what you put in info.plist

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
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn addTarget:self
                action:@selector(closeMap)
      forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"mapBackBtn"] forState:UIControlStateNormal];
    
    backBtn.frame = CGRectMake(self.view.bounds.size.width -70, self.view.bounds.size.height -77.5, 57.5, 57.5);
    [self.view addSubview:backBtn];
    
    UIButton *locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [locationBtn addTarget:self
                    action:@selector(locateUser)
          forControlEvents:UIControlEventTouchUpInside];
    [locationBtn setImage:[UIImage imageNamed:@"mapLocateBtn"] forState:UIControlStateNormal];
    locationBtn.frame = CGRectMake(self.view.bounds.size.width -70, self.view.bounds.size.height -155, 57.5, 57.5);
    [self.view addSubview:locationBtn];
}


-(void)locateUser {
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(mapView.userLocation.coordinate, 4000, 4000);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    
    if(shouldCenterLocation){
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 4000, 4000);
        [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
        shouldCenterLocation = FALSE;
    }
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    MKPinAnnotationView *MyPin = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"current"];
    MyPin.pinColor = MKPinAnnotationColorPurple;
    
    MyPin.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];;
    MyPin.draggable = NO;
    MyPin.highlighted = NO;
    MyPin.animatesDrop = YES;
    MyPin.canShowCallout = YES;
    
    if([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    return MyPin;
    
}

- (void)mapView:(MKMapView *)mv annotationView:(MKAnnotationView *)pin calloutAccessoryControlTapped:(UIControl *)control {
    
    MyAnnotation *annotations = (MyAnnotation *) pin.annotation;
    
    NSLog(@"%@", pin.annotation.title);
    
    NSString *adress = pin.annotation.subtitle;
    NSString *opentime = annotations.opening;
    
    NSLog(@"Button Action");
    NSString *message = [NSString stringWithFormat:@"\nAdresse:\n%@\n\nÖffnungszeiten:\n%@",adress, opentime];

    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:pin.annotation.title
                                  message:message
                                  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];

}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);

    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Ortungsdienste deaktiviert"
                                  message:@"Bitte aktiviere in den Einstellungen die Ortungsdienste, um deine Position anzeigen zu lassen."
                                  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    [alert addAction:ok];

    [self presentViewController:alert animated:YES completion:nil];
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
