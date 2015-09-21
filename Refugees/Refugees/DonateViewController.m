//
//  DonateViewController.m
//  Refugees
//
//  Created by Finn Gaida on 19.09.15.
//  Copyright © 2015 Finn Gaida. All rights reserved.
//

#import "DonateViewController.h"

@interface DonateViewController ()
@property (weak, nonatomic) IBOutlet UITextField *donationField;
@property (nonatomic) PayPalConfiguration *config;
@end

@implementation DonateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _config = [PayPalConfiguration new];
    _config.merchantName = @"Refugees welcome";
    _config.payPalShippingAddressOption = PayPalShippingAddressOptionNone;
}

- (void)viewWillAppear:(BOOL)animated {
    [PayPalMobile preconnectWithEnvironment:PayPalEnvironmentNoNetwork];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)donate:(id)sender {
    // do magic here
    float value = [_donationField.text floatValue];
    PayPalPayment *cash = [PayPalPayment new];
    cash.amount = [[NSDecimalNumber alloc] initWithFloat:value];
    cash.currencyCode = @"EUR";
    cash.shortDescription = @"Donate to support helpers' voluntary work";
    cash.intent = PayPalPaymentIntentAuthorize;
    
    // show VC
    PayPalPaymentViewController *vc = [[PayPalPaymentViewController alloc] initWithPayment:cash configuration:_config delegate:self];
    if (vc != nil)
        [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark PayPal Delegate
- (void)payPalPaymentViewController:(PayPalPaymentViewController *)paymentViewController
                 didCompletePayment:(PayPalPayment *)completedPayment {
    // Payment was processed successfully; send to server for verification and fulfillment.
    [self verifyCompletedPayment:completedPayment];
    
    // Dismiss the PayPalPaymentViewController.
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)verifyCompletedPayment:(PayPalPayment *)completedPayment {
    // Send the entire confirmation dictionary
    NSData *confirmation = [NSJSONSerialization dataWithJSONObject:completedPayment.confirmation options:0 error:nil];
    
    // TODO: Show success screen
    
}

- (void)payPalPaymentDidCancel:(PayPalPaymentViewController *)paymentViewController {
    // The payment was canceled; dismiss the PayPalPaymentViewController.
    [self dismissViewControllerAnimated:YES completion:nil];
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
