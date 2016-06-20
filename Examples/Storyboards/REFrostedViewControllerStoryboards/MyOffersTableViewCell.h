//
//  MyOffersTableViewCell.h
//  MCatch
//
//  Created by MCOM Admin on 28/03/2016.
//  Copyright © 2016 Roman Efimov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyOffersTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *advId;
@property (weak, nonatomic) IBOutlet UILabel *tranId;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *country;
@property (weak, nonatomic) IBOutlet UILabel *payout;
@property (weak, nonatomic) IBOutlet UILabel *costType;
@property (weak, nonatomic) IBOutlet UILabel *url;
@property (weak, nonatomic) IBOutlet UILabel *platform;
@property (weak, nonatomic) IBOutlet UILabel *platTypeDesc;
@property (weak, nonatomic) IBOutlet UILabel *remarks;
@property (weak, nonatomic) IBOutlet UILabel *campId;

@end
