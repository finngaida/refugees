//
//  InfosViewController.m
//  Refugees
//
//  Created by Finn Gaida on 19.09.15.
//  Copyright © 2015 Finn Gaida. All rights reserved.
//

#import "InfosViewController.h"
#import "newsTableViewCell.h"
@interface InfosViewController ()

@end

@implementation InfosViewController
{
    NSArray *tableTitle;
    NSArray *tableMain;
    NSArray *tableDate;
    NSArray *tableImg;
}
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
    
    mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,28+45+55,self.view.bounds.size.width,self.view.bounds.size.height-(28+45+55)) style:UITableViewStylePlain] ;
    mainTableView.dataSource = self;
    mainTableView.delegate = self;
    mainTableView.backgroundColor =[UIColor colorWithRed:0.937f green:0.925f blue:0.925f alpha:1.00f];
    [self.view addSubview:mainTableView];
    

    
    titleLabel = [[UILabel alloc]init];
    titleLabel.frame = CGRectMake(20,28+45,self.view.bounds.size.width-40,55);
    titleLabel.text = [NSString stringWithFormat:@"NEWS"];
    titleLabel.font = [UIFont fontWithName:@"Nexa Bold" size:40];
    titleLabel.numberOfLines = 1;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.backgroundColor = [UIColor colorWithRed:0.937f green:0.925f blue:0.925f alpha:1.00f];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.layer.borderWidth =0;
    [self.view addSubview:titleLabel];
    
    UIView *shadownView = [[UIView alloc]init];
    shadownView.backgroundColor =[UIColor colorWithRed:0.937f green:0.925f blue:0.925f alpha:1.00f];
    shadownView.frame = CGRectMake(0, 28+45+57, self.view.bounds.size.width, 2);
    shadownView.layer.shadowOpacity = 1;
    shadownView.layer.shadowOffset = CGSizeMake(0, 2);
    shadownView.layer.shadowRadius = 12;
    [self.view addSubview:shadownView];

    



    
    tableTitle = [[NSArray alloc ]initWithObjects:@"Refugee Crisis",@"Refugee Policy",@"Asylum Policy",nil];
    tableMain = [[NSArray alloc ]initWithObjects:@"EU-Gipfel beschließt 100.000 Aufnahmeplätze zusätzlich. Entlang der Balkanroute soll es deutlich mehr Aufnahmeplätze für Flüchtlinge geben. Der EU-Gipfel beschloss auch eine neue Frontex-Mission an der griechischen Grenze. ",@"Gigantomanisch und ideologisch sei die Flüchtlingspolitik des Senats, kritisieren CDU und FDP. Die Oppositionsparteien setzen auf viele kleine Unterkünfte. Volksverdummung nennt das die SPD. Was stimmt? ",@"Angela Merkels Handeln in der Flüchtlingskrise verdient größten Respekt. Sie hat sich für das Asylrecht und gegen die \"Festung Europa\" entschieden. Auch wenn sich die konservative Abwehrfront bereits formiert: Nun muss sich der Kontinent demografisch erweitern und politisch neu definieren. ",nil];
    tableDate = [[NSArray alloc ]initWithObjects:@"25.10.15",@"25.10.15",@"22.10.15",nil];
    tableImg = [[NSArray alloc ]initWithObjects:@"merkel",@"bau",@"junge",nil];

   /* NSString *path = [[NSBundle mainBundle] pathForResource:@"news" ofType:@"plist"];
    
    // Load the file content and read the data into arrays
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    tableTitle = [dict objectForKey:@"Title"];
    tableMain = [dict objectForKey:@"Description"];
    tableDate = [dict objectForKey:@"Date"];
    tableImg = [dict objectForKey:@"Thumbnail"];

*/
    [self.view addSubview:mainTableView];

    // Do any additional setup after loading the view.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        NSURL *url=[NSURL URLWithString:@"http://www.zeit.de/politik/ausland/2015-10/fluechtlingskrise-eu-krisentreffen-bruessel"];
        [[UIApplication sharedApplication] openURL:url];

    }else if (indexPath.row == 1){
        NSURL *url=[NSURL URLWithString:@"http://www.zeit.de/2015/43/fluechtlingspolitik-unterkunft-hamburg"];
        [[UIApplication sharedApplication] openURL:url];

    }else if (indexPath.row == 2){
        NSURL *url=[NSURL URLWithString:@"http://www.zeit.de/2015/41/asypolitik-europa-fluechtlinge-angela-merkel"];
        [[UIApplication sharedApplication] openURL:url];

    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"newsTableViewCell";
    
    newsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"newsTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.titleLabel.text = [tableTitle objectAtIndex:indexPath.row];
    cell.thumbnailImageView.image = [UIImage imageNamed:[tableImg objectAtIndex:indexPath.row]];
    cell.mainLabel.text = [tableMain objectAtIndex:indexPath.row];
    cell.dateLabel.text = [tableDate objectAtIndex:indexPath.row];

    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableTitle count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 388;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
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

@end
