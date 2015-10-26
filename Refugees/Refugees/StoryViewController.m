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
    
 
    NSURL *url = [[NSURL alloc]initWithString:@"https://r5---sn-i5h7ln76.c.youtube.com/videoplayback?pl=14&dur=781.212&lmt=1445861053032416&ip=188.108.151.163&ms=nxu&mv=m&source=youtube&id=o-ALH3lsbdO7Wwi0ZKjptvqko-_10oeDAjwU_ZsjR3-toG&mn=sn-i5h7ln76&mm=30&signature=B426E475A9DFDCD6BB60E0EAEAC4C2A43B91191F.330D242DA1034853B0894DB5E8040AAFE07F7785&sver=3&requiressl=yes&itag=18&ratebypass=yes&fexp=9406715%2C9407610%2C9408145%2C9408710%2C9414764%2C9416126%2C9417368%2C9417707%2C9419401%2C9421524%2C9421978%2C9422359%2C9423240&ipbits=8&mt=1445864495&mime=video%2Fmp4&initcwndbps=3028750&cp=U0lTSlhTVF9JUENPM19QTVhCOmNkdWpBUWw2Um15&key=yt6&expire=1445886146&sparams=cp%2Cdur%2Cid%2Cinitcwndbps%2Cip%2Cipbits%2Citag%2Clmt%2Cmime%2Cmm%2Cmn%2Cms%2Cmv%2Cpl%2Cratebypass%2Crequiressl%2Csource%2Cupn%2Cexpire&upn=bdYr6r5dEcM&signature="];
    AVAsset *asset = [AVAsset assetWithURL:url];
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
