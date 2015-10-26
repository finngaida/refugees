//
//  StoryViewController.h
//  Refugees
//
//  Created by Noah Raissi on 26.10.15.
//  Copyright © 2015 Refugees Welcome. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoryViewController : UIViewController {
    UIButton *closeBtn;
    UILabel *titleLabel;
    UILabel *storyLbl;
    UIButton *playBtn;
    UITextView *storyView;
    UILabel*dateLbl;
    
    UIView *viewPlayerContainer;
    NSString *YouUrl;
    NSURL *urls;
}

@end
