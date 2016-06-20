//
//  TopupTableViewCell.h
//  MCatch
//
//  Created by MCOM Admin on 25/03/2016.
//  Copyright © 2016 Roman Efimov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopupTableViewCell : UITableViewCell
//Details

@property (weak, nonatomic) IBOutlet UILabel *AdvId;
@property (weak, nonatomic) IBOutlet UILabel *AdvName;

@property (weak, nonatomic) IBOutlet UILabel *Year;

@property (weak, nonatomic) IBOutlet UILabel *Month;

@property (weak, nonatomic) IBOutlet UILabel *TotalSpent;

@end
