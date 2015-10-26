//
//  SecondViewController.m
//  Refugees
//
//  Created by Finn Gaida on 18.09.15.
//  Copyright © 2015 Finn Gaida. All rights reserved.
//

#import "DataManager.h"
#import "SecondViewController.h"

@interface SecondViewController ()
@property (nonatomic) NSArray *refugeesItems;
@property (nonatomic) NSArray *helpersItems;
@property (nonatomic) NSArray *dudesItems;
@property (nonatomic) NSArray *items;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.backBarButtonItem.title = @"Back";

    _refugeesItems = @[
                       @[
                           @{@"title":@"Announce yourself", @"subtitle":@"Tell helpers your time of arrival, so they can prepare better", @"queue":@"showAnnounce"},
                           @{@"title":@"Find locations", @"subtitle":@"Close by locations that have agreed to house refugees", @"queue":@"showLocations"},
                           @{@"title":@"Learn", @"subtitle":@"Find out little known or missing information in the debate", @"queue":@"showInfos"}],
                       @[
                           @{@"title":@"Emergeny", @"subtitle":@"Call police/ambulance or find close by shelters", @"queue":@"showEmergency"}]];
    
    _helpersItems =  @[
                       @[
                           @{@"title":@"See news", @"subtitle":@"Look at news", @"queue":@"showNews"},
                           @{@"title":@"Donate", @"subtitle":@"And help local refugees and helpers clear the situation", @"queue":@"showDonate"},
                           @{@"title":@"Find locations", @"subtitle":@"Close by locations that have agreed to house refugees", @"queue":@"showLocations"},
                           @{@"title":@"Learn", @"subtitle":@"Find out little known or missing information in the debate", @"queue":@"showLocations"}]];
    
    _dudesItems =    @[
                       @[
                           @{@"title":@"See news", @"subtitle":@"Look at news", @"queue":@"showNews"},
                           @{@"title":@"Find locations", @"subtitle":@"Close by locations that have agreed to house refugees", @"queue":@"showLocations"},
                           @{@"title":@"Learn", @"subtitle":@"Find out little known or missing information in the debate", @"queue":@"showInfos"}]];
    
    switch ([DataManager sharedManager].type) {
        case FGTypeRefugee: _items = _refugeesItems;break;
        case FGTypeHelper: _items = _helpersItems;break;
        case FGTypeDude: _items = _dudesItems;break;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_items[section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return
    [_items count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"id"];
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 60, 60)];
    img.layer.masksToBounds = YES;
    img.layer.cornerRadius = img.frame.size.width/2;
    img.backgroundColor = [UIColor darkGrayColor];
    [cell.contentView addSubview:img];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(85, 5, cell.frame.size.width-70, 30)];
    title.text = _items[indexPath.section][indexPath.row][@"title"];
    title.font = [UIFont fontWithName:@"HelveticaNeue" size:20];
    [cell.contentView addSubview:title];
    
    UILabel *subtitle = [[UILabel alloc] initWithFrame:CGRectMake(85, 25, cell.frame.size.width-70, 50)];
    subtitle.text = _items[indexPath.section][indexPath.row][@"subtitle"];
    subtitle.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
    subtitle.textColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    subtitle.numberOfLines = 0;
    [cell.contentView addSubview:subtitle];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *segue = _items[indexPath.section][indexPath.row][@"queue"];
    NSLog(@"Should perform segue: %@", segue);
    
    [self performSegueWithIdentifier:segue sender:nil];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
