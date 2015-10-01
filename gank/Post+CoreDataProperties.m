//
//  Post+CoreDataProperties.m
//  gank
//
//  Created by Forrest Alfred on 15/9/27.
//  Copyright © 2015年 Alfred. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Post+CoreDataProperties.h"

@interface Post ()
@property (nonatomic, strong) NSDate *dateCreated;
@end
@implementation Post (CoreDataProperties)

@dynamic title;
@dynamic url;
@dynamic author;
@dynamic favourite;
@dynamic date;

/**
 *  set post key, when the post is created
 */
- (void)awakeFromInsert
{
    [super awakeFromInsert];
    self.dateCreated = [NSDate date];
    // Create an NSUUID object - and get its string representation
    NSUUID *uuid = [[NSUUID alloc] init];
    NSString *key = [uuid UUIDString];
    self.itemKey = key;
    self.thumbnail = [UIImage imageNamed:@"bumpOn"];
    
    
}
@end
