//
//  newsTableViewCell.m
//  Refugees
//
//  Created by Noah Raissi on 26.10.15.
//  Copyright © 2015 Refugees Welcome. All rights reserved.
//

#import "newsTableViewCell.h"

@implementation newsTableViewCell
@synthesize titleLabel = _titleLabel;
@synthesize mainLabel= _mainLabel;
@synthesize dateLabel  = _dateLabel;
@synthesize thumbnailImageView = _thumbnaulImageView;


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
