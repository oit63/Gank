//
//  WebViewController.h
//  gank
//
//  Created by yons on 15/8/18.
//  Copyright (c) 2015年 Alfred. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController

@property (strong, nonatomic) NSString *urlString;
- (void)prepareForView:(NSString *)string;
@end
