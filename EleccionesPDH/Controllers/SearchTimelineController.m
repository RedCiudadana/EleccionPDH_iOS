//
//  SearchTimelineController.m
//  EleccionesPDH
//
//  Created by Jeffry Turcios on 5/15/17.
//  Copyright © 2017 Codifay. All rights reserved.
//

#import "SearchTimelineController.h"

@interface SearchTimelineController ()

@end

@implementation SearchTimelineController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TWTRAPIClient *client = [[TWTRAPIClient alloc] init];
    self.dataSource = [[TWTRSearchTimelineDataSource alloc] initWithSearchQuery:@"#EleccionPDH" APIClient:client];
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

@end
