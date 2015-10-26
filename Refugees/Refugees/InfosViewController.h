//
//  InfosViewController.h
//  Refugees
//
//  Created by Finn Gaida on 19.09.15.
//  Copyright © 2015 Finn Gaida. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfosViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
    
    UIButton *closeBtn;
    UILabel *titleLabel;
    UITableView *mainTableView;
    
    
}

@end
/*
cell.titleLabel.text = [tableTitle objectAtIndex:indexPath.row];
cell.thumbnailImageView.image = [UIImage imageNamed:[tableImg objectAtIndex:indexPath.row]];
cell.mainLabel.text = [tableMain objectAtIndex:indexPath.row];
cell.dateLabel.text = [tableDate objectAtIndex:indexPath.row];
*/