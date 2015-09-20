//
//  AnnounceViewController.m
//  Refugees
//
//  Created by Finn Gaida on 19.09.15.
//  Copyright © 2015 Finn Gaida. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "AnnounceViewController.h"
#import "JVFloatLabeledTextField.h"
#import "JVFloatLabeledTextView.h"

@interface AnnounceViewController ()
@property (nonatomic) CLLocationManager *manager;
@property (nonatomic) JVFloatLabeledTextField *titleField;
@property (nonatomic) JVFloatLabeledTextField *priceField;
@property (nonatomic) JVFloatLabeledTextField *locationField;
@property (nonatomic) JVFloatLabeledTextField *originField;
@property (nonatomic) JVFloatLabeledTextView *descriptionField;
@property (nonatomic) UIButton *submit;
@end

@implementation AnnounceViewController
@synthesize titleField, priceField, locationField, descriptionField, originField, submit;

const static CGFloat kJVFieldHeight = 44.0f;
const static CGFloat kJVFieldHMargin = 10.0f;

const static CGFloat kJVFieldFontSize = 16.0f;

const static CGFloat kJVFieldFloatingLabelFontSize = 11.0f;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _manager = [CLLocationManager new];
    
    if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedWhenInUse) {
        [self performSegueWithIdentifier:@"showAccess" sender:nil];
    }
    
    [self.view setTintColor:[UIColor blueColor]];
    
    UIView *container = [[UIView alloc] initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:container];
    
    UIColor *floatingLabelColor = [UIColor brownColor];
    
    titleField = [[JVFloatLabeledTextField alloc] initWithFrame:CGRectZero];
    titleField.font = [UIFont systemFontOfSize:kJVFieldFontSize];
    titleField.attributedPlaceholder =
    [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Name", @"")
                                    attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
    titleField.floatingLabelFont = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
    titleField.floatingLabelTextColor = floatingLabelColor;
    titleField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [container addSubview:titleField];
    titleField.translatesAutoresizingMaskIntoConstraints = NO;
    titleField.keepBaseline = YES;
    
    UIView *div1 = [UIView new];
    div1.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3f];
    [container addSubview:div1];
    div1.translatesAutoresizingMaskIntoConstraints = NO;
    
    priceField = [[JVFloatLabeledTextField alloc] initWithFrame:CGRectZero];
    priceField.font = [UIFont systemFontOfSize:kJVFieldFontSize];
    priceField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Time of Arrival", @"")
                                                                       attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
    priceField.floatingLabelFont = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
    priceField.floatingLabelTextColor = floatingLabelColor;
    [container addSubview:priceField];
    priceField.translatesAutoresizingMaskIntoConstraints = NO;
    
    UIView *div2 = [UIView new];
    div2.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3f];
    [container addSubview:div2];
    div2.translatesAutoresizingMaskIntoConstraints = NO;
    
    locationField = [[JVFloatLabeledTextField alloc] initWithFrame:CGRectZero];
    locationField.font = [UIFont systemFontOfSize:kJVFieldFontSize];
    locationField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Arrival Location", @"")
                                                                          attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
    locationField.floatingLabelFont = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
    locationField.floatingLabelTextColor = floatingLabelColor;
    [container addSubview:locationField];
    locationField.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    UIView *div4 = [UIView new];
    div4.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3f];
    [container addSubview:div4];
    div4.translatesAutoresizingMaskIntoConstraints = NO;
    
    originField = [[JVFloatLabeledTextField alloc] initWithFrame:CGRectZero];
    originField.font = [UIFont systemFontOfSize:kJVFieldFontSize];
    originField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Your origin", @"")
                                                                          attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
    originField.floatingLabelFont = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
    originField.floatingLabelTextColor = floatingLabelColor;
    [container addSubview:originField];
    originField.translatesAutoresizingMaskIntoConstraints = NO;
    
    UIView *div3 = [UIView new];
    div3.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3f];
    [container addSubview:div3];
    div3.translatesAutoresizingMaskIntoConstraints = NO;
    
    descriptionField = [[JVFloatLabeledTextView alloc] initWithFrame:CGRectZero];
    descriptionField.font = [UIFont systemFontOfSize:kJVFieldFontSize];
    descriptionField.placeholder = NSLocalizedString(@"About yourself", @"");
    descriptionField.placeholderTextColor = [UIColor darkGrayColor];
    descriptionField.floatingLabelFont = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
    descriptionField.floatingLabelTextColor = floatingLabelColor;
    [container addSubview:descriptionField];
    descriptionField.translatesAutoresizingMaskIntoConstraints = NO;
    
    submit = [[UIButton alloc] initWithFrame:CGRectMake(20, container.frame.size.height-220, container.frame.size.width-40, 100)];
    submit.layer.masksToBounds = YES;
    submit.layer.cornerRadius = 10;
    submit.backgroundColor = [UIColor colorWithRed:(184.0/255.0) green:(233.0/255.0) blue:(134.0/255.0) alpha:1.0];
    [submit addTarget:self action:@selector(submitData) forControlEvents:UIControlEventTouchUpInside];
    [submit addTarget:self action:@selector(touchDown:) forControlEvents:UIControlEventTouchDown];
    [submit addTarget:self action:@selector(releaseBtn:) forControlEvents:UIControlEventTouchUpInside];
    UILabel* title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, submit.frame.size.width, submit.frame.size.height)];
    title.backgroundColor = [UIColor clearColor];
    title.textColor = [UIColor whiteColor];
    title.font = [UIFont fontWithName:@"Nexa Bold" size:40];
    title.text = @"SUBMIT";
    title.textAlignment = NSTextAlignmentCenter;
    [submit addSubview:title];
    [container addSubview:submit];
    
    [container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(xMargin)-[titleField]-(xMargin)-|" options:0 metrics:@{@"xMargin": @(kJVFieldHMargin)} views:NSDictionaryOfVariableBindings(titleField)]];
    [container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[div1]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(div1)]];
    [container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(xMargin)-[priceField]-(xMargin)-[div2(1)]-(xMargin)-[locationField]-(xMargin)-|" options:NSLayoutFormatAlignAllCenterY metrics:@{@"xMargin": @(kJVFieldHMargin)} views:NSDictionaryOfVariableBindings(priceField, div2, locationField)]];
    [container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[div4]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(div4)]];
    [container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(xMargin)-[originField]-(xMargin)-|" options:NSLayoutFormatAlignAllCenterY metrics:@{@"xMargin": @(kJVFieldHMargin)} views:NSDictionaryOfVariableBindings(div4, originField)]];
    [container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[div3]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(div3)]];
    [container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(xMargin)-[descriptionField]-(xMargin)-|" options:0 metrics:@{@"xMargin": @(kJVFieldHMargin)} views:NSDictionaryOfVariableBindings(descriptionField)]];
    
    [container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[titleField(>=minHeight)][div1(1)][originField(>=minHeight)][div4(1)][priceField(>=minHeight)][div3(1)][descriptionField]|" options:0 metrics:@{@"minHeight": @(kJVFieldHeight)} views:NSDictionaryOfVariableBindings(titleField, div1, originField, div4, priceField, div3, descriptionField)]];
    [container addConstraint:[NSLayoutConstraint constraintWithItem:priceField attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:div2 attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0]];
    [container addConstraint:[NSLayoutConstraint constraintWithItem:priceField attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:locationField attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0]];
    
    [titleField becomeFirstResponder];
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)hide:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)submitData {
    NSDictionary *data = @{@"name":titleField.text, @"origin":originField.text, @"arrivalTime":priceField.text, @"arrivalLoc":locationField.text, @"about":descriptionField.text};
    
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://192.168.87.152:8080/RefugeesWelcomeServer/refugees/createRefugee"]];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[NSKeyedArchiver archivedDataWithRootObject:data]];
    
    [[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]] dataTaskWithRequest:req completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
    }];
    
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
