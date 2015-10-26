//
//  StatsViewController.h
//  Refugees
//
//  Created by Noah Raissi on 25.10.15.
//  Copyright © 2015 Refugees Welcome. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UICountingLabel.h"
@interface StatsViewController : UIViewController {
    
    UIScrollView *mainScrollView;
     UILabel *titleLabel;
    UIImageView *landImg;
    UICountingLabel *refugeeCountDE;

    UILabel *countLbl;
    UIImageView *groupImg;
    UICountingLabel *refugeeCountHH;
    
    UICountingLabel *ManLbl;
    UILabel *ManTitleLbl;
    UILabel *ManSubtitleLbl;
    UIImageView *manImg;
    
     UICountingLabel *updatingRefugeeCount;
    UILabel *titleRefLbl;
     UIImageView *mobileImg;
    
     UIImageView *suppsImg;
     UICountingLabel *suppLbl;
    
    UILabel *disclosureLbl;
    
    
    UIButton *closeBtn;
    int supps;
    int refs;

}



@end
