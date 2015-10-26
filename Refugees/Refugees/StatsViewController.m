//
//  StatsViewController.m
//  Refugees
//
//  Created by Noah Raissi on 25.10.15.
//  Copyright © 2015 Refugees Welcome. All rights reserved.
//

#import "StatsViewController.h"
#import <Parse/Parse.h>
#import "UICountingLabel.h"

@interface StatsViewController ()

@end

@implementation StatsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    mainScrollView = [[UIScrollView alloc]init];
    mainScrollView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    mainScrollView.scrollEnabled=YES;
    mainScrollView.userInteractionEnabled=YES;
    mainScrollView.delegate = (id)self;
    mainScrollView.backgroundColor = [UIColor clearColor];
    mainScrollView.contentSize = CGSizeMake (self.view.bounds.size.width, 1513);
    //CGPoint scrollPoint = CGPointMake(0, 0);
  //  [mainScrollView setContentOffset:scrollPoint animated:YES];
    [self.view addSubview:mainScrollView];

    
    
    closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn addTarget:self action:@selector(hide:) forControlEvents:UIControlEventTouchUpInside];
    [closeBtn addTarget:self action:@selector(touchDown:) forControlEvents:UIControlEventTouchDown];
    [closeBtn addTarget:self action:@selector(releaseBtn:) forControlEvents:UIControlEventTouchUpOutside];
    [closeBtn setImage:[UIImage imageNamed:@"closeImg"] forState:UIControlStateNormal];
    //  [backBtn setTitle:@"Back" forState:UIControlStateNormal];
    closeBtn.frame = CGRectMake(14, 28, 45, 45);
    closeBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    closeBtn.layer.borderWidth = 0;
    closeBtn.showsTouchWhenHighlighted = YES;
    [self.view addSubview:closeBtn];
    
    titleLabel = [[UILabel alloc]init];
    titleLabel.frame = CGRectMake(20,28+45,self.view.bounds.size.width-40,55);
    titleLabel.text = [NSString stringWithFormat:@"Refugees in Germany"];
    titleLabel.font = [UIFont fontWithName:@"Nexa Bold" size:30];
    titleLabel.numberOfLines = 1;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.layer.borderWidth =0;
    [mainScrollView addSubview:titleLabel];

    landImg = [[UIImageView alloc]init];
    landImg.frame = CGRectMake(15,28+45+50,self.view.bounds.size.width-30,280);
    landImg.image = [UIImage imageNamed:@"landImg"];
    landImg.contentMode = UIViewContentModeScaleAspectFit;
    landImg.layer.borderWidth = 0;
    [mainScrollView addSubview:landImg];
    
    refugeeCountDE = [[UICountingLabel alloc]init];
    refugeeCountDE.frame = CGRectMake(0,0,landImg.bounds.size.height,40);
    refugeeCountDE.center = landImg.center;
    [refugeeCountDE countFromZeroTo:800.000];
    refugeeCountDE.format = @"%.3f";
    refugeeCountDE.font = [UIFont fontWithName:@"Nexa Light" size:30];
    refugeeCountDE.numberOfLines = 1;
    refugeeCountDE.textColor = [UIColor whiteColor];
    refugeeCountDE.textAlignment = NSTextAlignmentCenter;
    refugeeCountDE.layer.borderWidth =0;
    [mainScrollView addSubview:refugeeCountDE];
    
    countLbl = [[UILabel alloc]init];
    countLbl.frame = CGRectMake(20,28+45+50+280,self.view.bounds.size.width-40,55);
    countLbl.text = [NSString stringWithFormat:@"Refugees in Hamburg"];
    countLbl.font = [UIFont fontWithName:@"Nexa Bold" size:30];
    countLbl.numberOfLines = 1;
    countLbl.textColor = [UIColor blackColor];
    countLbl.textAlignment = NSTextAlignmentCenter;
    countLbl.layer.borderWidth =0;
    [mainScrollView addSubview:countLbl];
    
    groupImg = [[UIImageView alloc]init];
    groupImg.frame = CGRectMake(15,28+45+55+280+55,self.view.bounds.size.width-30,170);
    groupImg.image = [UIImage imageNamed:@"refGroup"];
    groupImg.contentMode = UIViewContentModeScaleAspectFit;
    groupImg.layer.borderWidth = 0;
    [mainScrollView addSubview:groupImg];
    
    refugeeCountHH = [[UICountingLabel alloc]init];
    refugeeCountHH.frame = CGRectMake(0,0,groupImg.bounds.size.height,40);
    refugeeCountHH.center = groupImg.center;
    [refugeeCountHH countFromZeroTo:30.000];
    refugeeCountHH.format = @"%.3f";
    refugeeCountHH.font = [UIFont fontWithName:@"Nexa Bold" size:35];
    refugeeCountHH.transform = CGAffineTransformMakeTranslation(0, -10);
    refugeeCountHH.numberOfLines = 1;
    refugeeCountHH.textColor = [UIColor blackColor];
    refugeeCountHH.textAlignment = NSTextAlignmentCenter;
    [mainScrollView addSubview:refugeeCountHH];
    
    ManTitleLbl = [[UILabel alloc]init];
    ManTitleLbl.frame = CGRectMake(20,28+45+55+280+55+170,self.view.bounds.size.width-40,55);
    ManTitleLbl.text = [NSString stringWithFormat:@"That makes every…"];
    ManTitleLbl.font = [UIFont fontWithName:@"Nexa Bold" size:30];
    ManTitleLbl.numberOfLines = 1;
    ManTitleLbl.textColor = [UIColor blackColor];
    ManTitleLbl.textAlignment = NSTextAlignmentCenter;
    ManTitleLbl.layer.borderWidth =0;
    [mainScrollView addSubview:ManTitleLbl];
    
    manImg = [[UIImageView alloc]init];
    manImg.frame = CGRectMake(15,28+45+55+280+55+170+55,self.view.bounds.size.width-30,200);
    manImg.image = [UIImage imageNamed:@"man"];
    manImg.contentMode = UIViewContentModeScaleAspectFit;
    manImg.layer.borderWidth = 0;
    [mainScrollView addSubview:manImg];
    
    ManLbl = [[UICountingLabel alloc]init];
    ManLbl.frame = CGRectMake(0,0,manImg.bounds.size.height,40);
    ManLbl.center = manImg.center;

    
    ManLbl.format = @"%dth";
    
    ManLbl.font = [UIFont fontWithName:@"Nexa Bold" size:30];
    ManLbl.numberOfLines = 1;
    ManLbl.transform = CGAffineTransformMakeTranslation(0, -10);
    ManLbl.textColor = [UIColor blackColor];
    ManLbl.textAlignment = NSTextAlignmentCenter;
    ManLbl.layer.borderWidth =0;
    [mainScrollView addSubview:ManLbl];

    ManSubtitleLbl = [[UILabel alloc]init];
    ManSubtitleLbl.frame = CGRectMake(20,28+45+55+280+55+170+200+5,self.view.bounds.size.width-40,200);
    ManSubtitleLbl.text = [NSString stringWithFormat:@"…person a refugee\n\nSupporting users:"];
    ManSubtitleLbl.font = [UIFont fontWithName:@"Nexa Bold" size:30];
    ManSubtitleLbl.numberOfLines = 3;
    ManSubtitleLbl.textColor = [UIColor blackColor];
    ManSubtitleLbl.textAlignment = NSTextAlignmentCenter;
    ManSubtitleLbl.layer.borderWidth =0;
    [mainScrollView addSubview:ManSubtitleLbl];
    
    suppsImg = [[UIImageView alloc]init];
    suppsImg.frame = CGRectMake(15,28+45+55+280+55+170+200+55*3,self.view.bounds.size.width-30,200);
    suppsImg.image = [UIImage imageNamed:@"suppsImg"];
    suppsImg.contentMode = UIViewContentModeScaleAspectFit;
    suppsImg.layer.borderWidth = 0;
    [mainScrollView addSubview:suppsImg];
    
    
    suppLbl = [[UICountingLabel alloc]init];
    suppLbl.frame = CGRectMake(0,0,suppsImg.bounds.size.height,40);
    suppLbl.center = suppsImg.center;
    suppLbl.font = [UIFont fontWithName:@"Nexa Bold" size:30];
    suppLbl.numberOfLines = 1;
    suppLbl.textColor = [UIColor blackColor];
    suppLbl.textAlignment = NSTextAlignmentCenter;
    suppLbl.layer.borderWidth =0;
    suppLbl.text = @"0";
    suppLbl.format = @"%d";
    [mainScrollView addSubview:suppLbl];
    
    titleRefLbl = [[UILabel alloc]init];
    titleRefLbl.frame = CGRectMake(15,28+45+55+280+55+170+200+55*3+200,self.view.bounds.size.width-40,55);
    titleRefLbl.text = [NSString stringWithFormat:@"Users who are refugees:"];
    titleRefLbl.font = [UIFont fontWithName:@"Nexa Bold" size:25];
    titleRefLbl.numberOfLines = 1;
    titleRefLbl.textColor = [UIColor blackColor];
    titleRefLbl.textAlignment = NSTextAlignmentCenter;
    titleRefLbl.layer.borderWidth =0;
    [mainScrollView addSubview:titleRefLbl];
    
    mobileImg = [[UIImageView alloc]init];
    mobileImg.frame = CGRectMake(15,28+45+55+280+55+170+200+55*4+200,self.view.bounds.size.width-30,250);
    mobileImg.image = [UIImage imageNamed:@"mobileImg"];
    mobileImg.contentMode = UIViewContentModeScaleAspectFit;
    mobileImg.layer.borderWidth = 0;
    [mainScrollView addSubview:mobileImg];

    updatingRefugeeCount = [[UICountingLabel alloc]init];
    updatingRefugeeCount.frame = CGRectMake(0,0,mobileImg.bounds.size.height,40);
    updatingRefugeeCount.center = mobileImg.center;
    updatingRefugeeCount.font = [UIFont fontWithName:@"Nexa Bold" size:30];
    updatingRefugeeCount.numberOfLines = 1;
    updatingRefugeeCount.text = @"0";
    updatingRefugeeCount.textColor = [UIColor blackColor];
    updatingRefugeeCount.textAlignment = NSTextAlignmentCenter;
    updatingRefugeeCount.layer.borderWidth =0;
    updatingRefugeeCount.format = @"%d";
    [mainScrollView addSubview:updatingRefugeeCount];

    
    PFQuery *query = [PFQuery queryWithClassName:@"UserCount"];
    [query getObjectInBackgroundWithId:@"7x6mQQxymL"
                                 block:^(PFObject *textdu, NSError *error) {
                                     if (!error) {
                                         NSNumber *parsedsupps = [textdu objectForKey:@"Supporter"];
                                         NSNumber *parsedrefs = [textdu objectForKey:@"Refugees"];
                                         supps = [parsedsupps intValue];
                                         refs = [parsedrefs intValue];
                                         
                                         
                                     }else {
                                         NSLog(@"No Service");
                    
                                     }
                                 }];
    
    disclosureLbl = [[UILabel alloc]init];
    disclosureLbl.frame = CGRectMake(15,28+45+55+280+55+170+200+55*4+200+250,self.view.bounds.size.width-40,55);
    disclosureLbl.text = [NSString stringWithFormat:@"*based on current reports"];
    disclosureLbl.font = [UIFont fontWithName:@"Nexa Bold" size:10];
    disclosureLbl.numberOfLines = 1;
    disclosureLbl.textColor = [UIColor blackColor];
    disclosureLbl.textAlignment = NSTextAlignmentCenter;
    disclosureLbl.layer.borderWidth =0;
    [mainScrollView addSubview:disclosureLbl];

    
    
    self.view.backgroundColor = [UIColor colorWithRed:0.937f green:0.925f blue:0.925f alpha:1.00f];
    
    // Do any additional setup after loading the view.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == mainScrollView) {
        
        CGFloat currentValue = [suppLbl currentValue];
        CGFloat currentValue2 = [updatingRefugeeCount currentValue];
        CGFloat currentValue3 = [ManLbl currentValue];

        if (scrollView.contentOffset.y > 130) {
            [ManLbl countFrom:currentValue3
                            to:(int)58
                  withDuration:(NSTimeInterval)3];
            
            
        }

        if (scrollView.contentOffset.y > 500) {
            [suppLbl countFrom:currentValue
                            to:(int)supps
                  withDuration:(NSTimeInterval)3];
            
            
        }
        if (scrollView.contentOffset.y > 730) {

        [updatingRefugeeCount countFrom:currentValue2
                                     to:(int)refs
                           withDuration:(NSTimeInterval)3];
        }
        CGFloat offSet= scrollView.contentOffset.y;
        
        NSLog(@"Offset : %f", offSet);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)hide:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self releaseBtn:closeBtn];
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
