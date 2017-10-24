//
//  DetailHeaderCell.h
//  EleccionesPDH
//
//  Created by Jeffry Turcios on 5/15/17.
//  Copyright © 2017 Codifay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailHeaderCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *pictureIV;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UIImageView *subPictureIV;
@property (weak, nonatomic) IBOutlet UILabel *subNameL;

@end
