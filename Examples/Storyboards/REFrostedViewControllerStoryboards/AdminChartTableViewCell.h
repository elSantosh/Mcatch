//
//  AdminChartTableViewCell.h
//  MCatch
//
//  Created by MCOM Admin on 19/04/2016.
//  Copyright © 2016 MCOM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Charts/Charts.h>
#import "DemoBaseViewController.h"

@import Charts;

@interface AdminChartTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet BarChartView *BarChart1;

@property (weak, nonatomic) IBOutlet BarChartView *CurrentBalBarChart;

@property (weak, nonatomic) IBOutlet BarChartView *MReportChart;

@property (weak, nonatomic) IBOutlet BarChartView *MCPChart;

@property (weak, nonatomic) IBOutlet PieChartView *PieChart1;

@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *advName;
@property (weak, nonatomic) IBOutlet UILabel *advBalance;
@property (weak, nonatomic) IBOutlet UILabel *total;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *monthlyTopup;
@property (weak, nonatomic) IBOutlet UILabel *monthlyPayout;
@property (weak, nonatomic) IBOutlet UILabel *balance;
@property (weak, nonatomic) IBOutlet UILabel *monthlyDate;

@property (weak, nonatomic) IBOutlet UILabel *publisher;
@property (weak, nonatomic) IBOutlet UILabel *channelType;

@property (weak, nonatomic) IBOutlet UILabel *total2;

@end
