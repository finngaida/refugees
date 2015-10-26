//
//  ChooseViewController.m
//  Refugees
//
//  Created by Noah on 19.09.15.
//  Copyright © 2015 Refugees Welcome. All rights reserved.
//

#import "ChooseViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface ChooseViewController ()

@end
BOOL hamburger;
@implementation ChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CALayer *btnLayer = [Refugee layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:10.0];
    
    CALayer *btnLayer2 = [Supporter layer];
    [btnLayer2 setMasksToBounds:YES];
    [btnLayer2 setCornerRadius:10.0];
    
    CALayer *btnLayer3 = [Unknown layer];
    [btnLayer3 setMasksToBounds:YES];
    [btnLayer3 setCornerRadius:10.0];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)Choose:(id)sender {
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    PFObject *usercount = [PFObject objectWithoutDataWithClassName:@"UserCount" objectId:@"7x6mQQxymL"];
    
    if ([sender tag] == 1) {
        hamburger = NO;
        [currentInstallation addUniqueObject:@"Refugee" forKey:@"channels"];
        [currentInstallation saveInBackground];
        [usercount incrementKey:@"Refugees" byAmount:[NSNumber numberWithInt:1]];
        [usercount saveInBackground];

        [self performSegueWithIdentifier:@"showAnnounce" sender:nil];


    }else if ([sender tag] == 2) {
        hamburger = YES;
        [currentInstallation addUniqueObject:@"Supporter" forKey:@"channels"];
        [currentInstallation saveInBackground];
        [usercount incrementKey:@"Supporter" byAmount:[NSNumber numberWithInt:1]];
        [usercount saveInBackground];
        
        [self performSegueWithIdentifier:@"showSecond" sender:nil];

    }else if ([sender tag] == 3) {
        hamburger = YES;
        [currentInstallation addUniqueObject:@"Guest" forKey:@"channels"];
        [currentInstallation saveInBackground];
        [usercount incrementKey:@"Guests" byAmount:[NSNumber numberWithInt:1]];
        [usercount saveInBackground];
        
        [self performSegueWithIdentifier:@"showSecond" sender:nil];
    }
    
   [self releaseBtn:sender];

}

-(IBAction)touchDown:(id)sender {
    UIButton *Btn = (UIButton*)sender;
    
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:13 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        Btn.transform = CGAffineTransformMakeScale(0.8, 0.8);
    }completion:nil];
    

}

-(IBAction)releaseBtn:(id)sender {
    UIButton *Btn = (UIButton*)sender;

    [UIView animateWithDuration:0.3 delay:0.2 usingSpringWithDamping:0.3 initialSpringVelocity:13 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        Btn.transform = CGAffineTransformMakeScale(1, 1);
        
    }completion:nil];
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
