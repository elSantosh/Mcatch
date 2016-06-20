//
//  DEMOMenuViewController.m
//  REFrostedViewControllerStoryboards
//
//  Created by Roman Efimov on 10/9/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//
#import "SVProgressHUD.h"

#import "DEMOHomeViewController.h"
#import "DEMOSecondViewController.h"
#import "TopupSummaryViewController.h"
#import "TotalSpentViewController.h"
#import "TrackSummaryViewController.h"
#import "ProfileViewController.h"
//
#import "DEMOMenuViewController.h"
#import "LoginViewController.h"
//
#import "PDashboardViewController.h"
#import "MyOffersViewController.h"
#import "DailyEarnViewController.h"
#import "TotalEarnViewController.h"
#import "PTrackSumViewController.h"
//
#import "AdminDashboardViewController.h"
#import "AdminTopUpSumViewController.h"
#import "AdminLowCreditViewController.h"
#import "AdminTrackSumViewController.h"
#import "ACAViewController.h"
#import "ATSViewController.h"
#import "PTEViewController.h"
#import "PDEViewController.h"
#import "PTSViewController.h"



#import "UIViewController+REFrostedViewController.h"
//
#import "DEMONavigationController.h"
//
#import "PubNavViewController.h"

#import "AdminNavViewController.h"

@interface DEMOMenuViewController ()

@end

@implementation DEMOMenuViewController

@synthesize AdvId2;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.tableView.separatorColor = [UIColor colorWithRed:150/255.0f green:161/255.0f blue:177/255.0f alpha:1.0f];
    self.tableView.separatorColor = [UIColor grayColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.opaque = NO;
    self.tableView.backgroundColor = [UIColor orangeColor];
    self.tableView.tableHeaderView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 184.0f)];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, 100, 100)];
        imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        imageView.image = [UIImage imageNamed:@"avatar.png"];
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = 50.0;
        imageView.layer.borderColor = [UIColor blackColor].CGColor;
        imageView.layer.borderWidth = 3.0f;
        imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
        imageView.layer.shouldRasterize = YES;
        imageView.clipsToBounds = YES;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, 0, 24)];
        
        NSNumber *accType = [[NSUserDefaults standardUserDefaults] objectForKey:@"accType"];
        
       // NSLog(@"%@",accType);
        
        if ([accType isEqualToNumber:@2]) {
        label.text = @"Advertiser";
        }
        else if ([accType isEqualToNumber:@3]){
            label.text = @"Publisher";
        }
        else if ([accType isEqualToNumber:@1]){
            label.text = @"Admin";
        }
        label.font = [UIFont fontWithName:@"HelveticaNeue" size:21];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
        [label sizeToFit];
        label.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        
        [view addSubview:imageView];
        [view addSubview:label];
        view;
    });
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
   
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)sectionIndex
//{
//    if (sectionIndex == 0)
//        return nil;
//    
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 34)];
//    view.backgroundColor = [UIColor colorWithRed:167/255.0f green:167/255.0f blue:167/255.0f alpha:0.6f];
//    
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 0, 0)];
//    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
//
//   // label.text = @"Section 2";
//    label.font = [UIFont systemFontOfSize:15];
//    label.textColor = [UIColor whiteColor];
//    label.backgroundColor = [UIColor clearColor];
//    [label sizeToFit];
//    [view addSubview:label];
//    
//    return view;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex
{
    if (sectionIndex == 0)
        return 0;
    
    return 34;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSNumber *accType = [[NSUserDefaults standardUserDefaults] objectForKey:@"accType"];
    
    //NSLog(@"%@",accType);
    
    if ([accType isEqualToNumber:@2]) {
        
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DEMONavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        DEMOHomeViewController *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"homeController"];
        [SVProgressHUD show];
        navigationController.viewControllers = @[homeViewController];
        
    } else if(indexPath.section == 0 && indexPath.row == 1){
        DEMOSecondViewController *secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"secondController"];
        [SVProgressHUD show];
        navigationController.viewControllers = @[secondViewController];
    }
    
    else if(indexPath.section == 0 && indexPath.row == 2){
        TopupSummaryViewController *topupview = [self.storyboard instantiateViewControllerWithIdentifier:@"topup"];
        [SVProgressHUD show];
        navigationController.viewControllers = @[topupview];
    }
    
    else if(indexPath.section == 0 && indexPath.row == 3){
        TotalSpentViewController *totalspentview = [self.storyboard instantiateViewControllerWithIdentifier:@"totalspent"];
        [SVProgressHUD show];
        navigationController.viewControllers = @[totalspentview];
    }
    
    else if(indexPath.section == 0 && indexPath.row == 4){
        TrackSummaryViewController *tracksumview = [self.storyboard instantiateViewControllerWithIdentifier:@"tracksum"];
        [SVProgressHUD show];
        navigationController.viewControllers = @[tracksumview];
    }
    
    else if(indexPath.section == 0 && indexPath.row == 5){
        ProfileViewController *profileview = [self.storyboard instantiateViewControllerWithIdentifier:@"profile"];
        [SVProgressHUD show];
        navigationController.viewControllers = @[profileview];
    }
    
    else
    {
        LoginViewController *loginview = [self.storyboard instantiateViewControllerWithIdentifier:@"loginview"];
        //navigationController.viewControllers = @[loginview];
        [self presentViewController:loginview animated:YES completion:nil];
       // [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
        
         //[self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
    
    self.frostedViewController.contentViewController = navigationController;
    [self.frostedViewController hideMenuViewController];
}

else if ([accType isEqualToNumber:@3])
    {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
       PubNavViewController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"pubNav"];
        
        if (indexPath.section == 0 && indexPath.row == 0) {
           PDashboardViewController *dashboard= [self.storyboard instantiateViewControllerWithIdentifier:@"pDashboard"];
            [SVProgressHUD show];
            navigationController.viewControllers = @[dashboard];
            
        } else if(indexPath.section == 0 && indexPath.row == 1){
            MyOffersViewController *secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"myofers"];
            [SVProgressHUD show];
            navigationController.viewControllers = @[secondViewController];
        }
        
        else if(indexPath.section == 0 && indexPath.row == 2){
            DailyEarnViewController *dailyEarn = [self.storyboard instantiateViewControllerWithIdentifier:@"DailyEarn"];
            [SVProgressHUD show];
            navigationController.viewControllers = @[dailyEarn];
        }
        
        else if(indexPath.section == 0 && indexPath.row == 3){
            TotalEarnViewController *totalEarn = [self.storyboard instantiateViewControllerWithIdentifier:@"TotalEarn"];
            [SVProgressHUD show];
            navigationController.viewControllers = @[totalEarn];
        }
        
        else if(indexPath.section == 0 && indexPath.row == 4){
            PTrackSumViewController *tracksumview = [self.storyboard instantiateViewControllerWithIdentifier:@"pTrackSum"];
            [SVProgressHUD show];
            navigationController.viewControllers = @[tracksumview];
        }
        
        else if(indexPath.section == 0 && indexPath.row == 5){
            ProfileViewController *profileview = [self.storyboard instantiateViewControllerWithIdentifier:@"profile"];
            [SVProgressHUD show];
            navigationController.viewControllers = @[profileview];
        }
        
        else
        {
            LoginViewController *loginview = [self.storyboard instantiateViewControllerWithIdentifier:@"loginview"];
            //navigationController.viewControllers = @[loginview];
            
            [self presentViewController:loginview animated:YES completion:nil];
            
            //[[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
        }
        
        self.frostedViewController.contentViewController = navigationController;
        [self.frostedViewController hideMenuViewController];
}
    
if ([accType isEqualToNumber:@1]) {

        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        AdminNavViewController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"AdminNav"];
        
        if (indexPath.section == 0 && indexPath.row == 0) {
            AdminDashboardViewController *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"adminDash"];
            [SVProgressHUD show];
            navigationController.viewControllers = @[homeViewController];
            
        } else if(indexPath.section == 0 && indexPath.row == 1){
            AdminTopUpSumViewController *secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"adminTopup"];
            [SVProgressHUD show];
            navigationController.viewControllers = @[secondViewController];
        }
        
        else if(indexPath.section == 0 && indexPath.row == 2){
            AdminLowCreditViewController *topupview = [self.storyboard instantiateViewControllerWithIdentifier:@"lowCredit"];
            [SVProgressHUD show];
            navigationController.viewControllers = @[topupview];
        }
        
        else if(indexPath.section == 0 && indexPath.row == 3){
            AdminTrackSumViewController *totalspentview = [self.storyboard instantiateViewControllerWithIdentifier:@"adminTrack"];
            [SVProgressHUD show];
            navigationController.viewControllers = @[totalspentview];
        }
        
        else if(indexPath.section == 0 && indexPath.row == 4){
            ACAViewController *tracksumview = [self.storyboard instantiateViewControllerWithIdentifier:@"ACA"];
            [SVProgressHUD show];
            navigationController.viewControllers = @[tracksumview];
        }
        
        else if(indexPath.section == 0 && indexPath.row == 5){
            ATSViewController *profileview = [self.storyboard instantiateViewControllerWithIdentifier:@"ATS"];
            [SVProgressHUD show];
            navigationController.viewControllers = @[profileview];
        }
        else if(indexPath.section == 0 && indexPath.row == 6){
            PTEViewController *profileview = [self.storyboard instantiateViewControllerWithIdentifier:@"PTE"];
            [SVProgressHUD show];
            navigationController.viewControllers = @[profileview];
        }
        else if(indexPath.section == 0 && indexPath.row == 7){
            PDEViewController *profileview = [self.storyboard instantiateViewControllerWithIdentifier:@"PDE"];
            [SVProgressHUD show];
            navigationController.viewControllers = @[profileview];
        }
        else if(indexPath.section == 0 && indexPath.row == 8){
            PTSViewController *profileview = [self.storyboard instantiateViewControllerWithIdentifier:@"PTS"];
            [SVProgressHUD show];
            navigationController.viewControllers = @[profileview];
        }
        else
        {
            LoginViewController *loginview = [self.storyboard instantiateViewControllerWithIdentifier:@"loginview"];
            //navigationController.viewControllers = @[loginview];
            
            [self presentViewController:loginview animated:YES completion:nil];
                       // [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
            
            //[self.navigationController dismissViewControllerAnimated:YES completion:nil];
        }
        
        self.frostedViewController.contentViewController = navigationController;
        [self.frostedViewController hideMenuViewController];
    }
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
     NSNumber *accType = [[NSUserDefaults standardUserDefaults] objectForKey:@"accType"];
    
    if ([accType isEqualToNumber:@1])
    {
        return 10;
    }
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if (indexPath.section == 0) {
        
        NSNumber *accType = [[NSUserDefaults standardUserDefaults] objectForKey:@"accType"];
        
        //NSLog(@"%@",accType);
        
        if ([accType isEqualToNumber:@2]) {
            
        NSArray *titles = @[@"Dashboard", @"Campaign Info",@"Topup Summary",@"Total Spent",@"Track Summary", @"Profile",@"Logout"];
         
           // NSMutableArray *icons;
            
          // icons = [[NSMutableArray alloc] initWithObjects:@"A_Dashboard.png",@"A_Campaign.png",@"A_Topup.png",@"A_Totalsp.png",@"A_TraSum.png",@"A_Profile.png",@"A_Logout.png",nil];
            
            //cell.imageView.image = icons[indexPath.row];
            cell.textLabel.text = titles[indexPath.row];
            
        }
        else if ([accType isEqualToNumber:@3]) {
            //([accType  isEqualToString: @"3"]){
        {
            NSArray *titles = @[@"Dashboard", @"My Offers",@"Daily Earn",@"Total Earn",@"Track Summary", @"Profile",@"Logout"];
            
           //NSArray *icons = @[@"P_Dashboard.png",@"P_MyOffers.png",@"P_Daily earn.png",@"P_Total earn.png",@"P_Track Summary.png",@"P_Profie.png",@"P_Logout.png"];
            
            cell.textLabel.text = titles[indexPath.row];
            //cell.imageView.image = icons[indexPath.row];
        }
        
        } else if ([accType isEqualToNumber:@1])
           
            {
                NSArray *titles = @[@"Dashboard", @"Finance Topup Summary",@"Finance Low Credit",@"Advertiser Track Summary",@"Advertiser Campaign Analysis", @"Advertiser Total Spent",@"Publisher Total Earn",@"Publisher Daily Earn",@"Publisher Track Summary",@"Logout"];
                
                //NSArray *icons = @[@"P_Dashboard.png",@"P_MyOffers.png",@"P_Daily earn.png",@"P_Total earn.png",@"P_Track Summary.png",@"P_Profie.png",@"P_Logout.png"];
                
                cell.textLabel.text = titles[indexPath.row];
                //cell.imageView.image = icons[indexPath.row];
            }
            else {
        NSArray *titles = @[@"", @"", @""];
        cell.textLabel.text = titles[indexPath.row];
    }
    }
    return cell;
    }
 
@end
