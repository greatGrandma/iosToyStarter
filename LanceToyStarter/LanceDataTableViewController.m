//
//  LanceDataTableViewController.m
//  LanceToyStarter
//
//  Copyright © 2016 LanceHome. All rights reserved.
//

#import "LanceDataTableViewController.h"
#import "LanceItem.h"
#import "LanceToyDescriptionViewController.h"

@interface LanceDataTableViewController ()<NSURLSessionDelegate>
@property (nonatomic) NSMutableArray *privateItems;
@property (nonatomic, strong) NSURLSession *session;

@property (nonatomic, copy) NSArray *courses;

@end

@implementation LanceDataTableViewController

- (instancetype) init
{
    self = [super initWithStyle:UITableViewStylePlain];
    _privateItems = [[NSMutableArray alloc] init];
    LanceItem *newItem1 = [[LanceItem alloc] initWithItemName:@"Item 1" valueInDollars:2];
    [self.privateItems addObject:newItem1];
    LanceItem *newItem2 = [[LanceItem alloc] initWithItemName:@"Item 2" valueInDollars:22];
    [self.privateItems addObject:newItem2];
    
    LanceItem *newItem3 = [[LanceItem alloc] initWithItemName:@"Item 3" valueInDollars:33];
    [self.privateItems addObject:newItem3];
    
    LanceItem *newItem4 = [[LanceItem alloc] initWithItemName:@"Item 4" valueInDollars:55];
    [self.privateItems addObject:newItem4];
    
    
    if(self){
        NSURLSessionConfiguration *config =
        [NSURLSessionConfiguration defaultSessionConfiguration];
        
        _session = [NSURLSession sessionWithConfiguration:config
                                                 delegate:self
                                            delegateQueue:nil];
        
        [self fetchFeed];
    }
    return self;
    
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"UITableViewCell"];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)fetchFeed
{
    NSString *requestString = @"https://bookapi.bignerdranch.com/private/courses.json";
    NSURL *url = [NSURL URLWithString:requestString];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *dataTask =
    [self.session dataTaskWithRequest:req
                    completionHandler:
     ^(NSData *data, NSURLResponse *response, NSError *error) {
         
         NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data
                                                                    options:0
                                                                      error:nil];
         self.courses = jsonObject[@"courses"];
         
         NSLog(@"%@", self.courses);
         
         dispatch_async(dispatch_get_main_queue(), ^{
             [self.tableView reloadData];
         });
     }];
    [dataTask resume];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    //    return [self.privateItems count];
    return [self.courses count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Get a new or recycled cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    
    //    NSArray *items = [self.privateItems copy];
    //    LanceItem *item = items[indexPath.row];
    //
    //    cell.textLabel.text = [item itemName];
    
    NSDictionary *course = self.courses[indexPath.row];
    cell.textLabel.text = course[@"title"];
    
    return cell;
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    LanceToyDescriptionViewController *detailViewController = [[LanceToyDescriptionViewController alloc] init];
    
    LanceItem *selectedItem = self.privateItems[indexPath.row];
    detailViewController.item = selectedItem;
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}



- (void)  URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
 didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
   completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *))completionHandler
{
    NSURLCredential *cred =
    [NSURLCredential credentialWithUser:@"BigNerdRanch"
                               password:@"AchieveNerdvana"
                            persistence:NSURLCredentialPersistenceForSession];
    completionHandler(NSURLSessionAuthChallengeUseCredential, cred);
}

//- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *credential))completionHandler
//{
//    completionHandler(NSURLSessionAuthChallengeUseCredential, [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust]);
//}

@end
