//
//  TrackSummaryViewController.m
//  MCatch
//
//  Created by MCOM Admin on 25/03/2016.
//  Copyright © 2016 Roman Efimov. All rights reserved.
//

#import "TrackSummaryViewController.h"
#import "TrackSummaryTableViewCell.h"

#import "SVProgressHUD.h"

@interface TrackSummaryViewController () <UITableViewDataSource,UITableViewDelegate>


@end

@implementation TrackSummaryViewController
@synthesize result;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];
    [SVProgressHUD show];
    
    dispatch_async(dispatch_get_main_queue(), ^{
         NSString *accID = [[NSUserDefaults standardUserDefaults] objectForKey:@"AccID"];
        
        NSString *urlString = [NSString stringWithFormat:@"http://mobilemcatch.mcommsg.com/AdvTracksummary.aspx?AdvertiserID=%@",accID];
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
                 [self.TrackSummaryTable reloadData];
                 });
                 //NSLog(@"%@",jsonData[0][@"YEAR"]);
    // Do any additional setup after loading the view.
             
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
    static NSString *MyIdentifier = @"tracksumcell";
    TrackSummaryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    // if (cell == nil) {
    //      cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:MyIdentifier]];
    // }
    //Region *region = [regions objectAtIndex:indexPath.section];
    //TimeZoneWrapper *timeZoneWrapper = [region.timeZoneWrappers objectAtIndex:indexPath.row];
    //cell.textLabel.text = timeZoneWrapper.localeName;
    
   
                 NSInteger i=0;
                 for (i=0; i<[self.result count]; i++) {
                     
                     
                     NSString *camName = result[i][@"campaignname"];
                     
                     NSString *Date = result[i][@"Date"];
                     
                     NSString *cType = result[i][@"costtype"];
                     
                     NSString *Total = result[i][@"Total"];
                     
                     
                     
                     if (indexPath.row == i) {
                         
                         cell.campaignName.text = [NSString stringWithFormat:@"%@", camName];
                         cell.date.text = [NSString stringWithFormat:@"%@",Date];
                         cell.costType.text = [NSString stringWithFormat:@"%@",cType];
                         cell.total.text = [NSString stringWithFormat:@"%@",Total];
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
