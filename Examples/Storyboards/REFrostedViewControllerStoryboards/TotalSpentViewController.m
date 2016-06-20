//
//  TotalSpentViewController.m
//  MCatch
//
//  Created by MCOM Admin on 25/03/2016.
//  Copyright © 2016 Roman Efimov. All rights reserved.
//

#import "TotalSpentViewController.h"
#import "TotalSpentTableViewCell.h"

#import "SVProgressHUD.h"

@interface TotalSpentViewController ()<UITableViewDataSource,UITableViewDelegate>


@end

@implementation TotalSpentViewController

@synthesize result;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];
    [SVProgressHUD show];
    
    //dispatch_async(dispatch_get_main_queue(), ^{
         NSString *accID = [[NSUserDefaults standardUserDefaults] objectForKey:@"AccID"];
        NSString *urlString = [NSString stringWithFormat:@"http://mobilemcatch.mcommsg.com//TotalSpent.aspx?AdvertiserID=%@",accID];
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
                  [self.totalSpentTable reloadData];
     });
             }
         }];
        
    //});
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
    static NSString *MyIdentifier = @"totalspentcell";
   TotalSpentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    // if (cell == nil) {
    //      cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:MyIdentifier]];
    // }
    //Region *region = [regions objectAtIndex:indexPath.section];
    //TimeZoneWrapper *timeZoneWrapper = [region.timeZoneWrappers objectAtIndex:indexPath.row];
    //cell.textLabel.text = timeZoneWrapper.localeName;
    
   dispatch_async(dispatch_get_main_queue(), ^{
                 NSInteger i=0;
                 for (i=0; i<[self.result count]; i++) {
                     
      
                     NSString *CamId = result[i][@"campaignID"];
                     
                     NSString *CamName = result[i][@"campaignname"];
                     
                     NSString *CType = result[i][@"iCostType"];
                     
                     NSString *TCount = result[i][@"iTotalCount"];
                     
                     NSString *date = result[i][@"campdate"];
                     
//                     NSString *str1 = @"Hello your bal = 68094";
                     NSRange range = [date rangeOfString:@"T"];
                     
                     NSString *date2 = [date substringToIndex:range.location];
                     
                     NSString *CBid = result[i][@"CurrentBid"];
                     
          NSString *TSpent = result[i][@"iTotalSpent"]; 
                     
                     if (indexPath.row == i) {
                         
        cell.CampaignId.text = [NSString stringWithFormat:@"%@", CamId];
        cell.CampaignName.text = [NSString stringWithFormat:@"%@",CamName];
        cell.CostType.text = [NSString stringWithFormat:@"%@",CType];
        cell.TotalCount.text = [NSString stringWithFormat:@"%@",TCount];
        cell.Date.text = [NSString stringWithFormat:@"%@",date2];
        cell.CurentBid.text = [NSString stringWithFormat:@"%@",CBid];
        cell.TotalSpent.text = [NSString stringWithFormat:@"%@",TSpent];
        
                     }
             }
   });
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
