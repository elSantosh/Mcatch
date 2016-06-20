//
//  PubViewController.m
//  MCatch
//
//  Created by MCOM Admin on 28/03/2016.
//  Copyright © 2016 Roman Efimov. All rights reserved.
//

#import "PubViewController.h"

@interface PubViewController ()

@end

@implementation PubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)awakeFromNib
{
    
    
    self.contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"pubNav"];
    self.menuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"menuController"];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
