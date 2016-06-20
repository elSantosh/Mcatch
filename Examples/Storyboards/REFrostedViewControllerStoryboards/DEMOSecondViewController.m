//
//  DEMOSecondViewController.m
//  REFrostedViewControllerStoryboards
//
//  Created by Roman Efimov on 10/9/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "DEMOSecondViewController.h"
#import "CampaignInfoCellTableViewCell.h"
#import "MCatch-Bridging-Header.h"

#import "MCatch-Swift.h"

#import "SVProgressHUD.h"

#import "Search.h"


@interface DEMOSecondViewController () <UITableViewDataSource,UITableViewDelegate, ChartViewDelegate>
{
    NSInteger total;
    NSInteger today;
}
@property (strong, nonatomic) NSMutableArray *mutableNames;

@property (nonatomic, strong) IBOutlet UISlider *sliderX;
@property (nonatomic, strong) IBOutlet UISlider *sliderY;

@property (nonatomic, strong) CampaignInfoCellTableViewCell *cell;



@end
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"

@implementation DEMOSecondViewController
{
    NSArray *names;
    NSArray *searchResults;
}

@synthesize result;



-(void) viewDidLoad{
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];
    [SVProgressHUD show];
    
    [self.searchDisplayController.searchResultsTableView setRowHeight:self.CampaignInfoTable.rowHeight];
    
    //dispatch_async(dispatch_get_main_queue(), ^{
    NSString *accID = [[NSUserDefaults standardUserDefaults] objectForKey:@"AccID"];
  
        NSString *urlString = [NSString stringWithFormat:@"http://mobilemcatch.mcommsg.com//Campaigninfo.aspx?AdvertiserID=%@",accID];
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
                 NSMutableArray *jsonData = [NSJSONSerialization
                                             JSONObjectWithData:data
                                             options:NSJSONReadingMutableContainers
                                             error:&error];
                 
                 dispatch_async(dispatch_get_main_queue(), ^{
                 self.result = jsonData;
            
                 [self.CampaignInfoTable reloadData];
                     
                     
                 });
             }
         }];
        
   // });
   
    
}
- (IBAction)showMenu
{
    // Dismiss keyboard (optional)
    //
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    //
    [self.frostedViewController presentMenuViewController];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return 280;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [searchResults count];
        
    } else {
        return self.result.count;
    }

    
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    // The header for the section is the region name -- get this from the region at the section index.
//   // Region *region = [regions objectAtIndex:section];
//    return NULL;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"campaigninfocell";
   
    self.cell = [self.CampaignInfoTable dequeueReusableCellWithIdentifier:MyIdentifier];
    if (self.cell == nil) {
        self.cell = [[CampaignInfoCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    }
    
    Search *searching = nil;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        searching   = [searchResults objectAtIndex:indexPath.row];
        NSInteger i=0;
        for (i=0; i<searchResults.count; i++) {
           
            total = [searching.record6 intValue];
            
            if ([searching.record7 isEqual:[NSNull null]])
            {
                today = 0;
            }
            else{
                today = [searching.record7 integerValue];
            }
            

            self.cell.name.text=searching.record1;
            self.cell.status.text=searching.record2;
            self.cell.country.text=searching.record3;
            self.cell.bidPrice.text=searching.record4;
            self.cell.CPA.text=searching.record5;
            
            [self setupBarLineChartView:self.cell.chartView];
            
            self.cell.chartView.delegate = self;
            
            self.cell.chartView.drawBarShadowEnabled = NO;
            self.cell.chartView.drawValueAboveBarEnabled = YES;
            
            self.cell.chartView.maxVisibleValueCount = 60;
            
            ChartXAxis *xAxis = self.cell.chartView.xAxis;
            
            xAxis.labelPosition = XAxisLabelPositionBottom;
            xAxis.labelFont = [UIFont systemFontOfSize:0.f];
            xAxis.drawAxisLineEnabled = YES;
            xAxis.drawGridLinesEnabled = YES;
            xAxis.gridLineWidth = .3;
            
            ChartYAxis *leftAxis = self.cell.chartView.leftAxis;
            leftAxis.labelFont = [UIFont systemFontOfSize:0.f];
            leftAxis.drawAxisLineEnabled = YES;
            leftAxis.drawGridLinesEnabled = YES;
            leftAxis.gridLineWidth = .3;
            leftAxis.axisMinValue = 0;
            
            // this replaces startAtZero = YES
            
            ChartYAxis *rightAxis = self.cell.chartView.rightAxis;
            rightAxis.enabled = YES;
            rightAxis.labelFont = [UIFont systemFontOfSize:0.f];
            rightAxis.drawAxisLineEnabled = NO;
            rightAxis.drawGridLinesEnabled = NO;
            rightAxis.axisMinValue = 0;
            
            // this replaces startAtZero = YES
            
            self.cell.chartView.legend.position = ChartLegendPositionBelowChartLeft;
            self.cell.chartView.legend.form = ChartLegendFormSquare;
            self.cell.chartView.legend.formSize = 8.0;
            
            
            self.cell.chartView.legend.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.f];
            self.cell.chartView.legend.xEntrySpace = 4.0;
            
            //_sliderX.value = 11.0;
            //_sliderY.value = 50.0;
            
            [self slidersValueChanged:nil];
            
            // NSLog(@"%ld",total);
            [self setDataCount:(_sliderX.value + 1) range:total];
            
            [self.cell.chartView animateWithYAxisDuration:2.5];
            

        }
    }
    else {
        searching = [names objectAtIndex:indexPath.row];
        
        names = [[NSArray alloc]init];
        
        self.mutableNames = [[NSMutableArray alloc]init];
        
        NSInteger i=0;
        
        for (i=0; i<self.result.count; i++) {
            
            NSString *CampaignName = result[i][@"CampaignName"];
            
            NSString *status = result[i][@"StatusType"];
            
            NSString *country = result[i][@"Countries"];
            
            NSString *country2 = [country stringByReplacingOccurrencesOfString:@" " withString:@""];
            NSString *bidPrice = result[i][@"CurrentBid"];
            
            NSString *costType = result[i][@"CostTypeDesc"];
            
            NSString *tot = result[i][@"total"];
            NSString *tod = result[i][@"tracklogcount"];
            
            //NSLog(@"%@",tod);
            
            total = [tot intValue];
            
            if ([tod isEqual:[NSNull null]])
            {
                today = 0;
            }
            else{
                today = [tod integerValue];
            }
            
            Search *record = [Search new];
            
            record.record1 = [NSString stringWithFormat:@"%@",CampaignName];
            record.record2 = [NSString stringWithFormat:@"%@",status];
            record.record3 = [NSString stringWithFormat:@"%@",country2];
            record.record4 = [NSString stringWithFormat:@"%@",bidPrice];
            record.record5 = [NSString stringWithFormat:@"%@",costType];
            record.record6 = [NSString stringWithFormat:@"%@",tot];
            record.record7 = [NSString stringWithFormat:@"%@",tod];
            
            [_mutableNames addObject:record];
            
            if (indexPath.row == i) {
                
                self.cell.name.text = [NSString stringWithFormat:@"%@",CampaignName];
                self.cell.status.text = [NSString stringWithFormat:@"%@",status];
                
                self.cell.country.text = [NSString stringWithFormat:@"%@",country2];
                
                self.cell.bidPrice.text = [NSString stringWithFormat:@"%@",bidPrice];
                self.cell.CPA.text = [NSString stringWithFormat:@"%@",costType];
                
                [self setupBarLineChartView:self.cell.chartView];
                
                self.cell.chartView.delegate = self;
                
                self.cell.chartView.drawBarShadowEnabled = NO;
                self.cell.chartView.drawValueAboveBarEnabled = YES;
                
                self.cell.chartView.maxVisibleValueCount = 60;
                
                ChartXAxis *xAxis = self.cell.chartView.xAxis;
                
                xAxis.labelPosition = XAxisLabelPositionBottom;
                xAxis.labelFont = [UIFont systemFontOfSize:0.f];
                xAxis.drawAxisLineEnabled = YES;
                xAxis.drawGridLinesEnabled = YES;
                xAxis.gridLineWidth = .3;
                
                ChartYAxis *leftAxis = self.cell.chartView.leftAxis;
                leftAxis.labelFont = [UIFont systemFontOfSize:0.f];
                leftAxis.drawAxisLineEnabled = YES;
                leftAxis.drawGridLinesEnabled = YES;
                leftAxis.gridLineWidth = .3;
                leftAxis.axisMinValue = 0;
                
                // this replaces startAtZero = YES
                
                ChartYAxis *rightAxis = self.cell.chartView.rightAxis;
                rightAxis.enabled = YES;
                rightAxis.labelFont = [UIFont systemFontOfSize:0.f];
                rightAxis.drawAxisLineEnabled = NO;
                rightAxis.drawGridLinesEnabled = NO;
                rightAxis.axisMinValue = 0;
                
                // this replaces startAtZero = YES
                
                self.cell.chartView.legend.position = ChartLegendPositionBelowChartLeft;
                self.cell.chartView.legend.form = ChartLegendFormSquare;
                self.cell.chartView.legend.formSize = 8.0;
                
                
                self.cell.chartView.legend.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.f];
                self.cell.chartView.legend.xEntrySpace = 4.0;
                
                //_sliderX.value = 11.0;
                //_sliderY.value = 50.0;
                
                [self slidersValueChanged:nil];
                
                // NSLog(@"%ld",total);
                [self setDataCount:(_sliderX.value + 1) range:total];
                
                [self.cell.chartView animateWithYAxisDuration:2.5];

                
            }
        }
        names = [NSMutableArray arrayWithArray:_mutableNames];
    }

    [SVProgressHUD dismiss];
    
    return self.cell;
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"record1 contains [c] %@", searchText];
    
    searchResults = [names filteredArrayUsingPredicate:resultPredicate];
    
}


-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}




- (void)updateChartData
{
    if (self.shouldHideData)
    {
        //static NSString *MyIdentifier = @"campaigninfocell";
        //CampaignInfoCellTableViewCell *cell = [_CampaignInfoTable dequeueReusableCellWithIdentifier:MyIdentifier];
        self.cell.chartView.data = nil;
        return;
    }
    
    [self setDataCount:(_sliderX.value + 1) range:_sliderY.value];
}

- (void)setDataCount:(int)count range:(double)range
{
    NSMutableArray *xVals = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++)
    {
        [xVals addObject:months[i % 12]];
    }
    
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    NSMutableArray *yVals2 = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++)
    {
       // double mult = (range + 1);
        
        double val = total;
        double val2 = today;
        
        [yVals addObject:[[BarChartDataEntry alloc] initWithValue:val xIndex:i]];
        
        [yVals2 addObject:[[BarChartDataEntry alloc] initWithValue:val2 xIndex:i]];
    }
    
    BarChartDataSet *set1 = [[BarChartDataSet alloc] initWithYVals:yVals label:@"Total"];
   // set1.barSpace = 0.35;
    set1.colors = [[NSArray alloc] initWithObjects:
                   [UIColor orangeColor],nil];
    
    BarChartDataSet *set2 = [[BarChartDataSet alloc] initWithYVals:yVals2 label:@"Today"];
    
    set2.colors = [[NSArray alloc] initWithObjects:
                   [UIColor blackColor],nil];
    
       //set1.barSpace = 0.35;
    
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    [dataSets addObject:set1];
    [dataSets addObject:set2];
    
    BarChartData *data = [[BarChartData alloc] initWithXVals:xVals dataSets:dataSets];
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:10]];
    
    //static NSString *MyIdentifier = @"campaigninfocell";
    self.cell.chartView.data = data;
    
    //NSLog(@"%@", data);
    }

- (void)optionTapped:(NSString *)key
{
  //  [super handleOption:key forChartView: cell.chartView];
}

#pragma mark - Actions

- (IBAction)slidersValueChanged:(id)sender
{
    [self updateChartData];
}

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

- (void) alertStatus:(NSString *)msg :(NSString *)title :(int) tag
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil, nil];
    // UIAlertControllerStyle
    alertView.tag = tag;
    [alertView show];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //Iterate through your subviews, or some other custom array of views
    for (UIView *view in self.view.subviews)
        [view resignFirstResponder];
}
@end
