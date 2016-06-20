//
//  AdminDashboardViewController.m
//  MCatch
//
//  Created by MCOM Admin on 13/04/2016.
//  Copyright © 2016 MCOM. All rights reserved.
//

#import "AdminDashboardViewController.h"

#import "MCatch-Swift.h"
#import "MCatch-Bridging-Header.h"

#import "AdminChartTableViewCell.h"


#import "SVProgressHUD.h"

@interface SectionItem : NSObject

@property (nonatomic,assign)BOOL isFolding;

@end

@implementation SectionItem
@synthesize isFolding=_isFolding;

@end
@interface AdminDashboardViewController ()<ChartViewDelegate>
{
    NSInteger total;
    NSInteger today;
    
    //Chart 1
    NSValue *topup;
    NSValue *date;
    NSInteger limit;

    //Chart 2
    NSString *AdvName;
    NSString *curBal;
    NSInteger limit2;
    
    //Chart 3
    NSString *mTotal;
    NSString *mDate;
    NSInteger limit3;
    
    //Chart 4
    
    NSString *mTopup;
    NSString *mPayout;
    NSString *mBalance;
    NSString *mcpDate;
    
    NSInteger limit4;
    
    //Charrt 5
    
    NSString *ptotal;
    NSInteger pSum;
    NSInteger pSum2;
    NSString *plegendString;
    
    NSInteger limit5;
    double percent2;
    
    //Dropdown Table
    
     NSMutableArray *sections;
    
}
@property (nonatomic, strong) AdminChartTableViewCell *cell1;

@property (nonatomic, strong) IBOutlet UISlider *sliderX;

@property (nonatomic, strong) IBOutlet UISlider *sliderY;

@end

@implementation AdminDashboardViewController

@synthesize result,topupCount,topupDate, AdvCount,curBalCount;

-(void)viewWillAppear:(BOOL)animated{
   
    for(int i=0;i<10;i++){
    if(i % 2){
    NSIndexSet *set=[NSIndexSet indexSetWithIndex:1];
    SectionItem *item=[sections objectAtIndex:i];
    [item setIsFolding:!item.isFolding];
    [self.DropDownTable reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
    [self.mainTable reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
    }
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
        //table
   [SVProgressHUD show];
    
    sections=[[NSMutableArray alloc]init];
    for(int i=0;i<10;i++){
        SectionItem *item=[[SectionItem alloc]init];
        [sections addObject:item];
    }
    //[self.mainTable setContentOffset:CGPointMake(0, CGFLOAT_MAX)];
    
    [self.DropDownTable setContentInset:UIEdgeInsetsMake(40, 0, 0, 0)];
    [self.mainTable setContentInset:UIEdgeInsetsMake(40, 0, 0, 0)];//
    
    self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];
   
    
    self.cell1.BarChart1.hidden= YES;
    self.cell1.CurrentBalBarChart.hidden= YES;
    self.cell1.MReportChart.hidden = YES;
    self.cell1.MCPChart.hidden = YES;
    self.cell1.PieChart1.hidden= YES;
    
    self.mainTable.hidden = YES;
   
    //Calling *******API************
    
    //dispatch_async(dispatch_get_main_queue(), ^{
    NSString *accID = [[NSUserDefaults standardUserDefaults] objectForKey:@"AccID"];
    
    NSString *urlString = [NSString stringWithFormat:@"http://mobilemcatch.mcommsg.com/AdminCharts.aspx?AdminID=%@",accID];
    //NSLog(@"%@", urlString);
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         //NSLog(@"%@",data);
         if (error)
         {
             // NSLog(@"error");
         }
         else
         {
             //NSString *res= [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
             //                     NSLog(@"Response: %@", res);
             NSError *error = nil;
             NSMutableDictionary *jsonData = [NSJSONSerialization
                                         JSONObjectWithData:data
                                         options:NSJSONReadingMutableContainers
                                         error:&error];
             
             dispatch_async(dispatch_get_main_queue(), ^{
                 
                 self.result = jsonData;
           
                 [self.mainTable reloadData];
                 self.mainTable.hidden = NO;
                 
                 [SVProgressHUD dismiss];
                 
                 
             });
         }
     }];
  
}
- (void)updateChartData
{
    if (self.shouldHideData)
    {
        //static NSString *MyIdentifier = @"campaigninfocell";
        //CampaignInfoCellTableViewCell *cell = [_CampaignInfoTable dequeueReusableCellWithIdentifier:MyIdentifier];
        self.barChart.data = nil;
        return;
    }
    
    [self setDataCount:(_sliderX.value + 1) range:_sliderY.value];
}
#pragma mark - Chart 1 Methods

- (void)setDataCount:(int)count range:(double)range
{
    NSMutableArray *xVals = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++)
    {
        months = self.topupDate;
        [xVals addObject:months[i % 12]];
        //[xVals addObject:self.topupDate[i%12]];
    }
    
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    NSMutableArray *yVals2 = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++)
    {
        // double mult = (range + 1);
        
        //double val = 20;
        double val2 = 40;
        
       // NSLog(@"%@", self.topupCount);
        
        [yVals addObject:[[BarChartDataEntry alloc] initWithValue:[[self.topupCount objectAtIndex:i] doubleValue] xIndex:i]];
        
        [yVals2 addObject:[[BarChartDataEntry alloc] initWithValue:val2 xIndex:i]];
    }
    
    BarChartDataSet *set1 = [[BarChartDataSet alloc] initWithYVals:yVals label:@"Balance"];
    // set1.barSpace = 0.35;
    set1.colors = [[NSArray alloc] initWithObjects:
                   [UIColor greenColor],nil];
    
//    BarChartDataSet *set2 = [[BarChartDataSet alloc] initWithYVals:yVals2 label:@"Today"];
//    
//    set2.colors = [[NSArray alloc] initWithObjects:
//                   [UIColor blackColor],nil];
    
    //set1.barSpace = 0.35;
    
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    [dataSets addObject:set1];
    //[dataSets addObject:set2];
    
    BarChartData *data = [[BarChartData alloc] initWithXVals:xVals dataSets:dataSets];
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:6]];
    
    //static NSString *MyIdentifier = @"campaigninfocell";
   // self.barChart.data = data;
    self.cell1.BarChart1.data = data;
    
}

#pragma mark - Chart 2 Methods

-(void)setDataCount2:(int)count range:(double)range
{
    NSMutableArray *xVals = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++)
    {
        months = self.AdvCount;
        [xVals addObject:months[i % 12]];
        //[xVals addObject:self.topupDate[i%12]];
    }
    
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    NSMutableArray *yVals2 = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++)
    {
        // double mult = (range + 1);
        
        double val = [[self.curBalCount objectAtIndex:i] doubleValue];
        if (val<0) {
            val = -(val);
        }
        double val2 = 40;
        
       
        
        [yVals addObject:[[BarChartDataEntry alloc] initWithValue:val xIndex:i]];
        
        [yVals2 addObject:[[BarChartDataEntry alloc] initWithValue:val2 xIndex:i]];
    }
    
    BarChartDataSet *set1 = [[BarChartDataSet alloc] initWithYVals:yVals label:@"Current Balance"];
    // set1.barSpace = 0.35;
    set1.colors = [[NSArray alloc] initWithObjects:
                   [UIColor redColor],nil];
    
    //    BarChartDataSet *set2 = [[BarChartDataSet alloc] initWithYVals:yVals2 label:@"Today"];
    //
    //    set2.colors = [[NSArray alloc] initWithObjects:
    //                   [UIColor blackColor],nil];
    
    //set1.barSpace = 0.35;
    
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    [dataSets addObject:set1];
    //[dataSets addObject:set2];
    
    BarChartData *data = [[BarChartData alloc] initWithXVals:xVals dataSets:dataSets];
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:6]];
    
    
    self.cell1.CurrentBalBarChart.data = data;
    
}

#pragma mark - Chart 3 Methods

-(void)setDataCount3:(int)count range:(double)range
{
    NSMutableArray *xVals = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++)
    {
        
        months = self.MDateCount;
        [xVals addObject:months[i % 12]];
        //[xVals addObject:self.topupDate[i%12]];
    }
    
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    NSMutableArray *yVals2 = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++)
    {
        // double mult = (range + 1);
        
        double val = [[self.MTotalCount objectAtIndex:i] doubleValue];
//        if (val<0) {
//            val = -(val);
//        }
        double val2 = 40;
        
        
        
        [yVals addObject:[[BarChartDataEntry alloc] initWithValue:val xIndex:i]];
        
        [yVals2 addObject:[[BarChartDataEntry alloc] initWithValue:val2 xIndex:i]];
    }
    
    BarChartDataSet *set1 = [[BarChartDataSet alloc] initWithYVals:yVals label:@"Current Balance"];
    
    set1.colors = [[NSArray alloc] initWithObjects:
                   [UIColor magentaColor],nil];
    
   
    
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    [dataSets addObject:set1];
    
    
    BarChartData *data = [[BarChartData alloc] initWithXVals:xVals dataSets:dataSets];
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:6]];
   
    self.cell1.MReportChart.data = data;
    
}


#pragma mark - Chart 4 Methods

-(void)setDataCount4:(int)count range:(double)range
{
    NSMutableArray *xVals = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++)
    {
        
        months = self.MCPDateCount;
        [xVals addObject:months[i % 12]];
        //[xVals addObject:self.topupDate[i%12]];
    }
    
    NSMutableArray *yVals1 = [[NSMutableArray alloc] init];
    NSMutableArray *yVals2 = [[NSMutableArray alloc] init];
    NSMutableArray *yVals3 = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++)
    {
        // double mult = (range + 1);
        
        double val1 = [[self.MTopupCount objectAtIndex:i] doubleValue];
        double val2 = [[self.MPayoutCount objectAtIndex:i] doubleValue];
        double val3 = [[self.MBalanceCount objectAtIndex:i] doubleValue];
                if (val1<0 ) {
                    val1 = -(val1);
                    
                }
        if (val2<0 ) {
            val3 = -(val2);
            
        }if (val3<0 ) {
            val3 = -(val3);
            
        }
        [yVals1 addObject:[[BarChartDataEntry alloc] initWithValue:val1 xIndex:i]];
        
        [yVals2 addObject:[[BarChartDataEntry alloc] initWithValue:val2 xIndex:i]];
        
        [yVals3 addObject:[[BarChartDataEntry alloc] initWithValue:val3 xIndex:i]];
    }
    
    BarChartDataSet *set1 = [[BarChartDataSet alloc] initWithYVals:yVals1 label:@"Topup"];
    set1.barSpace = 0.15;
    set1.colors = [[NSArray alloc] initWithObjects:
                   [UIColor greenColor],nil];
    
    BarChartDataSet *set2 = [[BarChartDataSet alloc] initWithYVals:yVals2 label:@"Payout"];
    set2.barSpace = 0.15;
    set2.colors = [[NSArray alloc] initWithObjects:
                   [UIColor redColor],nil];
    
    BarChartDataSet *set3 = [[BarChartDataSet alloc] initWithYVals:yVals3 label:@"Balance"];
    set3.barSpace = 0.15;
    set3.colors = [[NSArray alloc] initWithObjects:
                   [UIColor magentaColor],nil];
    
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    [dataSets addObject:set1];
    [dataSets addObject:set2];
    [dataSets addObject:set3];
    
    BarChartData *data = [[BarChartData alloc] initWithXVals:xVals dataSets:dataSets];
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:6]];
    
    self.cell1.MCPChart.data = data;
    
}


- (IBAction)slidersValueChanged:(id)sender
{
    [self updateChartData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Chart 5 Methods

- (void)setDataCount5:(int)count range:(double)range
{
    //double mult = range;
    
    NSMutableArray *yVals1 = [[NSMutableArray alloc] init];
    
    // IMPORTANT: In a PieChart, no values (Entry) should have the same xIndex (even if from different DataSets), since no values can be drawn above each other.
    for (int i = 0; i < count; i++)
    {
        //int percent = (int)[self.PTotalCount[i] integerValue] % self-> pSum;
        
        [yVals1 addObject:[[BarChartDataEntry alloc] initWithValue:[[self.PPercent objectAtIndex:i] integerValue] xIndex:i]];
    }
    
    NSMutableArray *xVals = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++)
    {
        [xVals addObject:self.PName[i % self.PName.count]];
    }
    
    PieChartDataSet *dataSet = [[PieChartDataSet alloc] initWithYVals:yVals1 label:@"Election Results"];
    dataSet.sliceSpace = 2.0;
    
    // add a lot of colors
    
    NSMutableArray *colors = [[NSMutableArray alloc] init];
    [colors addObjectsFromArray:ChartColorTemplates.vordiplom];
    [colors addObjectsFromArray:ChartColorTemplates.joyful];
    [colors addObjectsFromArray:ChartColorTemplates.colorful];
    [colors addObjectsFromArray:ChartColorTemplates.liberty];
    [colors addObjectsFromArray:ChartColorTemplates.pastel];
    [colors addObject:[UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f]];
    
    dataSet.colors = colors;
    
    dataSet.valueLinePart1OffsetPercentage = 0.8;
    dataSet.valueLinePart1Length = 0.3;
    dataSet.valueLinePart2Length = 0.4;
    //dataSet.xValuePosition = PieChartValuePositionOutsideSlice;
    dataSet.yValuePosition = PieChartValuePositionOutsideSlice;
    
    PieChartData *data = [[PieChartData alloc] initWithXVals:xVals dataSet:dataSet];
    
    NSNumberFormatter *pFormatter = [[NSNumberFormatter alloc] init];
    pFormatter.numberStyle = NSNumberFormatterPercentStyle;
    pFormatter.maximumFractionDigits = 1;
    pFormatter.multiplier = @1.f;
    pFormatter.percentSymbol = @" %";
    [data setValueFormatter:pFormatter];
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:11.f]];
    [data setValueTextColor:UIColor.blackColor];
    
    self.cell1.PieChart1.data = data;
    [self.cell1.PieChart1 highlightValues:nil];
}

- (void)optionTapped:(NSString *)key
{
    if ([key isEqualToString:@"toggleXValues"])
    {
        _PieChart1.drawSliceTextEnabled = !_PieChart1.isDrawSliceTextEnabled;
        
        [_PieChart1 setNeedsDisplay];
        return;
    }
    
    if ([key isEqualToString:@"togglePercent"])
    {
        _PieChart1.usePercentValuesEnabled = !_PieChart1.isUsePercentValuesEnabled;
        
        [_PieChart1 setNeedsDisplay];
        
        return;
    }
    
    if ([key isEqualToString:@"toggleHole"])
    {
        _PieChart1.drawHoleEnabled = !_PieChart1.isDrawHoleEnabled;
        
        [_PieChart1 setNeedsDisplay];
        return;
    }
    
    if ([key isEqualToString:@"drawCenter"])
    {
        _PieChart1.drawCenterTextEnabled = !_PieChart1.isDrawCenterTextEnabled;
        
        [_PieChart1 setNeedsDisplay];
        return;
    }
    
    if ([key isEqualToString:@"animateX"])
    {
        [_PieChart1 animateWithXAxisDuration:1.4];
        return;
    }
    
    if ([key isEqualToString:@"animateY"])
    {
        [_PieChart1 animateWithYAxisDuration:1.4];
        return;
    }
    
    if ([key isEqualToString:@"animateXY"])
    {
        [_PieChart1 animateWithXAxisDuration:1.4 yAxisDuration:1.4];
        return;
    }
    
    if ([key isEqualToString:@"spin"])
    {
        [_PieChart1 spinWithDuration:2.0 fromAngle:_PieChart1.rotationAngle toAngle:_PieChart1.rotationAngle + 360.f];
        return;
    }
    
    [super handleOption:key forChartView:_PieChart1];
}

#pragma mark - Actions

#pragma mark - ChartViewDelegate

//- (void)chartValueSelected:(ChartViewBase * __nonnull)chartView entry:(ChartDataEntry * __nonnull)entry dataSetIndex:(NSInteger)dataSetIndex highlight:(ChartHighlight * __nonnull)highlight
//{
//    NSLog(@"chartValueSelected");
//}
//
//- (void)chartValueNothingSelected:(ChartViewBase * __nonnull)chartView
//{
//    NSLog(@"chartValueNothingSelected");
//}


- (IBAction)menu:(id)sender {
    // Dismiss keyboard (optional)
    //
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    //
    [self.frostedViewController presentMenuViewController];
    

}

#pragma mark - Drop Down Table

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    switch (section) {
        case 0:
            return [(SectionItem *)[sections objectAtIndex:section] isFolding]?0:1;
            break;
        case 1:
            return [(SectionItem *)[sections objectAtIndex:section] isFolding]?0: [result[@"MonthlyTopupchart"] count]+1;
        case 2:
            return [(SectionItem *)[sections objectAtIndex:section] isFolding]?0:1;
            break;
        case 3:
            return [(SectionItem *)[sections objectAtIndex:section] isFolding]?0: [result[@"NegativeBalancechart"] count]+1;
        case 4:
            return [(SectionItem *)[sections objectAtIndex:section] isFolding]?0:1;
            break;
        case 5:
            return [(SectionItem *)[sections objectAtIndex:section] isFolding]?0: [result[@"MonthlyReportchart"] count]+1;
        case 6:
            return [(SectionItem *)[sections objectAtIndex:section] isFolding]?0:1;
            break;
        case 7:
            return [(SectionItem *)[sections objectAtIndex:section] isFolding]?0: [result[@"MCatchPerformancechart"] count]+1;
        case 8:
            return [(SectionItem *)[sections objectAtIndex:section] isFolding]?0:1;
            break;
        case 9:
            return [(SectionItem *)[sections objectAtIndex:section] isFolding]?0: [result[@"PublisherPerformancechart"] count]+1;
        
    }
    return 0;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if([[tableView indexPathForSelectedRow]isEqual:indexPath]) return 80;
    //return 300;
    
    if (!(indexPath.section % 2)) {
        return 300;
    }
    else{
        return 20;
        
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIControl *control=[[UIControl alloc]init];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 20)];
    
    switch (section) {
        case 0:
            [label setText:@"Click Here"];
            [label setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:10.f]];
            break;
        case 1:
            [label setText:@"Click here for details"];
             [label setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:10.f]];
            break;
        case 2:
            [label setText:@"Click Here"];
            [label setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:10.f]];
            break;
        case 3:
            [label setText:@"Click here for details"];
            [label setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:10.f]];
            break;
        case 4:
            [label setText:@"Click Here"];
            [label setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:10.f]];
            break;
        case 5:
            [label setText:@"Click here for details"];
            [label setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:10.f]];
            break;
        case 6:
            [label setText:@"Click Here"];
            [label setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:10.f]];
            break;
        case 7:
            [label setText:@"Click here for details"];
            [label setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:10.f]];
            
            break;
        case 8:
            [label setText:@"Click Here"];
            [label setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:10.f]];
            break;
        case 9:
            [label setText:@"Click here for details"];
            [label setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:10.f]];
            break;
    }
    if (section % 2) {
    [control addSubview:label];
    [control setTag:section];
    control.backgroundColor = [UIColor orangeColor];
    UIView *separatorLine=[[UIView alloc]init];
    [control addSubview:separatorLine];
    [separatorLine setBackgroundColor:[UIColor lightGrayColor]];
    [separatorLine setTranslatesAutoresizingMaskIntoConstraints:NO];
    [control addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[separatorLine]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(separatorLine)]];
    [control addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[separatorLine(==0.28)]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(separatorLine)]];
    [separatorLine setUserInteractionEnabled:NO];
    
    [control addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return control;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    if(indexPath.section==0){
        static NSString *MyIdentifier = @"Cell1";
        
        self.cell1 = [self.mainTable dequeueReusableCellWithIdentifier:MyIdentifier];
    
        
        
        //********BarChart 1*****************
        
        
        [self setupBarLineChartView:self.cell1.BarChart1];
        
        self.cell1.BarChart1.delegate = self;
        
        self.cell1.BarChart1.drawBarShadowEnabled = NO;
        self.cell1.BarChart1.drawValueAboveBarEnabled = YES;
        
        self.cell1.BarChart1.maxVisibleValueCount = 60;
        
        ChartXAxis *xAxist1 = self.cell1.BarChart1.xAxis;
        
        xAxist1.labelPosition = XAxisLabelPositionBottom;
        xAxist1.labelFont = [UIFont systemFontOfSize:6.f];
        xAxist1.drawAxisLineEnabled = YES;
        xAxist1.drawGridLinesEnabled = YES;
        xAxist1.gridLineWidth = .3;
        
        ChartYAxis *leftAxist1 = self.cell1.BarChart1.leftAxis;
        leftAxist1.labelFont = [UIFont systemFontOfSize:5.f];
        leftAxist1.drawAxisLineEnabled = YES;
        leftAxist1.drawGridLinesEnabled = YES;
        leftAxist1.gridLineWidth = .3;
        leftAxist1.axisMinValue = 0;
        
        // this replaces startAtZero = YES
        
        ChartYAxis *rightAxist1 = self.cell1.BarChart1.rightAxis;
        rightAxist1.enabled = YES;
        rightAxist1.labelFont = [UIFont systemFontOfSize:0.f];
        rightAxist1.drawAxisLineEnabled = NO;
        rightAxist1.drawGridLinesEnabled = NO;
        rightAxist1.axisMinValue = 0;
        
        // this replaces startAtZero = YES
        
        self.cell1.BarChart1.legend.position = ChartLegendPositionBelowChartLeft;
        self.cell1.BarChart1.legend.form = ChartLegendFormSquare;
        self.cell1.BarChart1.legend.formSize = 8.0;
        
        
        self.cell1.BarChart1.legend.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.f];
        self.cell1.BarChart1.legend.xEntrySpace = 0.0;
        
        _sliderX.value = 11.0;
        _sliderY.value = 50.0;
        
        //Chart 1 ******* Calculations
        
        NSInteger count = [result[@"MonthlyTopupchart"] count];
        
        self->limit = count;
        
        NSInteger i=0;
        
        self.topupCount = [[NSMutableArray alloc] init];
        self.topupDate = [[NSMutableArray alloc] init];
        
        for (i=0; i<count; i++) {
            
            self->topup = result[@"MonthlyTopupchart"][i][@"txAmount"];
            
            
            [self.topupCount addObject:self->topup];
            
            self->date = result[@"MonthlyTopupchart"][i][@"TXdatetime"];
            
            [self.topupDate addObject:self->date];
            
        }
        [self setDataCount:(int)self->limit range:total];
        self.cell1.BarChart1.hidden= NO;
        [self.cell1.BarChart1 animateWithYAxisDuration:2.5];
        
    }
    
    if(indexPath.section==1){
        // Create second cell
        
        static NSString *MyIdentifier2 = @"Cell2";
        
        self.cell1 = [self.mainTable dequeueReusableCellWithIdentifier:MyIdentifier2];
        if (indexPath.row==0) {
            self.cell1.label1.text = @"Amount";
            [self.cell1.label1 setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:10.f]];
            self.cell1.label2.text = @"Date";
            [self.cell1.label2 setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:10.f]];
            self.cell1.backgroundColor = [UIColor grayColor];
        }
        else{
        
        NSInteger i = 0;
        
        for (i=0; i< indexPath.row ;i++) {
           
                self.cell1.label1.text = [[self.topupCount objectAtIndex:i] stringValue];
                
                [self.cell1.label1 setFont:[UIFont fontWithName:@"HelveticaNeue-light" size:10.f]];
                self.cell1.label2.text = self.topupDate[i%12];
                [self.cell1.label2 setFont:[UIFont fontWithName:@"HelveticaNeue-light" size:10.f]];
                self.cell1.backgroundColor = [UIColor lightGrayColor];
            
        }
        }
    
}
    if(indexPath.section==2){
        // Create second cell
        
        static NSString *MyIdentifier3 = @"Cell3";
        
        self.cell1 = [self.mainTable dequeueReusableCellWithIdentifier:MyIdentifier3];
        
        //***************Chart 2 *****************//
        
        [self setupBarLineChartView:self.cell1.CurrentBalBarChart];
        
        self.cell1.CurrentBalBarChart.delegate = self;
        
        self.cell1.CurrentBalBarChart.drawBarShadowEnabled = NO;
        self.cell1.CurrentBalBarChart.drawValueAboveBarEnabled = YES;
        
        self.cell1.CurrentBalBarChart.maxVisibleValueCount = 60;
        
        ChartXAxis *xAxis2 = self.cell1.CurrentBalBarChart.xAxis;
        
        xAxis2.labelPosition = XAxisLabelPositionBottom;
        xAxis2.labelFont = [UIFont systemFontOfSize:6.f];
        xAxis2.drawAxisLineEnabled = YES;
        xAxis2.drawGridLinesEnabled = YES;
        xAxis2.gridLineWidth = .3;
        
        ChartYAxis *leftAxis2 = self.cell1.CurrentBalBarChart.leftAxis;
        leftAxis2.labelFont = [UIFont systemFontOfSize:5.f];
        leftAxis2.drawAxisLineEnabled = YES;
        leftAxis2.drawGridLinesEnabled = YES;
        leftAxis2.gridLineWidth = .3;
        leftAxis2.axisMinValue = 0;
        
        // this replaces startAtZero = YES
        
        ChartYAxis *rightAxis2 = self.cell1.CurrentBalBarChart.rightAxis;
        rightAxis2.enabled = YES;
        rightAxis2.labelFont = [UIFont systemFontOfSize:0.f];
        rightAxis2.drawAxisLineEnabled = NO;
        rightAxis2.drawGridLinesEnabled = NO;
        rightAxis2.axisMinValue = 0;
        
        // this replaces startAtZero = YES
        
        self.cell1.CurrentBalBarChart.legend.position = ChartLegendPositionBelowChartLeft;
        self.cell1.CurrentBalBarChart.legend.form = ChartLegendFormSquare;
        self.cell1.CurrentBalBarChart.legend.formSize = 8.0;
        
        
        self.cell1.CurrentBalBarChart.legend.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.f];
        self.cell1.CurrentBalBarChart.legend.xEntrySpace = 0.0;
        
        _sliderX.value = 11.0;
        _sliderY.value = 50.0;
        
        //Chart 2 ******* Calculations
       
        self.AdvCount = [[NSMutableArray alloc] init];
        self.curBalCount = [[NSMutableArray alloc] init];
        
        NSInteger count2 = [result[@"NegativeBalancechart"] count];
        
        self->limit2 = count2;
        NSInteger i=0;
        for (i=0; i<count2; i++) {
            
            self->AdvName = result[@"NegativeBalancechart"][i][@"advertisername"];
            
            [self.AdvCount addObject:self->AdvName];
            
            self->curBal = result[@"NegativeBalancechart"][i][@"currentbal"];
            
            [self.curBalCount addObject:self->curBal];
        }
        
        [self setDataCount2:(int)self->limit2 range:total];
        self.cell1.CurrentBalBarChart.hidden= NO;
        [self.cell1.CurrentBalBarChart animateWithYAxisDuration:2.5];
       
    }
    if(indexPath.section==3){
        // Create second cell
        
        static NSString *MyIdentifier4 = @"Cell4";
        
        self.cell1 = [self.mainTable dequeueReusableCellWithIdentifier:MyIdentifier4];
        
        if (indexPath.row==0) {
            self.cell1.advName.text = @"Advertiser Name";
            [self.cell1.advName setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:10.f]];
            self.cell1.advBalance.text = @"Balance";
            [self.cell1.advBalance setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:10.f]];
            self.cell1.backgroundColor = [UIColor grayColor];
        }
        else{
            
            NSInteger i = 0;
            
            for (i=0; i< indexPath.row ;i++) {
                
                self.cell1.advName.text = self.AdvCount[i%12];
                
                [self.cell1.advName setFont:[UIFont fontWithName:@"HelveticaNeue-light" size:10.f]];
                self.cell1.advBalance.text = [[self.curBalCount objectAtIndex:i] stringValue] ;
                [self.cell1.advBalance setFont:[UIFont fontWithName:@"HelveticaNeue-light" size:10.f]];
                self.cell1.backgroundColor = [UIColor lightGrayColor];
                
            }
        }
    }
    if(indexPath.section==4){
        // Create second cell
        
        static NSString *MyIdentifier5 = @"Cell5";
        
        self.cell1 = [self.mainTable dequeueReusableCellWithIdentifier:MyIdentifier5];
        
        //***************Chart 3 *****************//
        
        [self setupBarLineChartView:self.cell1.MReportChart];
        
        self.cell1.MReportChart.delegate = self;
        
        self.cell1.MReportChart.drawBarShadowEnabled = NO;
        self.cell1.MReportChart.drawValueAboveBarEnabled = YES;
        
        self.cell1.MReportChart.maxVisibleValueCount = 60;
        
        ChartXAxis *xAxis3 = self.cell1.MReportChart.xAxis;
        
        xAxis3.labelPosition = XAxisLabelPositionBottom;
        xAxis3.labelFont = [UIFont systemFontOfSize:6.f];
        xAxis3.drawAxisLineEnabled = YES;
        xAxis3.drawGridLinesEnabled = YES;
        xAxis3.gridLineWidth = .3;
        
        ChartYAxis *leftAxis3 = self.cell1.MReportChart.leftAxis;
        leftAxis3.labelFont = [UIFont systemFontOfSize:5.f];
        leftAxis3.drawAxisLineEnabled = YES;
        leftAxis3.drawGridLinesEnabled = YES;
        leftAxis3.gridLineWidth = .3;
        leftAxis3.axisMinValue = 0;
        
        // this replaces startAtZero = YES
        
        ChartYAxis *rightAxis3 = self.cell1.MReportChart.rightAxis;
        rightAxis3.enabled = YES;
        rightAxis3.labelFont = [UIFont systemFontOfSize:0.f];
        rightAxis3.drawAxisLineEnabled = NO;
        rightAxis3.drawGridLinesEnabled = NO;
        rightAxis3.axisMinValue = 0;
        
        // this replaces startAtZero = YES
        
        self.cell1.MReportChart.legend.position = ChartLegendPositionBelowChartLeft;
        self.cell1.MReportChart.legend.form = ChartLegendFormSquare;
        self.cell1.MReportChart.legend.formSize = 8.0;
        
        
        self.cell1.MReportChart.legend.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.f];
        self.cell1.MReportChart.legend.xEntrySpace = 0.0;
        
        _sliderX.value = 11.0;
        _sliderY.value = 50.0;
        
        //Chart 3 ******* Calculations
        
        NSInteger i=0;
        
        self.MTotalCount = [[NSMutableArray alloc] init];
        self.MDateCount = [[NSMutableArray alloc] init];
        
        NSInteger count3 = [result[@"MonthlyReportchart"] count];
        
        self->limit3 = count3;
        //NSLog(@"%ld", limit3);
        for (i=0; i<count3; i++) {
            
            self->mTotal = result[@"MonthlyReportchart"][i][@"Total"];
            
            [self.MTotalCount addObject:self->mTotal];
            
            self->mDate = result[@"MonthlyReportchart"][i][@"monthlydate"];
            
            [self.MDateCount addObject:self->mDate];
        }
        [self setDataCount3:(int)self->limit3 range:total];
        self.cell1.MReportChart.hidden= NO;
        [self.cell1.MReportChart animateWithYAxisDuration:2.5];
        

    }
    if(indexPath.section==5){
        // Create second cell
        
        static NSString *MyIdentifier6 = @"Cell6";
        
        self.cell1 = [self.mainTable dequeueReusableCellWithIdentifier:MyIdentifier6];
        if (indexPath.row==0) {
            self.cell1.total.text = @"Total";
            [self.cell1.total setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:10.f]];
            self.cell1.date.text = @"Date";
            [self.cell1.date setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:10.f]];
            self.cell1.backgroundColor = [UIColor grayColor];
        }
        else{
            
            NSInteger i = 0;
            
            for (i=0; i< indexPath.row ;i++) {
                
                self.cell1.total.text = [[self.MTotalCount objectAtIndex:i] stringValue];
                
                [self.cell1.total setFont:[UIFont fontWithName:@"HelveticaNeue-light" size:10.f]];
                self.cell1.date.text = self.MDateCount[i%12];
                [self.cell1.date setFont:[UIFont fontWithName:@"HelveticaNeue-light" size:10.f]];
                self.cell1.backgroundColor = [UIColor lightGrayColor];
                
            }
        }
    }
    if(indexPath.section==6){
        // Create second cell
        
        static NSString *MyIdentifier7 = @"Cell7";
        
        self.cell1 = [self.mainTable dequeueReusableCellWithIdentifier:MyIdentifier7];
        
        
        //***************Chart 4 *****************//
        
        [self setupBarLineChartView:self.cell1.MCPChart];
        
        self.cell1.MCPChart.delegate = self;
        
        self.cell1.MCPChart.drawBarShadowEnabled = NO;
        self.cell1.MCPChart.drawValueAboveBarEnabled = YES;
        
        self.cell1.MCPChart.maxVisibleValueCount = 60;
        
        ChartXAxis *xAxis4 = self.cell1.MCPChart.xAxis;
        
        xAxis4.labelPosition = XAxisLabelPositionBottom;
        xAxis4.labelFont = [UIFont systemFontOfSize:6.f];
        xAxis4.drawAxisLineEnabled = YES;
        xAxis4.drawGridLinesEnabled = YES;
        xAxis4.gridLineWidth = .3;
        
        ChartYAxis *leftAxis4 = self.cell1.MCPChart.leftAxis;
        leftAxis4.labelFont = [UIFont systemFontOfSize:5.f];
        leftAxis4.drawAxisLineEnabled = YES;
        leftAxis4.drawGridLinesEnabled = YES;
        leftAxis4.gridLineWidth = .3;
        leftAxis4.axisMinValue = 0;
        
        // this replaces startAtZero = YES
        
        ChartYAxis *rightAxis4 = self.cell1.MCPChart.rightAxis;
        rightAxis4.enabled = YES;
        rightAxis4.labelFont = [UIFont systemFontOfSize:0.f];
        rightAxis4.drawAxisLineEnabled = NO;
        rightAxis4.drawGridLinesEnabled = NO;
        rightAxis4.axisMinValue = 0;
        
        // this replaces startAtZero = YES
        
        self.cell1.MCPChart.legend.position = ChartLegendPositionBelowChartLeft;
        self.cell1.MCPChart.legend.form = ChartLegendFormSquare;
        self.cell1.MCPChart.legend.formSize = 8.0;
        
        
        self.cell1.MCPChart.legend.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.f];
        self.cell1.MCPChart.legend.xEntrySpace = 4.0;
        self.cell1.MCPChart.legend.stackSpace = 10.0;
        
        _sliderX.value = 11.0;
        _sliderY.value = 50.0;
        
        //Chart 4 ******* Calculations
        
        NSInteger i=0;
        
        self.MTopupCount = [[NSMutableArray alloc] init];
        self.MPayoutCount = [[NSMutableArray alloc] init];
        self.MBalanceCount = [[NSMutableArray alloc] init];
        self.MCPDateCount = [[NSMutableArray alloc] init];
        
        NSInteger count4 = [result[@"MCatchPerformancechart"] count];
        
        self->limit4 = count4;
        //NSLog(@"%ld", limit3);
        for (i=0; i<count4; i++) {
            
            self->mTopup = result[@"MCatchPerformancechart"][i][@"monthlytopup"];
            
            [self.MTopupCount addObject:self->mTopup];
            
            self->mPayout = result[@"MCatchPerformancechart"][i][@"monthlypayout"];
            
            [self.MPayoutCount addObject:self->mPayout];
            
            self->mBalance = result[@"MCatchPerformancechart"][i][@"balance"];
            
            [self.MBalanceCount addObject:self->mBalance];
            
            self->mcpDate = result[@"MCatchPerformancechart"][i][@"monthlydate"];
            
            [self.MCPDateCount addObject:self->mcpDate];
        }
        
        [self setDataCount4:(int)self->limit4 range:total];
        self.cell1.MCPChart.hidden= NO;
        [self.cell1.MCPChart animateWithYAxisDuration:2.5];
        
    }
    if(indexPath.section==7){
        // Create second cell
        
        static NSString *MyIdentifier8 = @"Cell8";
        
        self.cell1 = [self.mainTable dequeueReusableCellWithIdentifier:MyIdentifier8];
        
        if (indexPath.row==0) {
            
//            [[self.MTopupCount objectAtIndex:i] doubleValue];
//            double val2 = [[self.MPayoutCount objectAtIndex:i] doubleValue];
//            double val3 = [[self.MBalanceCount objectAtIndex:i] doubleValue];
            self.cell1.monthlyTopup.text = @"Monthly Topup";
            [self.cell1.monthlyTopup setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:10.f]];
            self.cell1.monthlyPayout.text = @"Monthly Payout";
            [self.cell1.monthlyPayout setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:10.f]];
            self.cell1.balance.text = @"Balance";
            [self.cell1.balance setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:10.f]];
            
            self.cell1.monthlyDate.text = @"Monthly Date";
            [self.cell1.monthlyDate setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:10.f]];
            
            self.cell1.backgroundColor = [UIColor grayColor];
        }
        else{
            
            NSInteger i = 0;
            
            for (i=0; i< indexPath.row ;i++) {
                
                self.cell1.monthlyTopup.text = [[self.MTopupCount objectAtIndex:i] stringValue];
                [self.cell1.monthlyTopup setFont:[UIFont fontWithName:@"HelveticaNeue-light" size:10.f]];
                self.cell1.monthlyPayout.text = [[self.MPayoutCount objectAtIndex:i] stringValue];
                [self.cell1.monthlyPayout setFont:[UIFont fontWithName:@"HelveticaNeue-light" size:10.f]];
                self.cell1.balance.text =[[self.MBalanceCount objectAtIndex:i] stringValue];
                [self.cell1.balance setFont:[UIFont fontWithName:@"HelveticaNeue-light" size:10.f]];
                
                self.cell1.monthlyDate.text = self.MCPDateCount[i%12];
                [self.cell1.monthlyDate setFont:[UIFont fontWithName:@"HelveticaNeue-light" size:10.f]];
                

                self.cell1.backgroundColor = [UIColor lightGrayColor];
                
            }
        }
    }
    if(indexPath.section==8){
        // Create  cell
        
        static NSString *MyIdentifier9 = @"Cell9";
        
        self.cell1 = [self.mainTable dequeueReusableCellWithIdentifier:MyIdentifier9];
        
        //***************Chart 5 *****************//
        
        [self setupPieChartView:self.cell1.PieChart1];
        
        self.cell1.PieChart1.legend.enabled = NO;
        self.cell1.PieChart1.delegate = self;
        
        [self.cell1.PieChart1 setExtraOffsetsWithLeft:0.f top:0.f right:0.f bottom:0.f];
        
        _sliderX.value = 3.0;
        _sliderY.value = 100.0;
        
        //[self slidersValueChanged:nil];
        
        [self.cell1.PieChart1 animateWithYAxisDuration:1.4 easingOption:ChartEasingOptionEaseOutBack];
    
        //Chart 5 ******* Calculations
        
        NSInteger i=0;
        
        self.PTotalCount = [[NSMutableArray alloc] init];
        self.PLegendCount = [[NSMutableArray alloc] init];
        self.PChannelTypeCount = [[NSMutableArray alloc] init];
        self.PPercent = [[NSMutableArray alloc] init];
        self.PPercent2 = [[NSMutableArray alloc] init];
        self.PName = [[NSMutableArray alloc]init];
        
        NSInteger count5 = [result[@"PublisherPerformancechart"] count];
        
        self->limit5 = count5;
        
        pSum = 0;
        pSum2 = 0;
        
        for (i=0; i<count5; i++) {
            
            self->plegendString = result[@"PublisherPerformancechart"][i][@"publishername"];
            
            [self.PLegendCount addObject:self->plegendString];
            
            self->ptotal = result[@"PublisherPerformancechart"][i][@"Total"];
            
            [self.PTotalCount addObject:self->ptotal];
            
            self->pSum = self->pSum + [self.PTotalCount[i] integerValue];
            
        }
        
        for (i=0; i<count5; i++) {
            
            double percent = (((100)*([self.PTotalCount[i] doubleValue])) / (self-> pSum));
            
            // NSLog(@" persent # %f", percent);
            
            if (percent > 2) {
                
                
                [self.PPercent addObject:[self.PTotalCount objectAtIndex:i]];
                [self.PName addObject:[self.PLegendCount objectAtIndex:i]];
            }
            
            else {
                //[self.PPercent addObject:@0];
                // [self.PPercent2 addObject:[self.PTotalCount objectAtIndex:i]];
                
                self->pSum2 = self->pSum2 + [self.PTotalCount[i] integerValue];
            }
            
            
        }
        percent2 = (((100)*(self->pSum2)) / (self-> pSum));
        
        [self.PName addObject:@"Others"];
        
        [self.PPercent addObject:[NSNumber numberWithDouble:pSum2]];
        
        
        [self setDataCount5:(int)[self.PName count] range:15];
        self.cell1.PieChart1.hidden= NO;
        [self.cell1.PieChart1 animateWithYAxisDuration:2.5];
    }
    if(indexPath.section==9){
        // Create  cell
        
        static NSString *MyIdentifier10 = @"Cell10";
        
        self.cell1 = [self.mainTable dequeueReusableCellWithIdentifier:MyIdentifier10];
        if (indexPath.row==0) {
            self.cell1.publisher.text = @"Publisher";
            [self.cell1.publisher setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:10.f]];
            self.cell1.channelType.text = @"Channel Type";
            [self.cell1.channelType setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:10.f]];
            self.cell1.total2.text = @"Total";
            [self.cell1.total2 setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:10.f]];
            self.cell1.backgroundColor = [UIColor grayColor];
        }
        else{
            
            NSInteger i = 0;
            
            for (i=0; i< indexPath.row ;i++) {
                
                self.cell1.publisher.text =result[@"PublisherPerformancechart"][i][@"publishername"];
                [self.cell1.publisher setFont:[UIFont fontWithName:@"HelveticaNeue-light" size:10.f]];
                self.cell1.channelType.text = result[@"PublisherPerformancechart"][i][@"channeltype"];
                [self.cell1.channelType setFont:[UIFont fontWithName:@"HelveticaNeue-light" size:10.f]];
                self.cell1.total2.text = [result[@"PublisherPerformancechart"][i][@"Total"] stringValue];
                [self.cell1.total2 setFont:[UIFont fontWithName:@"HelveticaNeue-light" size:10.f]];
                self.cell1.backgroundColor = [UIColor lightGrayColor];
                
            }
        }
    }
        else{
//        UITableViewCell *cell=[[UITableViewCell alloc]init];
//        [[cell textLabel]setText:@"Hello"];
    }

    //return cell;
    
    
    return self.cell1;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   if (indexPath.section >0) {
       [tableView beginUpdates];
       [tableView endUpdates];
   }
}

-(void)click:(id)sender{
    NSInteger currentSection=[sender tag];
    NSIndexSet *set=[NSIndexSet indexSetWithIndex:currentSection];
    SectionItem *item=[sections objectAtIndex:currentSection];
    [item setIsFolding:!item.isFolding];
    [self.DropDownTable reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
    [self.mainTable reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
}

@end
