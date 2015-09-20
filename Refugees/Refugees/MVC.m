//
//  MVC.m
//  Refugees
//
//  Created by Noah on 19.09.15.
//  Copyright © 2015 Refugees Welcome. All rights reserved.
//

#import "MVC.h"
#import <QuartzCore/QuartzCore.h>
#import <Social/Social.h>
#import "MyAnnotation.h"

@interface MVC ()

@end

@implementation MVC
{
@private
    BOOL shouldCenterLocation;
}
@synthesize mapView, locationManager, mapLocations, coordinate;

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        donateView.alpha = 1;
        donateView.frame = CGRectMake(78, 404, 219, 120);
        donateBtn.frame = CGRectMake(78, 404, 219, 120);

        
    }completion:NULL];
}

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
    
    logoBtn = [[UIButton alloc] initWithFrame:CGRectMake(54, 19, 264, 74)];
    [logoBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    logoImg = [[UIImageView alloc]init];
    logoImg.frame = CGRectMake(0, 0, 264, 74);
    logoImg.image = [UIImage imageNamed:@"logo"];
    logoImg.contentMode = UIViewContentModeScaleAspectFit;
    [logoBtn addSubview:logoImg];
    [self.view addSubview:logoBtn];
    
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
        newsBtn.tag = 6;
        [newsBtn setImage:[UIImage imageNamed:@"news"] forState:UIControlStateNormal];
        [newsBtn addTarget:self action:@selector(createDetail:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:newsBtn];
        
        statsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        statsBtn.frame = CGRectMake(148, 518, 80, 84);
        statsBtn.tag = 1;
        [statsBtn setImage:[UIImage imageNamed:@"stats"] forState:UIControlStateNormal];
        [statsBtn addTarget:self action:@selector(createDetail:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:statsBtn];
        
        storysBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        storysBtn.frame = CGRectMake(282, 482, 70, 84);
        storysBtn.tag = 2;
        [storysBtn setImage:[UIImage imageNamed:@"people"] forState:UIControlStateNormal];
        [storysBtn addTarget:self action:@selector(createDetail:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:storysBtn];
        
        donateView = [[UIImageView alloc]init];
        donateView.frame = CGRectMake(78, 404+140, 219, 120);
        donateView.image = [UIImage imageNamed:@"donation"];
        donateView.contentMode = UIViewContentModeScaleAspectFit;
        donateView.alpha = 0;
        [self.view insertSubview:donateView belowSubview:botOverlay];
        
        donateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        donateBtn.frame = CGRectMake(78, 404+140, 219, 120);
        [donateBtn addTarget:self action:@selector(createDetail:) forControlEvents:UIControlEventTouchUpInside];
        donateBtn.tag = 6;
        donateBtn.alpha = 1;
        [self.view addSubview:donateBtn];
        
    }else {
        guideBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        guideBtn.frame = CGRectMake(15, 467, 88, 98);
        guideBtn.tag = 8;
        [guideBtn setImage:[UIImage imageNamed:@"sign"] forState:UIControlStateNormal];
        [guideBtn addTarget:self action:@selector(createDetail:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:guideBtn];
        
        gameBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        gameBtn.frame = CGRectMake(148, 550, 81, 48);
//        gameBtn.tag = 4;
        [gameBtn setImage:[UIImage imageNamed:@"gaming"] forState:UIControlStateNormal];
        [gameBtn addTarget:self action:@selector(createDetail:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:gameBtn];
        
        emergencyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        emergencyBtn.frame = CGRectMake(275, 472, 89, 89);
        emergencyBtn.tag = 5;
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
    
    cautionView = [[UIView alloc]init];
    cautionView.frame = CGRectMake(78, 135-140, 219, 120);
    cautionView.backgroundColor = [UIColor clearColor];
    cautionView.alpha = 0;
    [self.view insertSubview:cautionView belowSubview:topOverlay];
    
    caution = [[UIImageView alloc]init];
    caution.frame = CGRectMake(0, 0, 219, 120);
    caution.image = [UIImage imageNamed:@"caution"];
    caution.contentMode = UIViewContentModeScaleAspectFit;
    [cautionView addSubview:caution];
    
    cautionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cautionBtn.frame = CGRectMake(78, 135+60, caution.bounds.size.width, 60);
    cautionBtn.layer.cornerRadius = (self.view.bounds.size.width-86)/2;
    [cautionBtn addTarget:self action:@selector(cautionAction:) forControlEvents:UIControlEventTouchUpInside];
    [cautionBtn setHidden:YES];
    [self.view addSubview:cautionBtn];
    [self.view bringSubviewToFront:donateBtn];

    [self checkForAlert];
    [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(checkForAlert) userInfo:nil repeats:YES];

    
}

-(void)cautionAction:(id)sender {

    NSLog(@"shit");
    
        [cautionBtn removeTarget:self action:@selector(cautionAction:) forControlEvents:UIControlEventTouchUpInside];
                        [mapOverlay removeTarget:self action:@selector(openMap) forControlEvents:UIControlEventTouchUpInside];
    closeAlterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closeAlterBtn.frame = CGRectMake(self.view.bounds.size.width/2-30, 200, 60, 60);
    [closeAlterBtn addTarget:self action:@selector(closeOpenAlert) forControlEvents:UIControlEventTouchUpInside];
    [closeAlterBtn setTitle:@"+" forState:UIControlStateNormal];
    [closeAlterBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [closeAlterBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    closeAlterBtn.titleLabel.font = [UIFont fontWithName:@"Nexa Bold" size:80];
    closeAlterBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    closeAlterBtn.layer.cornerRadius = 0;
    closeAlterBtn.alpha = 0;
    closeAlterBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, -20, 0);
    closeAlterBtn.transform = CGAffineTransformMakeRotation(( 45 * M_PI ) / 180 );
    [self.view addSubview:closeAlterBtn];
    
    alertLabel = [[UILabel alloc]init];
    alertLabel.frame = CGRectMake(0, 0, self.view.bounds.size.width-86, self.view.bounds.size.width-86);
    alertLabel.font = [UIFont fontWithName:@"Nexa Bold" size:30];
    alertLabel.numberOfLines = 6;
    alertLabel.layer.cornerRadius = (self.view.bounds.size.width-86)/2;
    alertLabel.textColor = [UIColor whiteColor];
    alertLabel.textAlignment = NSTextAlignmentCenter;
    alertLabel.layer.borderWidth =0;
    alertLabel.alpha = 0;
    [cautionView addSubview:alertLabel];
                       
           PFQuery *query = [PFQuery queryWithClassName:@"mainClass"];
           [query getObjectInBackgroundWithId:@"aXpNBp34vP"
                                        block:^(PFObject *objects, NSError *error) {
                                            if (!error) {
                                                NSString *string = [objects objectForKey:@"alertMsg"];
                                                alertLabel.text = string;
                                                
                                                    
                                                }else {
                                                    
                                                }}];

    

    [UIView animateWithDuration:0.2 delay:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        //cautionView.transform = CGAffineTransformMakeTranslation(0, -120);
        closeAlterBtn.alpha =1;
        alertLabel.alpha = 1;
    }completion:^(BOOL finished){

    }];
    cautionView.backgroundColor = [UIColor colorWithRed:0.984f green:0.329f blue:0.329f alpha:1.0f];

    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        cautionView.frame = CGRectMake(43, 190, self.view.bounds.size.width-86, self.view.bounds.size.width-86);
        cautionView.layer.cornerRadius = (self.view.bounds.size.width-86)/2;
        caution.frame = CGRectMake(cautionView.bounds.size.width/2-110, 0, 219, 120);
        caution.alpha = 0;


    }completion:^(BOOL finished){
        [self.view bringSubviewToFront:closeAlterBtn];
    }];
}

-(void)closeOpenAlert{
    NSLog(@"close");
    
    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        closeAlterBtn.alpha =0;
        alertLabel.alpha = 0;

    }completion:^(BOOL finished){
        [closeAlterBtn removeFromSuperview];
    }];
    
    [UIView animateWithDuration:0.3 delay:0.4 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        caution.alpha = 1;
        
    }completion:^(BOOL finished){
        
    }];
    
    [UIView animateWithDuration:0.5 delay:0.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        cautionView.backgroundColor = [UIColor clearColor];

        cautionView.frame = CGRectMake(78, 135, 219, 120);
        caution.frame = CGRectMake(0, 0, 219, 120);
        
        
    }completion:^(BOOL finished){
                [cautionBtn addTarget:self action:@selector(cautionAction:) forControlEvents:UIControlEventTouchUpInside];
                            [mapOverlay addTarget:self action:@selector(openMap) forControlEvents:UIControlEventTouchUpInside];
        cautionView.layer.cornerRadius = 0;

    }];

    

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
        
        cautionView.transform = CGAffineTransformMakeTranslation(0, -self.view.bounds.size.height/2);

        
        if (!hamburger) {
            guideBtn.transform = CGAffineTransformMakeTranslation(0, +self.view.bounds.size.height/2);
            gameBtn.transform = CGAffineTransformMakeTranslation(0, +self.view.bounds.size.height/2);
            emergencyBtn.transform = CGAffineTransformMakeTranslation(0, +self.view.bounds.size.height/2);


        }else {
            storysBtn.transform = CGAffineTransformMakeTranslation(0, +self.view.bounds.size.height/2);
            newsBtn.transform = CGAffineTransformMakeTranslation(0, +self.view.bounds.size.height/2);
            statsBtn.transform = CGAffineTransformMakeTranslation(0, +self.view.bounds.size.height/2);
            donateView.frame = CGRectMake(78, 404+self.view.bounds.size.height/2, 219, 120);
            donateBtn.frame = CGRectMake(78, 404+self.view.bounds.size.height/2, 219, 120);
        }



    }completion:^(BOOL finished){
        [mapView setUserInteractionEnabled:YES];

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
        newAnnotation.subtitle = dictionary[@"anzahl"];
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
        [mapView setUserInteractionEnabled:NO];
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
        
        cautionView.transform = CGAffineTransformMakeTranslation(0, 0);

        if (!hamburger) {
            guideBtn.transform = CGAffineTransformMakeTranslation(0, 0);
            gameBtn.transform = CGAffineTransformMakeTranslation(0, 0);
            emergencyBtn.transform = CGAffineTransformMakeTranslation(0, 0);
            
        }else {
            storysBtn.transform = CGAffineTransformMakeTranslation(0, 0);
            newsBtn.transform = CGAffineTransformMakeTranslation(0, 0);
            statsBtn.transform = CGAffineTransformMakeTranslation(0, 0);
            donateView.frame = CGRectMake(78, 404, 219, 120);
            donateBtn.frame = CGRectMake(78, 404, 219, 120);
        }
        
        [self locateUser];
        
    }completion:nil];

    
}


-(void)alertAppeard {
    [UIView animateWithDuration:0.3 animations:^{
        heartImg.alpha = 0;
        heartImg_high.alpha = 1;
        topOverlay.layer.shadowColor = [UIColor redColor].CGColor;
        botOverlay.layer.shadowColor = [UIColor redColor].CGColor;

    }completion:^(BOOL finished){
    }];
    
    alertTimer = [NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector(animateHeart) userInfo:nil repeats:YES];

}

-(void)alertDisappeard {
    
    [alertTimer invalidate];
    alertTimer = nil;
    
    [UIView animateWithDuration:0.3 animations:^{
        heartImg.alpha = 1;
        heartImg_high.alpha = 0;
        topOverlay.layer.shadowColor = [UIColor blackColor].CGColor;
        botOverlay.layer.shadowColor = [UIColor blackColor].CGColor;
        
    }completion:^(BOOL finished){
    }];

}

-(void)animateHeart {

    [UIView animateWithDuration:0.2 delay:0.0 usingSpringWithDamping:0.3 initialSpringVelocity:16 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        heartImg_high.transform = CGAffineTransformMakeScale(1.2, 1.2);
        heartImg_high.alpha = 1;
        
        CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"shadowOpacity"];
        anim.fromValue = [NSNumber numberWithFloat:0.3];
        anim.toValue = [NSNumber numberWithFloat:0.8];
        [topOverlay.layer addAnimation:anim forKey:@"shadowOpacity"];
        [botOverlay.layer addAnimation:anim forKey:@"shadowOpacity"];

    }completion:nil];
    [UIView animateWithDuration:0.3 delay:0.5 usingSpringWithDamping:0.8 initialSpringVelocity:12 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        heartImg_high.transform = CGAffineTransformMakeScale(1, 1);
        heartImg_high.alpha = 0.5;
        
        CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"shadowOpacity"];
        anim.fromValue = [NSNumber numberWithFloat:0.8];
        anim.toValue = [NSNumber numberWithFloat:0.3];
        [topOverlay.layer addAnimation:anim forKey:@"shadowOpacity"];
        [botOverlay.layer addAnimation:anim forKey:@"shadowOpacity"];

    }completion:^(BOOL finished){
    }];
    
    
    
}

-(void)openSocial:(id)sender {
    
    if (sender == fbBtn) {
        NSString *fbURL = @"fb://profile/379148348868863";
        NSString __unused *fbURLS = @"https://www.facebook.com/jugendhackt";
        BOOL __unused canOpenURL = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:fbURL]];
        
//        if(canOpenURL) {
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:fbURL]];
//        } else {
//            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:fbURLS]];
//        }
        
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
            SLComposeViewController *post = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
            [post setInitialText:@"I'm helping refugees with the \"Moin Refugees!\" App!"];
            [post addURL:[NSURL URLWithString:@"https://hackdash.org/projects/55fd2a6474d6ac1d2145177e"]];
            [self presentViewController:post animated:YES completion:nil];
        }
    }
    
    if (sender == twtBtn) {
        NSString *fbURL = @"twitter://user?screen_name=jhacktnord";
        NSString __unused *fbURLS = @"https://twitter.com/jhacktnord";
        BOOL __unused canOpenURL = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:fbURL]];
        
//        if(canOpenURL) {
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:fbURL]];
//        } else {
//            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:fbURLS]];
//        }
        
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
            SLComposeViewController *post = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
            [post setInitialText:@"I'm helping refugees with the \"Moin Refugees!\" App!"];
            [post addURL:[NSURL URLWithString:@"https://hackdash.org/projects/55fd2a6474d6ac1d2145177e"]];
            [self presentViewController:post animated:YES completion:nil];
        }

    }
}

-(void)createDetail:(id)sender {
    
    UIButton *senderBtn = (UIButton*)sender;
    
    [UIView animateWithDuration:0.2 delay:0 usingSpringWithDamping:0.45 initialSpringVelocity:13 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        senderBtn.transform = CGAffineTransformMakeScale(0.85, 0.85);
    }completion:NULL];
    
    [UIView animateWithDuration:0.4 delay:0.2 usingSpringWithDamping:0.3 initialSpringVelocity:12 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        senderBtn.transform = CGAffineTransformMakeScale(1, 1);
    }completion:NULL];
    
    NSString *seg;
    switch (senderBtn.tag) {
            case 0:seg = @"showNews";break;
            case 1:seg = @"showInfos";break;
            case 2:seg = @"showArrivals";break;
            case 3:seg = @"showGuides";break;
            case 4:seg = @"showGames";break;
            case 5:seg = @"showEmergency";break;
            case 6:seg = @"showDonate";break;
            case 7:seg = @"showLocations";break;
            case 8:seg = @"showAnnounce";break;
            default:break;
    }

    [self performSegueWithIdentifier:seg sender:nil];
    
}

- (void)goBack {
    [self dismissViewControllerAnimated:YES completion:nil];
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
BOOL alertIsVisible;
-(void)checkForAlert {
    
    PFQuery *query = [PFQuery queryWithClassName:@"mainClass"];
    [query getObjectInBackgroundWithId:@"aXpNBp34vP"
                                 block:^(PFObject *objects, NSError *error) {
                                     if (!error) {
                                         NSString *string = [objects objectForKey:@"alertMsg"];
                                         
                                         if ([string isEqualToString:@""]) {
                                             NSLog(@"String Emptry - No Alert");
                                             [UIView animateWithDuration:1 animations:^{
                                                 cautionView.frame = CGRectMake(78, 135-140, 219, 120);
                                                 cautionView.alpha = 0;
                                             }completion:NULL];
                                             [self alertDisappeard];
                                             alertIsVisible = NO;
                                             [cautionBtn setHidden:YES];

                                             
                                         }else {
                                             if (!alertIsVisible) {
                                                 [UIView animateWithDuration:1 animations:^{
                                                     cautionView.frame = CGRectMake(78, 135, 219, 120);
                                                     cautionView.alpha = 1;
                                                 }completion:NULL];
                                                 [self alertAppeard];

                                             }
                                             NSLog(@"String has content - Display string");
                                            alertIsVisible = YES;
                                             [cautionBtn setHidden:NO];


                                         }

                                         
                                         
                                     } else {
                                         
                                     }
                                 }];

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
    MyPin.pinTintColor = [UIColor purpleColor];
    
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
    
    //MyAnnotation *annotations = (MyAnnotation *) pin.annotation;
    
    NSLog(@"%@", pin.annotation.title);
    
    NSString *anzahl = pin.annotation.subtitle;
    
    NSLog(@"Button Action");
    NSString *message = [NSString stringWithFormat:@"\nAsylanten:\n%@",anzahl];

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
