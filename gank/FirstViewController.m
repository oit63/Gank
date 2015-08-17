//
//  FirstViewController.m
//  gank
//
//  Created by yons on 15/8/17.
//  Copyright (c) 2015年 Alfred. All rights reserved.
//

#import "FirstViewController.h"
#import "AFNetworking.h"
#import "AFHTTPRequestOperation.h"

@interface FirstViewController ()
@property (nonatomic) NSArray *timeZoneNames;

@property (nonatomic,retain) IBOutlet UITableView *tableView;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self afnetworkingGet];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.timeZoneNames = [NSTimeZone knownTimeZoneNames];
}
- (void)afnetworkingGet {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:@"http://gank.avosapps.com/api/data/iOS/20/2" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@",responseObject);
        [self translateToNSString:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Fail");
    }];
}
- (void)translateToNSString:(NSData *)data {
    NSString *translatedStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(translatedStr);
}
#pragma mark - Table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of time zone names.
    return [self.timeZoneNames count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *MyIdentifier = @"MyIdentifier";
    
    /*
     Retrieve a cell with the given identifier from the table view.
     The cell is defined in the main storyboard: its identifier is MyIdentifier, and  its selection style is set to None.
     */
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    // Set up the cell.
    NSString *timeZoneName = [self.timeZoneNames objectAtIndex:indexPath.row];
    cell.textLabel.text = timeZoneName;
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
