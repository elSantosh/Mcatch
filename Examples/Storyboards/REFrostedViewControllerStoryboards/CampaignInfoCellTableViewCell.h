//
//  CampaignInfoCellTableViewCell.h
//  MCatch
//
//  Created by MCOM Admin on 25/03/2016.
//  Copyright © 2016 Roman Efimov. All rights reserved.
//

#import <UIKit/UIKit.h>

@import Charts ;


@interface CampaignInfoCellTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet HorizontalBarChartView *chartView;

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UILabel *country;
@property (weak, nonatomic) IBOutlet UILabel *bidPrice;
@property (weak, nonatomic) IBOutlet UILabel *CPA;

@end
