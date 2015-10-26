//
//  GuideViewController.m
//  Refugees
//
//  Created by Noah on 26.10.15.
//  Copyright © 2015 Refugees Welcome. All rights reserved.
//

#import "GuideViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface GuideViewController ()

@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AVSpeechSynthesizer *synthesizer = [[AVSpeechSynthesizer alloc]init];
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:@"Games"];
    [utterance setRate:0.2f];
    [synthesizer speakUtterance:utterance];
    
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
    self.view.backgroundColor = [UIColor colorWithRed:0.937f green:0.925f blue:0.925f alpha:1.00f];
    
    titleLabel = [[UILabel alloc]init];
    titleLabel.frame = CGRectMake(20,28+45,self.view.bounds.size.width-40,55);
    titleLabel.text = [NSString stringWithFormat:@"GAMES"];
    titleLabel.font = [UIFont fontWithName:@"Nexa Bold" size:40];
    titleLabel.numberOfLines = 1;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.layer.borderWidth =0;
    [self.view addSubview:titleLabel];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)hide:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
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
