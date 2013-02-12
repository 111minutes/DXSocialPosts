//
//  DXSocialPosts.m
//  DXSocialPosts
//
//  Created by TheSooth on 1/30/13.
//  Copyright (c) 2013 TheSooth. All rights reserved.
//

#import "DXSocialPosts.h"

#import "DXFacebookFeedRequestFactory.h"
#import "DXTwitterTimelineRequestFactory.h"
#import "DXWeiboTimelineRequestFactory.h"

@implementation DXSocialPosts

+ (void)getFacebookFeedPostsForUserID:(long long)aUserID withCallbackBlock:(DXSocialPostsCallbackBlock)aCallBackBlock
{
    DXDALRequest *getFacebookFeedPostsRequest = [self getFaceookFeedPostsRequestForUserID:aUserID
                                                                           responseFormat:ResponseFormats.json];
    
    [getFacebookFeedPostsRequest addSuccessHandler:^(id response) {
        if (aCallBackBlock) {
            aCallBackBlock(response);
        }
    }];
    
    [getFacebookFeedPostsRequest addErrorHandler:^(NSError *error) {
        if (aCallBackBlock) {
            aCallBackBlock(error);
        }
    }];
    
    [getFacebookFeedPostsRequest start];
}

+ (void)getTwitterTimelineRequestForUser:(NSString *)aUser withRetweets:(BOOL)aWithReetweets tweetsCount:(NSInteger)aTweetsCount finishCallbackBlock:(DXSocialPostsCallbackBlock)aCallbackBlock
{
    DXDALRequest *getTwitterTimelineRequest = [self getTwitterTimelineRequestForUser:aUser
                                                                        withRetweets:aWithReetweets
                                                                         tweetsCount:aTweetsCount
                                                                      responseFormat:ResponseFormats.json];
    
    [getTwitterTimelineRequest addSuccessHandler:^(id response) {
        if (aCallbackBlock) {
            aCallbackBlock(response);
        }
    }];
    
    [getTwitterTimelineRequest addErrorHandler:^(NSError *error) {
        if (aCallbackBlock) {
            aCallbackBlock(error);
        }
    }];
    
    [getTwitterTimelineRequest start];
}

+ (void)getWeiboTimelineForUserID:(long long)aUserID withCallbackBlock:(DXSocialPostsCallbackBlock)aCallbackBlock
{
    DXDALRequest *getWeiboTimelineRequest = [self getWeiboTimelineRequestForUserID:aUserID
                                                                    responseFormat:ResponseFormats.json
                                                                            appKey:AppKeys.weiboAppKey];
    
    [getWeiboTimelineRequest addSuccessHandler:^(id response) {
        if (aCallbackBlock) {
            aCallbackBlock(response);
        }
    }];
    
    [getWeiboTimelineRequest addErrorHandler:^(NSError *error) {
        if (aCallbackBlock) {
            aCallbackBlock(error);
        }
    }];
    
    [getWeiboTimelineRequest start];
}

#pragma mark - Requests

+ (DXDALRequest *)getFaceookFeedPostsRequestForUserID:(long long)aUserID responseFormat:(NSString *)aResponseFormat
{
    DXFacebookFeedRequestFactory *facebookFeedRequestFactory = [DXFacebookFeedRequestFactory shared];
    
    DXDALRequest *getFacebookFeedPostsRequest = [facebookFeedRequestFactory getFacebookFeedPostsForUserID:aUserID
                                                                                           responseFormat:aResponseFormat];
    
    return getFacebookFeedPostsRequest;
}

+ (DXDALRequest *)getTwitterTimelineRequestForUser:(NSString *)aUser withRetweets:(BOOL)aWithReetweets tweetsCount:(NSInteger)aTweetsCount responseFormat:(NSString *)aResponseFormat
{
    DXTwitterTimelineRequestFactory *twitterTimelineRequestFactory = [DXTwitterTimelineRequestFactory shared];
    
    DXDALRequest *twitterTimelineRequest = [twitterTimelineRequestFactory getTimelineForUser:aUser
                                                                                withRetweets:aWithReetweets
                                                                                 tweetsCount:aTweetsCount
                                                                              responseFormat:aResponseFormat];
    
    return twitterTimelineRequest;
}

+ (DXDALRequest *)getWeiboTimelineRequestForUserID:(long long)aUserID responseFormat:(NSString *)aResponseFormat appKey:(NSUInteger)aAppKey
{
    DXWeiboTimelineRequestFactory *weiboTimelineRequestFactory = [DXWeiboTimelineRequestFactory shared];
    
    DXDALRequest *weiboTimelineRequest = [weiboTimelineRequestFactory getTimelineForUserID:aUserID
                                                                            responseFormat:aResponseFormat
                                                                                    appKey:aAppKey];
    
    return weiboTimelineRequest;
}

@end
