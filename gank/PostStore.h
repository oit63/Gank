//
//  PostStore.h
//  gank
//
//  Created by Forrest Alfred on 15/9/27.
//  Copyright © 2015年 Alfred. All rights reserved.
//
#import <CoreData/CoreData.h>
#import <Foundation/Foundation.h>
#import "Post+CoreDataProperties.h"

@interface PostStore : NSObject

@property (nonatomic, strong) NSManagedObjectContext *context;
@property (nonatomic, readonly) NSArray *allPosts;

- (Post *)createPost;

- (void)removePost:(Post *)room;

- (BOOL)saveChanges;


@end
