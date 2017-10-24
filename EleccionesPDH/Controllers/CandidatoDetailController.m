//
//  CandidatoDetailController.m
//  EleccionesPDH
//
//  Created by Jeffry Turcios on 5/15/17.
//  Copyright © 2017 Codifay. All rights reserved.
//

#import "CandidatoDetailController.h"
#import <Restkit/Restkit.h>
#import "DetailHeaderCell.h"
#import "DetailTextCell.h"
#import "DetailSectionCell.h"

@interface CandidatoDetailController () <UITableViewDataSource, UITableViewDelegate>{
    NSInteger bio;
    NSInteger exp;
    NSInteger rank;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation CandidatoDetailController

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
            return 1;
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
            reusableIdentifier = @"candidato_cell";
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
            [((DetailHeaderCell *)cell).pictureIV setImageWithURL:[NSURL URLWithString:[_perfil.fotoUrl stringByReplacingOccurrencesOfString:@"\\" withString:@"/"]] placeholderImage:[UIImage new]];
            ((DetailHeaderCell *)cell).pictureIV.layer.cornerRadius = ((DetailHeaderCell *)cell).pictureIV.frame.size.height/2;
            ((DetailHeaderCell *)cell).pictureIV.clipsToBounds = YES;
            ((DetailHeaderCell *)cell).nameL.text = _perfil.nombre;
            break;
        case 1:
            if (indexPath.row == 0) {
                ((DetailSectionCell *)cell).titleL.text = @"Biografía";
            }else{
                ((DetailTextCell *)cell).contentTV.text = _perfil.biografia;
                if (_perfil.biografia) {
                    NSAttributedString *attributedString = [[NSAttributedString alloc]
                                                            initWithData: [_perfil.biografia dataUsingEncoding:NSUnicodeStringEncoding]
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
                ((DetailSectionCell *)cell).titleL.text = @"Experiencia Profesional";
            }else{
                ((DetailTextCell *)cell).contentTV.text = _perfil.experienciaProfesional;
            }
            break;
        case 3:
            if (indexPath.row == 0) {
                ((DetailSectionCell *)cell).titleL.text = @"Tabla de Gradación";
            }else{
                ((DetailTextCell *)cell).contentTV.text = _perfil.experienciaEnDH;
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

- (NSString *)shortName{
    NSArray *nameComps = [_perfil.nombre componentsSeparatedByString:@" "];
    
    if (nameComps.count >= 4) {
        return [NSString stringWithFormat:@"%@ %@", nameComps[0], nameComps[2]];
    }if(nameComps.count >= 2){
        return [NSString stringWithFormat:@"%@ %@", nameComps[0], nameComps[1]];
    }else if(nameComps.count >= 1){
        return nameComps[0];
    }else{
        return @"";
    }
}

@end
