//
//  AboutController.m
//  EleccionPDH
//
//  Created by Jeffry Turcios on 6/15/17.
//  Copyright © 2017 Codifay. All rights reserved.
//

#import "AboutController.h"
#import "HeaderCell.h"
#import "DetailHeaderCell.h"
#import "DetailActionCell.h"
#import "DetailSectionCell.h"
#import "DetailTextCell.h"
#import <MessageUI/MessageUI.h>

@interface AboutController ()<UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate>{

}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation AboutController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_logo"]];
    
    _tableView.estimatedRowHeight = 44.0f;
    _tableView.estimatedSectionHeaderHeight = 44.0f;
    _tableView.sectionHeaderHeight = 44.0f;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    [_tableView setNeedsLayout];
    [_tableView layoutIfNeeded];
    
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:
                                     [UIImage imageNamed:@"launch_bg_alt"]];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *reusableIdentifier = @"";

    if (indexPath.row == 0) {
        reusableIdentifier = @"info_cell";
    }else{
        reusableIdentifier = @"actions_cell";
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusableIdentifier forIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        
    }else{
        [((DetailActionCell *)cell).callBtn setBackgroundColor:[[SingletonUtilities sharedInstance] colorWithName:MAIN_COLOR alpha:1.0f]];
        [((DetailActionCell *)cell).callBtn setTintColor:[UIColor whiteColor]];
        ((DetailActionCell *)cell).callBtn.layer.cornerRadius = ((DetailActionCell *)cell).callBtn.frame.size.height/2;
        ((DetailActionCell *)cell).callBtn.clipsToBounds = YES;
        [((DetailActionCell *)cell).callBtn addTarget:self action:@selector(webPressed:) forControlEvents:UIControlEventTouchUpInside];
        [((DetailActionCell *)cell).facebookBtn setBackgroundColor:[[SingletonUtilities sharedInstance] colorWithName:MAIN_COLOR alpha:1.0f]];
        [((DetailActionCell *)cell).facebookBtn setTintColor:[UIColor whiteColor]];
        ((DetailActionCell *)cell).facebookBtn.layer.cornerRadius = ((DetailActionCell *)cell).callBtn.frame.size.height/2;
        ((DetailActionCell *)cell).facebookBtn.clipsToBounds = YES;
        [((DetailActionCell *)cell).facebookBtn addTarget:self action:@selector(facebookPressed:)forControlEvents:UIControlEventTouchUpInside];
        [((DetailActionCell *)cell).twitterBtn setBackgroundColor:[[SingletonUtilities sharedInstance] colorWithName:MAIN_COLOR alpha:1.0f]];
        [((DetailActionCell *)cell).twitterBtn setTintColor:[UIColor whiteColor]];
        ((DetailActionCell *)cell).twitterBtn.layer.cornerRadius = ((DetailActionCell *)cell).callBtn.frame.size.height/2;
        ((DetailActionCell *)cell).twitterBtn.clipsToBounds = YES;
        [((DetailActionCell *)cell).twitterBtn addTarget:self action:@selector(twitterPressed:) forControlEvents:UIControlEventTouchUpInside];
        [((DetailActionCell *)cell).youtubeBtn setBackgroundColor:[[SingletonUtilities sharedInstance] colorWithName:MAIN_COLOR alpha:1.0f]];
        [((DetailActionCell *)cell).youtubeBtn setTintColor:[UIColor whiteColor]];
        ((DetailActionCell *)cell).youtubeBtn.layer.cornerRadius = ((DetailActionCell *)cell).callBtn.frame.size.height/2;
        ((DetailActionCell *)cell).youtubeBtn.clipsToBounds = YES;
        [((DetailActionCell *)cell).youtubeBtn addTarget:self action:@selector(youtubePressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    HeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"header_cell"];
    cell.titleL.text = @"Acerca de";
    return cell.contentView;
}


- (IBAction)facebookPressed:(id)sender {
    NSURL *facebookURL = [NSURL URLWithString:@"https://www.facebook.com/Redciudadanagt"];
    NSURL *facebookAppURL = [NSURL URLWithString:@"fb://profile/Redciudadanagt"];
    UIApplication* app = [ UIApplication sharedApplication ];
    
    if([app canOpenURL: facebookAppURL]) {
        [app openURL:facebookAppURL];
    } else {
        [app openURL:facebookURL];
    }
}

- (IBAction)twitterPressed:(id)sender {
    NSURL *twitterURL = [ NSURL URLWithString:@"https://twitter.com/RedxGuate"];
    NSURL *twitterAppURL = [ NSURL URLWithString:@"twitter://user?screen_name=RedxGuate"];
    UIApplication* app = [ UIApplication sharedApplication ];
    if( [ app canOpenURL: twitterAppURL ] ) {
        [ app openURL: twitterAppURL ];
    } else {
        [ app openURL: twitterURL ];
    }
}

- (IBAction)youtubePressed:(id)sender {
//    NSURL *youtubeUrl = [NSURL URLWithString:@"https://www.youtube.com/channel/UCQwc62j7beStZYFzwPxBEQg"];
//    UIApplication* app = [ UIApplication sharedApplication ];
//    [app openURL:youtubeUrl];
    
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *composeViewController = [[MFMailComposeViewController alloc] initWithNibName:nil bundle:nil];
        [composeViewController setMailComposeDelegate:self];
        [composeViewController setToRecipients:@[@"congreso@redciudadana.org"]];
        [composeViewController setSubject:@""];
        [self presentViewController:composeViewController animated:YES completion:nil];
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    //Add an alert in case of failure
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)webPressed:(id)sender{
    NSURL *websiteUrl = [NSURL URLWithString:@"http://www.redciudadana.org"];
    UIApplication* app = [ UIApplication sharedApplication ];
    [app openURL:websiteUrl];
}



@end
