//
//  ViewController.m
//  EleccionesPDH
//
//  Created by Jeffry Turcios on 5/14/17.
//  Copyright © 2017 Codifay. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self setupBaseKVNProgressUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _navBarType = SOLID;
    NSShadow *shadow = [NSShadow new];
    switch (_navBarType) {
        case TRANSPARENT:
            self.navigationController.navigationBar.titleTextAttributes = @{
                                                                            NSForegroundColorAttributeName: [UIColor whiteColor],
                                                                            NSShadowAttributeName: shadow,
                                                                            NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Medium" size:20.0f]
                                                                            };
            [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
            self.navigationController.navigationBar.shadowImage = [UIImage new];
            [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
            break;
        case SOLID:
            self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
            self.navigationController.navigationBar.titleTextAttributes = @{
                                                                            NSForegroundColorAttributeName:[UIColor whiteColor],
                                                                            NSShadowAttributeName:shadow,
                                                                            NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Medium" size:20.0f]
                                                                            };
            [self.navigationController.navigationBar setBarTintColor:[[SingletonUtilities sharedInstance] colorWithName:MAIN_COLOR alpha:1.0f]];
            [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
            break;
        default:
            self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
            self.navigationController.navigationBar.titleTextAttributes = @{
                                                                            NSForegroundColorAttributeName:[UIColor whiteColor],
                                                                            NSShadowAttributeName:shadow,
                                                                            NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Medium" size:20.0f]
                                                                            };
            [self.navigationController.navigationBar setBarTintColor:[[SingletonUtilities sharedInstance] colorWithName:MAIN_COLOR alpha:1.0f]];
            [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
            break;
    }
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

- (void)setupBaseKVNProgressUI{
    
    KVNProgressConfiguration *configuration = [[KVNProgressConfiguration alloc] init];
    configuration.statusColor = [UIColor darkGrayColor];
    configuration.statusFont = [UIFont systemFontOfSize:17.0f];
    configuration.circleStrokeForegroundColor = [[SingletonUtilities sharedInstance] colorWithName:ALT_COLOR alpha:1.0f];
    configuration.circleStrokeBackgroundColor = [UIColor darkGrayColor];
    configuration.backgroundFillColor = [UIColor colorWithWhite:0.9f alpha:0.9f];
    configuration.backgroundTintColor = [UIColor whiteColor];
    configuration.successColor = [[SingletonUtilities sharedInstance] colorWithName:ALT_COLOR alpha:1.0f];
    configuration.errorColor = [[SingletonUtilities sharedInstance] colorWithName:ALT_COLOR alpha:1.0f];
    configuration.circleSize = 75.0f;
    configuration.lineWidth = 2.0f;
    
    [KVNProgress setConfiguration:configuration];
    
}

@end
