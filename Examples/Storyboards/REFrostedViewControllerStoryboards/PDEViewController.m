//
//  PDEViewController.m
//  MCatch
//
//  Created by MCOM Admin on 20/04/2016.
//  Copyright © 2016 MCOM. All rights reserved.
//

#import "PDEViewController.h"
#import "SVProgressHUD.h"
#import "PDETableViewCell.h"
#import "Search.h"

@interface PDEViewController ()

@property (strong, nonatomic) NSMutableArray *mutableNames;

@end

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"


@implementation PDEViewController
    {
        NSArray *names;
        NSArray *searchResults;
    }

@synthesize result;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.searchDisplayController.searchResultsTableView setRowHeight:self.PDETable.rowHeight];
    
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];
    [SVProgressHUD show];
    //dispatch_async(dispatch_get_main_queue(), ^{
    NSString *accID = [[NSUserDefaults standardUserDefaults] objectForKey:@"AccID"];
    
    NSString *urlString = [NSString stringWithFormat:@"http://mobilemcatch.mcommsg.com/AdminPubDailyEarn.aspx?AdminID=%@",accID];
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
                 
                 [self.PDETable reloadData];
             });
         }
         
     }];
    
    // });
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
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
    static NSString *MyIdentifier = @"PDECell";
    PDETableViewCell *cell = [self.PDETable dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil) {
        cell = [[PDETableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    }
    
    Search *searching = nil;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        searching   = [searchResults objectAtIndex:indexPath.row];
        NSInteger i=0;
        for (i=0; i<searchResults.count; i++) {
            
            cell.campId.text=searching.record1;
            cell.Id.text=searching.record2;
            cell.name.text=searching.record3;
            cell.date.text=searching.record4;
            cell.exDate.text=searching.record5;
            cell.payout.text=searching.record6;
            cell.costType.text=searching.record7;
            cell.total.text=searching.record8;
            cell.totalPayout.text=searching.record9;
            cell.status.text=searching.record10;
        }
    }
    else {
        searching = [names objectAtIndex:indexPath.row];
        
        names = [[NSArray alloc]init];
        
        self.mutableNames = [[NSMutableArray alloc]init];
        
        NSInteger i=0;
        
        for (i=0; i<self.result.count; i++) {
            
            
            NSString *cId = result[i][@"CampaignId"];
            
            NSString *camID = result[i][@"channeltype"];
            
            NSString *pName = result[i][@"publishername"];
            
            NSString *dat = result[i][@"Date"];
            NSRange range = [dat rangeOfString:@"T"];
            
            NSString *dat2 = [dat substringToIndex:range.location];
            
            NSString *exDat = result[i][@"ExpiryDate"];
            
            NSRange range2 = [exDat rangeOfString:@"T"];
            
            NSString *exDat2 = [exDat substringToIndex:range2.location];
            
            NSString *cType = result[i][@"costtype"];
            
            NSString *payout = result[i][@"payout"];
            
            NSString *totUnit = result[i][@"Total"];
            
            NSString *totalPay = result[i][@"TotalPayout"];
            
            NSString *stat = result[i][@"OffersStatus"];
            
            Search *record = [Search new];
            
            record.record1 = [NSString stringWithFormat:@"%@",cId];
            record.record2 = [NSString stringWithFormat:@"%@",camID];
            record.record3 = [NSString stringWithFormat:@"%@",pName];
            record.record4 = [NSString stringWithFormat:@"%@",dat2];
            record.record5 = [NSString stringWithFormat:@"%@",exDat2];
            record.record6 = [NSString stringWithFormat:@"%@",payout];
            record.record7 = [NSString stringWithFormat:@"%@",cType];
            record.record8 = [NSString stringWithFormat:@"%@",totUnit];
            record.record9 = [NSString stringWithFormat:@"%@",totalPay];
            record.record10 = [NSString stringWithFormat:@"%@",stat];

            [_mutableNames addObject:record];
            
            if (indexPath.row == i) {
                
                
                cell.campId.text = [NSString stringWithFormat:@"%@",cId];
                cell.Id.text = [NSString stringWithFormat:@"%@",camID];
                cell.name.text = [NSString stringWithFormat:@"%@",pName];
                cell.date.text = [NSString stringWithFormat:@"%@",dat2];
                cell.exDate.text = [NSString stringWithFormat:@"%@",exDat2];
                cell.costType.text = [NSString stringWithFormat:@"%@",cType];
                cell.payout.text = [NSString stringWithFormat:@"%@",payout];
                cell.total.text = [NSString stringWithFormat:@"%@",totUnit];
                cell.totalPayout.text = [NSString stringWithFormat:@"%@",totalPay];
                cell.status.text = [NSString stringWithFormat:@"%@",stat];
            }
        }
        names = [NSMutableArray arrayWithArray:_mutableNames];
    }
    
    [SVProgressHUD dismiss];
    
    return cell;
}
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"record3 contains [c] %@", searchText];
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
@end
