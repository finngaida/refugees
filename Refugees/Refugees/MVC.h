//
//  MVC.h
//  Refugees
//
//  Created by Noah on 19.09.15.
//  Copyright © 2015 Refugees Welcome. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "ChooseViewController.h"
#import <Parse/Parse.h>

@interface MVC : UIViewController <MKMapViewDelegate,CLLocationManagerDelegate,MKAnnotation> {
    
    UIImageView *backroundImg;
    UIImageView *topOverlay;
    UIImageView *botOverlay;
    UIImageView *midOverlay;
    UIImageView *logoImg;
    UIButton *logoBtn;
    UIImageView *heartImg;

    UIButton *guideBtn;
    UIButton *gameBtn;
    UIButton *emergencyBtn;
    
    UIButton *newsBtn;
    UIButton *statsBtn;
    UIButton *storysBtn;
    
    UIButton *alertBtn;
    UIButton *donateBtn;
    UIView *donateView;
    UIView *alertView;
    
    UIButton *fbBtn;
    UIButton *twtBtn;    
    UIImageView *heartImg_high;
    
    UIButton *mapOverlay;
    UIView *coverView;
    UIView *coverView2;
    UIActivityIndicatorView *activityIndicator;

    UIView *cautionView;
    UIImageView *caution;
    UIButton *cautionBtn;
    UIButton *closeAlterBtn;
    NSTimer *alertTimer;
    UILabel *alertLabel;
    

}
extern BOOL hamburger;
@property(nonatomic,strong) MKMapView *mapView;
@property(nonatomic, strong) CLLocationManager *locationManager;
@property(nonatomic,strong) NSArray *mapLocations;

@end
