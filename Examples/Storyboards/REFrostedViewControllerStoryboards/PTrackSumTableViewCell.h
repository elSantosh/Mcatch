//
//  PTrackSumTableViewCell.h
//  MCatch
//
//  Created by MCOM Admin on 28/03/2016.
//  Copyright © 2016 Roman Efimov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PTrackSumTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *campaignId;

@property (weak, nonatomic) IBOutlet UILabel *advId;

@property (weak, nonatomic) IBOutlet UILabel *Id;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *costType;
@property (weak, nonatomic) IBOutlet UILabel *total;

@end
