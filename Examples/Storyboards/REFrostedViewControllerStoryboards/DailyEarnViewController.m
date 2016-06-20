//
//  DailyEarnViewController.m
//  MCatch
//
//  Created by MCOM Admin on 28/03/2016.
//  Copyright © 2016 Roman Efimov. All rights reserved.
//

#import "DailyEarnViewController.h"
#import "DailyEarnTableViewCell.h"

#import "SVProgressHUD.h"

@interface DailyEarnViewController () <UITableViewDataSource,UITableViewDelegate>


@end

@implementation DailyEarnViewController
@synthesize result;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [SVProgressHUD show];
    
    self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSString *accID = [[NSUserDefaults standardUserDefaults] objectForKey:@"AccID"];
        
        NSString *urlString = [NSString stringWithFormat:@"http://mobilemcatch.mcommsg.com/PublisherDailyEarn.aspx?publisherid=%@",accID];
        NSURL *url = [[NSURL alloc] initWithString:urlString];
        
        [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
         {
             //NSLog(@"%@",data);
             if (error)
             {
                 NSLog(@"error");
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
                 
                     [self.dailyEarnTable reloadData];
                 });
                 
                }
         }];
        
    });

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)menu:(id)sender {
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Number of rows is the number of time zones in the region for the specified section.
    // Region *region = [regions objectAtIndex:section];
    // return [region.timeZoneWrappers count];
    return self.result.count;
    
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    // The header for the section is the region name -- get this from the region at the section index.
//   // Region *region = [regions objectAtIndex:section];
//    return NULL;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"dailyearncell";
    DailyEarnTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
                 NSInteger i=0;
                 for (i=0; i<[self.result count]; i++) {
                     
                     NSString *camId = result[i][@"CampaignId"];
                     
                     NSString *dat = result[i][@"date"];
                     
                     NSString *CType = result[i][@"costtype"];
                     
                     NSString *payou = result[i][@"payout"];
                     
                     NSString *totalunit = result[i][@"Total"];
                     
                     NSString *totalpayout = result[i][@"TotalPayout"];
                     
                     if (indexPath.row == i) {
                         
                         cell.campaignId.text = [NSString stringWithFormat:@"%@", camId];
                         cell.date.text =[NSString stringWithFormat:@"%@", dat];
                         cell.costType.text = [NSString stringWithFormat:@"%@", CType];
                        cell.payout.text = [NSString stringWithFormat:@"%@",payou];
                         cell.totalUnit.text = [NSString stringWithFormat:@"%@",totalunit];
                         cell.totalPayout.text = [NSString stringWithFormat:@"%@",totalpayout];
                     }
                 }
    [SVProgressHUD dismiss];
    return cell;
}

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


@end
