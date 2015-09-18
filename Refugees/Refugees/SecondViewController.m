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

    _refugeesItems = @[@[@{@"title":@"Donate", @"subtitle":@"And help local refugees and helpers clear the situation"}, @{@"title":@"Find locations", @"subtitle":@"Close by locations that have agreed to house refugees"}, @{@"title":@"Learn", @"subtitle":@"Find out little known or missing information in the debate"}], @[@{@"title":@"Some title", @"subtitle":@"Some substitle"}, @{@"title":@"Some other title", @"subtitle":@"Some other substitle"}]];
    
    _helpersItems = @[@[@{@"title":@"Donate", @"subtitle":@"And help local refugees and helpers clear the situation"}, @{@"title":@"Find locations", @"subtitle":@"Close by locations that have agreed to house refugees"}, @{@"title":@"Learn", @"subtitle":@"Find out little known or missing information in the debate"}], @[@{@"title":@"Some title", @"subtitle":@"Some substitle"}, @{@"title":@"Some other title", @"subtitle":@"Some other substitle"}]];
    
    _dudesItems = @[@[@{@"title":@"Donate", @"subtitle":@"And help local refugees and helpers clear the situation"}, @{@"title":@"Find locations", @"subtitle":@"Close by locations that have agreed to house refugees"}, @{@"title":@"Learn", @"subtitle":@"Find out little known or missing information in the debate"}], @[@{@"title":@"Some title", @"subtitle":@"Some substitle"}, @{@"title":@"Some other title", @"subtitle":@"Some other substitle"}]];
    
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
    
    cell.textLabel.text = _items[indexPath.section][indexPath.row][@"title"];
    cell.detailTextLabel.text = _items[indexPath.section][indexPath.row][@"subtitle"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
