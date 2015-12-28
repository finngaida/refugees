//
//  DonateViewController.m
//  Refugees
//
//  Created by Finn Gaida on 19.09.15.
//  Copyright © 2015 Finn Gaida. All rights reserved.
//

#import "DonateViewController.h"

@interface DonateViewController () <UIPickerViewDelegate, UIPickerViewDataSource>


@property (weak, nonatomic) IBOutlet UILabel *donationLabel;
@property (nonatomic) PayPalConfiguration *config;
@property (nonatomic) NSArray *preCommaValues;
@property (nonatomic) NSArray *postCommaValues;

@end

@implementation DonateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _config = [PayPalConfiguration new];
    _config.merchantName = @"Refugees welcome";
    _config.payPalShippingAddressOption = PayPalShippingAddressOptionNone;
    
    _preCommaValues = @[@"0", @"1", @"2", @"5", @"10", @"15", @"20", @"25", @"30", @"50", @"75", @"100", @"150", @"200", @"250", @"300", @"500", @"1000"];
    _postCommaValues = @[@"00", @"10", @"20", @"30", @"40", @"50", @"60", @"70", @"80", @"90"];
    
    // beta release
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Beta Version" message:@"The donation feature will be enabled in a future build." preferredStyle:UIAlertControllerStyleAlert];
    [controller addAction:[UIAlertAction actionWithTitle:@"Got it" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }]];
    //    [self presentViewController:controller animated:YES completion:nil];
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
    float value = [_donationLabel.text floatValue];
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

#pragma mark Picker
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 4;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    switch (component) {
        case 0:return _preCommaValues.count; break;
        case 1:return 1; break;
        case 2:return _postCommaValues.count; break;
        case 3:return 1; break;
        default:return 0; break;
    }
}

// returns width of column and height of row for each component.
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    switch (component) {
        case 0:return self.view.frame.size.width * 0.2; break;
        case 1:return self.view.frame.size.width * 0.1; break;
        case 2:return self.view.frame.size.width * 0.2; break;
        case 3:return self.view.frame.size.width * 0.1; break;
        default:return 0; break;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 50;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    switch (component) {
        case 0:return _preCommaValues[row]; break;
        case 1:return @","; break;
        case 2:return _postCommaValues[row]; break;
        case 3:return @"€"; break;
        default:return @""; break;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    NSString *pre = [self pickerView:pickerView titleForRow:[pickerView selectedRowInComponent:0] forComponent:0];
    NSString *post = [self pickerView:pickerView titleForRow:[pickerView selectedRowInComponent:2] forComponent:2];
    
    _donationLabel.text = [NSString stringWithFormat:@"%@,%@€", pre, post];
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
