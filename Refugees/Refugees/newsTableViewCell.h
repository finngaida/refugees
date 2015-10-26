//
//  newsTableViewCell.h
//  Refugees
//
//  Created by Noah Raissi on 26.10.15.
//  Copyright © 2015 Refugees Welcome. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface newsTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *mainLabel;
@property (nonatomic, weak) IBOutlet UILabel *dateLabel;
@property (nonatomic, weak) IBOutlet UIImageView *thumbnailImageView;

@end
