//
//  LanceToyDescriptionViewController.m
//  LanceToyStarter
//
//  Copyright © 2016 LanceHome. All rights reserved.
//

#import "LanceToyDescriptionViewController.h"
#import "LanceItem.h"

@interface LanceToyDescriptionViewController ()
@property (weak, nonatomic) IBOutlet UILabel *ItemName;
@property (weak, nonatomic) IBOutlet UILabel *itemValue;

@end

@implementation LanceToyDescriptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    LanceItem *item = self.item;
    self.ItemName.text = item.itemName;
    self.itemValue.text = [NSString stringWithFormat:@"%d %@", item.valueInDollars, @"$"];
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

@end
