//
//  ATSTableViewCell.h
//  MCatch
//
//  Created by MCOM Admin on 20/04/2016.
//  Copyright © 2016 MCOM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ATSTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *campId;
@property (weak, nonatomic) IBOutlet UILabel *campName;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *costType;
@property (weak, nonatomic) IBOutlet UILabel *curBid;

@property (weak, nonatomic) IBOutlet UILabel *totalCount;
@property (weak, nonatomic) IBOutlet UILabel *totalSpent;
@end
