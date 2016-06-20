//
//  ALCTableViewCell.h
//  MCatch
//
//  Created by MCOM Admin on 20/04/2016.
//  Copyright © 2016 MCOM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALCTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *advId;

@property (weak, nonatomic) IBOutlet UILabel *advName;
@property (weak, nonatomic) IBOutlet UILabel *balance;

@end
