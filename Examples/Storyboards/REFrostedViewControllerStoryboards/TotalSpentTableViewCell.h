//
//  TotalSpentTableViewCell.h
//  MCatch
//
//  Created by MCOM Admin on 26/03/2016.
//  Copyright © 2016 Roman Efimov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TotalSpentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *CampaignId;
@property (weak, nonatomic) IBOutlet UILabel *CampaignName;
@property (weak, nonatomic) IBOutlet UILabel *CostType;
@property (weak, nonatomic) IBOutlet UILabel *TotalCount;
@property (weak, nonatomic) IBOutlet UILabel *Date;
@property (weak, nonatomic) IBOutlet UILabel *CurentBid;
@property (weak, nonatomic) IBOutlet UILabel *TotalSpent;

@end
