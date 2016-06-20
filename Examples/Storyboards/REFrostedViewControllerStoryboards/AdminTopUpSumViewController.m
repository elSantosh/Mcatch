//
//  AdminTopUpSumViewController.m
//  MCatch
//
//  Created by MCOM Admin on 13/04/2016.
//  Copyright © 2016 MCOM. All rights reserved.
//

#import "AdminTopUpSumViewController.h"
#import "SVProgressHUD.h"
#import "AdminTopupTableViewCell.h"

#import "Search.h"

@interface AdminTopUpSumViewController ()

@property (strong, nonatomic) NSMutableArray *mutableNames;

@end

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"



@implementation AdminTopUpSumViewController
{
    NSArray *names;
    NSArray *searchResults;
}
@synthesize result;


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.searchDisplayController.searchResultsTableView setRowHeight:self.FTSTable.rowHeight];
    
 // Do any additional setup after loading the view.
    self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];
    [SVProgressHUD show];
    //dispatch_async(dispatch_get_main_queue(), ^{
    NSString *accID = [[NSUserDefaults standardUserDefaults] objectForKey:@"AccID"];
    
    NSString *urlString = [NSString stringWithFormat:@"http://mobilemcatch.mcommsg.com/AdminAdvTopupSummary.aspx?AdminID=%@",accID];
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
            NSError *error = nil;
             NSMutableArray *jsonData = [NSJSONSerialization
                                         JSONObjectWithData:data
                                         options:NSJSONReadingMutableContainers
                                         error:&error];
            
             dispatch_async(dispatch_get_main_queue(), ^{
         
                self.result = jsonData;
                
                [self.FTSTable reloadData];
            });
         }
         
     }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 128;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    static NSString *MyIdentifier = @"adminTopup";
    AdminTopupTableViewCell *cell = [self.FTSTable dequeueReusableCellWithIdentifier:MyIdentifier];
   
    if (cell == nil) {
        cell = [[AdminTopupTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    }
    
    Search *searching = nil;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        searching   = [searchResults objectAtIndex:indexPath.row];
        NSInteger i=0;
        for (i=0; i<searchResults.count; i++) {
            
            cell.advId.text=searching.record1;
            cell.advName.text=searching.record2;
            cell.year.text=searching.record3;
            cell.month.text=searching.record4;
            cell.total.text=searching.record5;
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
            
            cell.advId.text = [NSString stringWithFormat:@"%@",advId];
            cell.advName.text = [NSString stringWithFormat:@"%@",advName];
            cell.year.text = [NSString stringWithFormat:@"%@",year];
            cell.month.text = [NSString stringWithFormat:@"%@",month];
            cell.total.text = [NSString stringWithFormat:@"%@",totalspent];
            
        }
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
#pragma GCC diagnostic pop

@end
