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
#import "WebViewController.h"

@interface FirstViewController ()
@property (nonatomic) NSArray *timeZoneNames;

@property (weak, nonatomic) IBOutlet UILabel *who;
@property (weak, nonatomic) IBOutlet UILabel *publishedAt;

@property (nonatomic) IBOutlet UITableView *tableView;
@end

@implementation FirstViewController
@synthesize news;
@synthesize tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self afnetworkingGet];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
//    self.timeZoneNames = [NSTimeZone knownTimeZoneNames];
}

- (void)afnetworkingGet {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:@"http://gank.avosapps.com/api/data/iOS/20/2" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@",responseObject);
        //parse out the json data
        NSError* error;
        NSDictionary* json = [NSJSONSerialization
                              JSONObjectWithData:responseObject //1
                              options:NSJSONReadingAllowFragments
                              error:&error];
        
        news = [json objectForKey:@"results"]; //2
            NSLog(@"results: %@", news); //3
        [tableView reloadData];
//        [self translateToNSString:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Fail");
    }];
}
- (void)translateToNSString:(NSData *)data {
    NSString *translatedStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(translatedStr);
}
- (void)fetchedData:(NSData *)responseData {
    
}
#pragma mark - Table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of time zone names.
    return [news count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"cell height %f",cell.bounds.size.height);
    CGFloat height = cell.frame.size.height;
    if (height >= 80) {
        return 100;
    }else if (height >= 70) {
        return 100;
    } else if (height >= 60) {
        return 80;
    } else if (height >= 40) {
        return 60;
    } else if (height >= 20) {
        return 40;
    }
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    /*
     Retrieve a cell with the given identifier from the table view.
     The cell is defined in the main storyboard: its identifier is MyIdentifier, and  its selection style is set to None.
     */
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyIdentifier"];
    
    
//    NSLog(@"results: %@", news); //3

    //        NSMutableString *str = [NSMutableString stringWithCapacity:40];
    for (NSDictionary *result in news) {
        NSLog(@"标题名称：《%@》, 作者: %@, 发表于：%@,  网址：%@， ",[result objectForKey:@"desc"],[result objectForKey:@"who"],[result objectForKey:@"publishedAt"],[result objectForKey:@"url"]);
        NSString * publishedTime = [[result objectForKey:@"publishedAt"] substringToIndex:10];
        //            [str appendString:[NSString stringWithFormat:@"employee's first name is %@,last name is %@\n",[result objectForKey:@"publishedAt"],[result objectForKey:@"url"]]];
        NSLog(@"%@",publishedTime);
    }
    
    
    // Set up the cell.
    NSDictionary *iOSnews = [news objectAtIndex:indexPath.row];
    NSString * desc = [iOSnews objectForKey:@"desc"];
    cell.textLabel.font = [UIFont fontWithName:@"Monaca" size:7];
    cell.textLabel.frame = CGRectMake(0, 0, 40, 80);
    cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
    cell.textLabel.numberOfLines = 11;
    cell.textLabel.text = desc;
//
    cell.frame = CGRectMake(0, 0, 320,[cell.textLabel.text boundingRectWithSize: CGSizeMake(320, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:cell.textLabel.font, NSFontAttributeName, nil] context:nil].size.height);
   NSLog(@"cell faf %f",cell.frame.size.height);
//  
//    label.textAlignment = NSTextAlignmentLeft;
//    label.text = @"Here who";

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *iOSnews = [news objectAtIndex:indexPath.row];
    NSString *urlString = [iOSnews objectForKey:@"url"];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    WebViewController *webViewController = [storyboard instantiateViewControllerWithIdentifier:@"WebView"];
    webViewController.urlString = urlString;

    [self.navigationController pushViewController:webViewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
