//
//  ACATableViewCell.h
//  MCatch
//
//  Created by MCOM Admin on 20/04/2016.
//  Copyright © 2016 MCOM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ACATableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *Id;
@property (weak, nonatomic) IBOutlet UILabel *costType;
@property (weak, nonatomic) IBOutlet UILabel *total;

@end
