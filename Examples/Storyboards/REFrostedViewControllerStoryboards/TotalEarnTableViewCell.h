//
//  TotalEarnTableViewCell.h
//  MCatch
//
//  Created by MCOM Admin on 28/03/2016.
//  Copyright © 2016 Roman Efimov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TotalEarnTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *campaignId;
@property (weak, nonatomic) IBOutlet UILabel *costType;
@property (weak, nonatomic) IBOutlet UILabel *payout;
@property (weak, nonatomic) IBOutlet UILabel *totalUnit;

@property (weak, nonatomic) IBOutlet UILabel *totalPayout;
@end
