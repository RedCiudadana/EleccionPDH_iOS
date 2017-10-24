//
//  DiputadoDetailController.m
//  EleccionesPDH
//
//  Created by Jeffry Turcios on 5/15/17.
//  Copyright © 2017 Codifay. All rights reserved.
//

#import "DiputadoDetailController.h"
#import <Restkit/Restkit.h>
#import "DetailHeaderCell.h"
#import "DetailActionCell.h"
#import "DetailSectionCell.h"
#import "DetailTextCell.h"

@interface DiputadoDetailController ()<UITableViewDataSource, UITableViewDelegate>{
    NSInteger bio;
    NSInteger exp;
    NSInteger rank;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation DiputadoDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView.estimatedRowHeight = 44.0f;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    [_tableView setNeedsLayout];
    [_tableView layoutIfNeeded];
    
    self.title = [self shortName];
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:
                                     [UIImage imageNamed:@"tableview_bg"]];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    bio = 1;
    exp = 1;
    rank = 1;
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
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 2;
            break;
        case 1:
            return bio;
            break;
        case 2:
            return exp;
            break;
        case 3:
            return rank;
            break;
        default:
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *reusableIdentifier = @"";
    
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                    reusableIdentifier = @"diputado_cell";
                    break;
                case 1:
                    reusableIdentifier = @"actions_cell";
                    break;
                default:
                    break;
            }
            break;
        default:
            if (indexPath.row == 0) {
                reusableIdentifier = @"section_cell";
            }else{
                reusableIdentifier = @"info_cell";
            }
            break;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusableIdentifier forIndexPath:indexPath];
    
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                    [((DetailHeaderCell *)cell).pictureIV setImageWithURL:[NSURL URLWithString:[_diputado.fotoUrl stringByReplacingOccurrencesOfString:@"\\" withString:@"/"]] placeholderImage:[UIImage new]];
                    ((DetailHeaderCell *)cell).pictureIV.layer.cornerRadius = ((DetailHeaderCell *)cell).pictureIV.frame.size.height/2;
                    ((DetailHeaderCell *)cell).pictureIV.clipsToBounds = YES;
//                    ((DetailHeaderCell *)cell).pictureIV.layer.borderColor = [[UIColor whiteColor] CGColor];
//                    ((DetailHeaderCell *)cell).pictureIV.layer.borderWidth = 3.0;
                    ((DetailHeaderCell *)cell).nameL.text = _diputado.nombre;
                    [((DetailHeaderCell *)cell).subPictureIV setImageWithURL:[NSURL URLWithString:[_diputado.fotoUrlPartido stringByReplacingOccurrencesOfString:@"\\" withString:@"/"]] placeholderImage:[UIImage new]];
                    //                    ((DetailHeaderCell *)cell).pictureIV.layer.cornerRadius = ((DetailHeaderCell *)cell).pictureIV.frame.size.height/2;
                    //                    ((DetailHeaderCell *)cell).pictureIV.clipsToBounds = YES;
                    
                    ((DetailHeaderCell *)cell).subNameL.text = _diputado.partidoActual;
                    break;
                case 1:
                    [((DetailActionCell *)cell).callBtn setBackgroundColor:[[SingletonUtilities sharedInstance] colorWithName:MAIN_COLOR alpha:1.0f]];
                    [((DetailActionCell *)cell).callBtn setTintColor:[UIColor whiteColor]];
                    ((DetailActionCell *)cell).callBtn.layer.cornerRadius = ((DetailActionCell *)cell).callBtn.frame.size.height/2;
                    ((DetailActionCell *)cell).callBtn.clipsToBounds = YES;
                    [((DetailActionCell *)cell).callBtn addTarget:self action:@selector(callPressed:) forControlEvents:UIControlEventTouchUpInside];
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
                    break;
                default:
                    break;
            }
            break;
        case 1:
            if (indexPath.row == 0) {
                ((DetailSectionCell *)cell).titleL.text = @"Biografía";
            }else{
                if (_diputado.biografia) {
                    NSAttributedString *attributedString = [[NSAttributedString alloc]
                                                            initWithData: [_diputado.biografia dataUsingEncoding:NSUnicodeStringEncoding]
                                                            options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
                                                            documentAttributes: nil
                                                            error: nil
                                                            ];
                    ((DetailTextCell *)cell).contentTV.attributedText = attributedString;
                }
            }
            break;
        case 2:
            if (indexPath.row == 0) {
                ((DetailSectionCell *)cell).titleL.text = @"Desempeño";
            }else{
                NSAttributedString *attributedString = [[NSAttributedString alloc]
                                                        initWithData: [_diputado.desempenio dataUsingEncoding:NSUnicodeStringEncoding]
                                                        options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
                                                        documentAttributes: nil
                                                        error: nil
                                                        ];
                ((DetailTextCell *)cell).contentTV.attributedText = attributedString;
            }
            break;
        case 3:
            if (indexPath.row == 0) {
                ((DetailSectionCell *)cell).titleL.text = @"Historial Político";
            }else{
                ((DetailTextCell *)cell).contentTV.text = _diputado.historialPolitico;
            }
            break;
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section != 0) {
        if (indexPath.row == 0) {
            switch (indexPath.section) {
                case 1:
                    if (bio == 1) {
                        bio = 2;
                        [_tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationAutomatic];
                    }else{
                        bio = 1;
                        [_tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationAutomatic];
                    }
                    break;
                case 2:
                    if (exp == 1) {
                        exp = 2;
                        [_tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationAutomatic];
                    }else{
                        exp = 1;
                        [_tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationAutomatic];
                    }
                    break;
                case 3:
                    if (rank == 1) {
                        rank = 2;
                        [_tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationAutomatic];
                    }else{
                        rank = 1;
                        [_tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationAutomatic];
                    }
                    break;
                default:
                    break;
            }
        }
    }
}

- (IBAction)facebookPressed:(id)sender {
    NSURL *facebookURL = [NSURL URLWithString:_diputado.fb];
    NSURL *facebookAppURL = [NSURL URLWithString:[NSString stringWithFormat:@"fb://profile/%@", [_diputado.fb stringByReplacingOccurrencesOfString:@"https://www.facebook.com/" withString:@""]]];
    UIApplication* app = [ UIApplication sharedApplication ];
    
    if([app canOpenURL: facebookAppURL]) {
        [app openURL:facebookAppURL];
    } else {
        [app openURL:facebookURL];
    }
}

- (IBAction)twitterPressed:(id)sender {
    NSURL *twitterURL = [ NSURL URLWithString:_diputado.tw];
    NSURL *twitterAppURL = [ NSURL URLWithString:[NSString stringWithFormat:@"twitter://user?screen_name=%@", [_diputado.tw stringByReplacingOccurrencesOfString:@"https://twitter.com/" withString:@""]]];
    UIApplication* app = [ UIApplication sharedApplication ];
    if( [ app canOpenURL: twitterAppURL ] ) {
        [ app openURL: twitterAppURL ];
    } else {
        [ app openURL: twitterURL ];
    }
}

- (IBAction)youtubePressed:(id)sender {
    NSURL *youtubeUrl = [NSURL URLWithString:_diputado.yt];
    UIApplication* app = [ UIApplication sharedApplication ];
    [app openURL:youtubeUrl];
}

- (IBAction)callPressed:(id)sender{
    NSString *phoneNumber = [NSString stringWithFormat:@"tel://%@", _diputado.telefono];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
}

- (NSString *)shortName{
    NSArray *nameComps = [_diputado.nombre componentsSeparatedByString:@" "];
    if (nameComps.count >= 3) {
        return [NSString stringWithFormat:@"%@ %@", nameComps[0], nameComps[2]];
    }else if(nameComps.count >= 2){
        return [NSString stringWithFormat:@"%@ %@", nameComps[0], nameComps[1]];
    }else if(nameComps.count >= 1){
        return [NSString stringWithFormat:@"%@", nameComps[0]];
    }else{
        return @"";
    }
}

@end
