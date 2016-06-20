//
//  TopupSummaryViewController.m
//  MCatch
//
//  Created by MCOM Admin on 25/03/2016.
//  Copyright © 2016 Roman Efimov. All rights reserved.
//

#import "TopupSummaryViewController.h"
#import "TopupTableViewCell.h"

#import "SVProgressHUD.h"

#import "Search.h"

@interface TopupSummaryViewController () <UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *mutableNames;

@end
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"

@implementation TopupSummaryViewController
{
    NSArray *names;
    NSArray *searchResults;
}
    
@synthesize result;

- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    [self.searchDisplayController.searchResultsTableView setRowHeight:self.topupTable.rowHeight];
    
    self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];
    
    [SVProgressHUD show];
    //dispatch_async(dispatch_get_main_queue(), ^{
    NSString *accID = [[NSUserDefaults standardUserDefaults] objectForKey:@"AccID"];
    
        NSString *urlString = [NSString stringWithFormat:@"http://mobilemcatch.mcommsg.com/TopupSummary.aspx?AdvertiserID=%@",accID];
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
                 
                 [self.topupTable reloadData];
                });
             }
         
         }];
        
   // });

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



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
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [searchResults count];
        
    } else {
        return self.result.count;
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"topupcell";
   TopupTableViewCell *cell = [self.topupTable dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil) {
        cell = [[TopupTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    }
    
    Search *searching = nil;
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        searching   = [searchResults objectAtIndex:indexPath.row];
        NSInteger i=0;
        for (i=0; i<searchResults.count; i++) {
            
            cell.AdvId.text=searching.record1;
            cell.AdvName.text=searching.record2;
            cell.Year.text=searching.record3;
            cell.Month.text=searching.record4;
            cell.TotalSpent.text=searching.record5;
        }
    }
    else {
        searching = [names objectAtIndex:indexPath.row];
        
        names = [[NSArray alloc]init];
        
        self.mutableNames = [[NSMutableArray alloc]init];
        
        NSInteger i=0;
        
        for (i=0; i<self.result.count; i++) {
            
            NSString *advId = result[i][@"AdvertiserId"];
            
            NSString *advName = result[i][@"AdvertiserName"];
            
            NSString *year = result[i][@"YEAR"];
            
            NSString *month = result[i][@"MONTH"];
            
            NSString *totalspent = result[i][@"TotalSpent"];
                
            Search *record = [Search new];
            
            record.record1 = [NSString stringWithFormat:@"%@",advId];
            record.record2 = [NSString stringWithFormat:@"%@",advName];
            record.record3 = [NSString stringWithFormat:@"%@",year];
            record.record4 = [NSString stringWithFormat:@"%@",month];
            record.record5 = [NSString stringWithFormat:@"%@",totalspent];
            [_mutableNames addObject:record];
            
            if (indexPath.row == i) {
                
                cell.AdvId.text = [NSString stringWithFormat:@"%@",advId];
                cell.AdvName.text = [NSString stringWithFormat:@"%@",advName];
                cell.Year.text = [NSString stringWithFormat:@"%@",year];
                cell.Month.text = [NSString stringWithFormat:@"%@",month];
                cell.TotalSpent.text = [NSString stringWithFormat:@"%@",totalspent];            }
        }
        names = [NSMutableArray arrayWithArray:_mutableNames];
    
}
    [SVProgressHUD dismiss];
    
        return cell;
}
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"record2 contains [c] %@", searchText];
    
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


@end
