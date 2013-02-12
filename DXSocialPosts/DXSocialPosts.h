//
//  DXSocialPosts.h
//  DXSocialPosts
//
//  Created by TheSooth on 1/30/13.
//  Copyright (c) 2013 TheSooth. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^DXSocialPostsCallbackBlock)(id response);

@interface DXSocialPosts : NSObject

+ (void)getFacebookFeedPostsForUserID:(long long)aUserID withCallbackBlock:(DXSocialPostsCallbackBlock)aCallBackBlock;

+ (void)getTwitterTimelineRequestForUser:(NSString *)aUser withRetweets:(BOOL)aWithReetweets tweetsCount:(NSInteger)aTweetsCount finishCallbackBlock:(DXSocialPostsCallbackBlock)aCallbackBlock;

+ (void)getWeiboTimelineForUserID:(long long)aUserID withCallbackBlock:(DXSocialPostsCallbackBlock)aCallbackBlock;

@end
