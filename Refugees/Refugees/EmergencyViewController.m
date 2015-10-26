//
//  EmergencyViewController.m
//  Refugees
//
//  Created by Finn Gaida on 19.09.15.
//  Copyright © 2015 Finn Gaida. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "EmergencyViewController.h"

@interface EmergencyViewController ()
@property (nonatomic) CLLocationManager *manager;
@end

@implementation EmergencyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _manager = [CLLocationManager new];
    
    if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedWhenInUse) {
        [self performSegueWithIdentifier:@"showAccess" sender:nil];
    }
    
    CALayer *btnLayer = [policeBtn layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:10.0];
    
    CALayer *btnLayer2 = [ambulanceBtn layer];
    [btnLayer2 setMasksToBounds:YES];
    [btnLayer2 setCornerRadius:10.0];
    
    CALayer *btnLayer3 = [rescueBtn layer];
    [btnLayer3 setMasksToBounds:YES];
    [btnLayer3 setCornerRadius:10.0];
    
    policeBtn.tag = 1;
    ambulanceBtn.tag = 2;
    rescueBtn.tag = 3;
    
    [self releaseBtn:ambulanceBtn];
    [self releaseBtn:policeBtn];
    [self releaseBtn:rescueBtn];


}

-(IBAction)Choose:(id)sender {
    NSString *phoneNumber;
    if ([sender tag] == 1) {
        phoneNumber = @"telprompt://110";
            }else if ([sender tag] == 2) {
                  phoneNumber = @"telprompt://112" ;
            }else if ([sender tag] == 3){
                  phoneNumber = @"telprompt://+4940306200";
            }
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
    
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


- (IBAction)hide:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
