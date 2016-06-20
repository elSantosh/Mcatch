//
//  ATSumTableViewCell.h
//  MCatch
//
//  Created by MCOM Admin on 20/04/2016.
//  Copyright © 2016 MCOM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ATSumTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *campName;
@property (weak, nonatomic) IBOutlet UILabel *advName;
@property (weak, nonatomic) IBOutlet UILabel *costType;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *total;
@end
