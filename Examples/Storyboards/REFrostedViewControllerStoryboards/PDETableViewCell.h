//
//  PDETableViewCell.h
//  MCatch
//
//  Created by MCOM Admin on 20/04/2016.
//  Copyright © 2016 MCOM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PDETableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *campId;
@property (weak, nonatomic) IBOutlet UILabel *Id;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *exDate;
@property (weak, nonatomic) IBOutlet UILabel *payout;
@property (weak, nonatomic) IBOutlet UILabel *costType;
@property (weak, nonatomic) IBOutlet UILabel *total;
@property (weak, nonatomic) IBOutlet UILabel *totalPayout;
@property (weak, nonatomic) IBOutlet UILabel *status;

@end
