//
//  FirstViewController.m
//  Refugees
//
//  Created by Finn Gaida on 18.09.15.
//  Copyright © 2015 Finn Gaida. All rights reserved.
//

#import "DataManager.h"
#import "FirstViewController.h"

@interface FirstViewController ()
@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)refugeeTapped:(id)sender {
    [DataManager sharedManager].type = FGTypeRefugee;
}

- (IBAction)helperTapped:(id)sender {
    [DataManager sharedManager].type = FGTypeHelper;
}

- (IBAction)justInterestedTapped:(id)sender {
    [DataManager sharedManager].type = FGTypeDude;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
