//
//  PostStore.m
//  gank
//
//  Created by Forrest Alfred on 15/9/27.
//  Copyright © 2015年 Alfred. All rights reserved.
//

#import "PostStore.h"

@interface PostStore ()

/**
 *  posts got from sqlite
 */
@property (nonatomic) NSMutableArray *privateRooms;

/**
 * common model used to get especial model
 */
@property (nonatomic, strong) NSManagedObjectModel *model;
@end

@implementation PostStore

/**
 *  create post
 *
 *  @return created post
 */
- (Post *)createPost
{
    double order;
    if ([self.allPosts count] == 0) {
        order = 1.0;
    } else {
        order = [[self.privatePosts lastObject] orderingValue] + 1.0;
    }
    NSLog(@"Adding after %lul posts, order = %.2f", (unsigned long)[self.privatePosts count], order);
    
    Post *post = [NSEntityDescription insertNewObjectForEntityForName:@"Post"
                                               inManagedObjectContext:self.context];
    NSLog(@"Key when create %@",post.postKey);
    post.orderingValue = order;
    [self.privatePosts addObject:post];
    return post;
}

/**
 *  remove post
 *
 *  @param post post would be remove
 */
- (void)removePost:(Post *)post
{
    NSString *key = post.postKey;
    if (key) {
        [[ImageStore sharedStore] deleteImageForKey:key];
    }
    [self.context deleteObject:post];
    [self.privatePosts removeObjectIdenticalTo:post];
}

/**
 *  save the temparary post array into sqlite
 *
 *  @return result of the save operation
 */
- (BOOL)saveChanges
{
    NSError *error;
    BOOL successful = [self.context save:&error];
    if (!successful) {
        NSLog(@"Error saving: %@", [error localizedDescription]);
    }
    return successful;
}
@end
