//
//  PTETableViewCell.h
//  MCatch
//
//  Created by MCOM Admin on 20/04/2016.
//  Copyright © 2016 MCOM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PTETableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *campId;

@property (weak, nonatomic) IBOutlet UILabel *Id;
@property (weak, nonatomic) IBOutlet UILabel *costType;
@property (weak, nonatomic) IBOutlet UILabel *payout;
@property (weak, nonatomic) IBOutlet UILabel *totalUnit;
@property (weak, nonatomic) IBOutlet UILabel *totalPayout;
@end
