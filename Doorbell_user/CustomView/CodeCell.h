//
//  CodeCell.h
//  Doorbell_user
//
//  Created by SilverStar on 3/4/18.
//  Copyright © 2018 Doorbell. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CodeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *mImgFlag;
@property (weak, nonatomic) IBOutlet UILabel *mLblName;
@property (weak, nonatomic) IBOutlet UILabel *mLblCode;

@end
