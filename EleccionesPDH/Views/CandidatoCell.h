//
//  CandidatoCell.h
//  EleccionesPDH
//
//  Created by Jeffry Turcios on 5/15/17.
//  Copyright © 2017 Codifay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CandidatoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *pictureIV;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *indexL;
@property (weak, nonatomic) IBOutlet UILabel *gradeL;

@end
