//
//  StoryViewController.m
//  Refugees
//
//  Created by Noah Raissi on 26.10.15.
//  Copyright © 2015 Refugees Welcome. All rights reserved.
//

#import "StoryViewController.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import <Parse/Parse.h>

@interface StoryViewController ()

@end

@implementation StoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    titleLabel.text = [NSString stringWithFormat:@"STORYS"];
    titleLabel.font = [UIFont fontWithName:@"Nexa Bold" size:40];
    titleLabel.numberOfLines = 1;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.layer.borderWidth =0;
    [self.view addSubview:titleLabel];
    
    titleLabel = [[UILabel alloc]init];
    titleLabel.frame = CGRectMake(20,28+45+55,self.view.bounds.size.width-40,80);
    titleLabel.text = [NSString stringWithFormat:@"One Refugee's Journey\nto a New Future"];
    titleLabel.font = [UIFont fontWithName:@"Nexa Bold" size:25];
    titleLabel.numberOfLines = 2;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.layer.borderWidth =0;
    [self.view addSubview:titleLabel];

    playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [playBtn addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
    [playBtn setImage:[UIImage imageNamed:@"playVidImg"] forState:UIControlStateNormal];
    playBtn.frame = CGRectMake(15, 28+45+55+80, self.view.bounds.size.width-30, 200);
    playBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    playBtn.showsTouchWhenHighlighted = NO;
    [self.view addSubview:playBtn];
    
    dateLbl = [[UILabel alloc]init];
    dateLbl.frame = CGRectMake(20,28+45+55+200+85,self.view.bounds.size.width-40,20);
    dateLbl.text = [NSString stringWithFormat:@"Wed, Oct 07 - Source: NBC"];
    dateLbl.font = [UIFont fontWithName:@"Nexa Bold" size:15];
    dateLbl.numberOfLines = 2;
    dateLbl.textColor = [UIColor lightGrayColor];
    dateLbl.textAlignment = NSTextAlignmentLeft;
    dateLbl.layer.borderWidth =0;
    [self.view addSubview:dateLbl];
    
    storyView = [[UITextView alloc]init];
    storyView.frame = CGRectMake(20,28+45+55+200+110,self.view.bounds.size.width-40,210);
    storyView.text = [NSString stringWithFormat:@"Salma is a 29-year-old mother from Yarmouk, Syria, who fled her homeland in August and joined the mass of humanity moving northwest to Western Europe. NBC News spent five days following her and her family's journey from Greece to Germany, listening to her story."];
    storyView.font = [UIFont fontWithName:@"Nexa Bold" size:22];
    storyView.editable = NO;
    storyView.selectable = NO;
    storyView.alwaysBounceVertical = YES;
    storyView.backgroundColor = [UIColor clearColor];
    storyView.textColor = [UIColor grayColor];
    storyView.textAlignment = NSTextAlignmentCenter;
    storyView.layer.borderWidth =0;
    [self.view addSubview:storyView];
    
    viewPlayerContainer = [[UIView alloc]init];
    viewPlayerContainer.backgroundColor = [UIColor clearColor];
    viewPlayerContainer.frame = playBtn.frame;
    [self.view insertSubview:viewPlayerContainer belowSubview:playBtn];

    // Do any additional setup after loading the view.
}


-(void)play{
    PFQuery *query = [PFQuery queryWithClassName:@"mainClass"];
    [query getObjectInBackgroundWithId:@"aXpNBp34vP"
                                 block:^(PFObject *textdu, NSError *error) {
                                     if (!error) {
                                         YouUrl = [textdu objectForKey:@"YTURL"];
                                         urls = [[NSURL alloc]initWithString:YouUrl];

                                         
                                     }else {
                                         NSLog(@"No Service");
                                         
                                     }
                                 }];

 
    AVAsset *asset = [AVAsset assetWithURL:urls];
    AVPlayerItem *playerItem = [[AVPlayerItem alloc] initWithAsset:asset];
    AVPlayer *player = [AVPlayer playerWithPlayerItem:playerItem];
   // AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:player];
   
  //  [layer setPlayer:player];
    
  //  [layer setFrame:playBtn.frame];
  //  [layer setBackgroundColor:[UIColor clearColor].CGColor];
  //  [layer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    
  //  [self.view.layer addSublayer:layer];
    
    AVPlayerViewController *playerController = [[AVPlayerViewController alloc]init];
    playerController.player = player;
    [self presentViewController:playerController animated:YES completion:nil];
    playerController.view.frame = self.view.frame;
    [player play];
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
