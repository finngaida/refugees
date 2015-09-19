//
//  ChooseViewController.m
//  Refugees
//
//  Created by Noah on 19.09.15.
//  Copyright © 2015 Refugees Welcome. All rights reserved.
//

#import "ChooseViewController.h"

@interface ChooseViewController ()

@end
BOOL hamburger;
@implementation ChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)Choose:(id)sender {
    
    if ([sender tag] == 1) {
        hamburger = NO;
    }else if ([sender tag] == 2) {
        hamburger = YES;
    }
        [self performSegueWithIdentifier:@"showSecond" sender:nil];
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
