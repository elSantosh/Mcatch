//
//  AdminDashboardViewController.h
//  MCatch
//
//  Created by MCOM Admin on 13/04/2016.
//  Copyright © 2016 MCOM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"

#import "DemoBaseViewController.h"
#import <Charts/Charts.h>

@import Charts;

@interface AdminDashboardViewController : DemoBaseViewController

@property (nonatomic, strong) NSMutableDictionary *result;

@property(nonatomic, strong) NSMutableArray *topupCount;
@property(nonatomic,strong) NSMutableArray *topupDate;

@property(nonatomic, strong) NSMutableArray *AdvCount;
@property(nonatomic, strong) NSMutableArray *curBalCount;

@property(nonatomic, strong) NSMutableArray *MTotalCount;
@property(nonatomic, strong) NSMutableArray *MDateCount;

@property (nonatomic, strong) NSMutableArray *MTopupCount;
@property (nonatomic,strong) NSMutableArray *MPayoutCount;
@property (nonatomic, strong) NSMutableArray *MBalanceCount;
@property(nonatomic, strong) NSMutableArray *MCPDateCount;

@property (nonatomic, strong) NSMutableArray *PTotalCount;
@property (nonatomic, strong) NSMutableArray *PLegendCount;
@property (nonatomic, strong) NSMutableArray *PChannelTypeCount;
@property (nonatomic, strong) NSMutableArray *PPercent;
@property (nonatomic, strong) NSMutableArray *PPercent2;
@property (nonatomic, strong) NSMutableArray *PName;


@property(nonatomic,strong) NSMutableArray
*MTopupDateCount;


@property (weak, nonatomic) IBOutlet UIScrollView *chartScrollView;

- (IBAction)menu:(id)sender;

@property (weak, nonatomic) IBOutlet BarChartView *barChart;

@property (weak, nonatomic) IBOutlet BarChartView *CurrentBalBarChart;

@property (weak, nonatomic) IBOutlet BarChartView *MReportChart;
@property (weak, nonatomic) IBOutlet BarChartView *MCPChart;

@property (weak, nonatomic) IBOutlet PieChartView *PieChart1;

@property (weak, nonatomic) IBOutlet UITableView *DropDownTable;
@property (weak, nonatomic) IBOutlet UITableView *mainTable;

@end
