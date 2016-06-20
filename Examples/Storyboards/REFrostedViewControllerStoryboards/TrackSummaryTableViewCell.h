//
//  TrackSummaryTableViewCell.h
//  MCatch
//
//  Created by MCOM Admin on 26/03/2016.
//  Copyright © 2016 Roman Efimov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TrackSummaryTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *campaignName;

@property (weak, nonatomic) IBOutlet UILabel *costType;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *total;
@end
