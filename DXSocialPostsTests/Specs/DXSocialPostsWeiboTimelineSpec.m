//
//  DXSocialPostsWeiboTimelineSpec.m
//  DXSocialPosts
//
//  Created by TheSooth on 1/30/13.
//  Copyright (c) 2013 TheSooth. All rights reserved.
//

SPEC_BEGIN(WeiboTimelineSpec)

describe(@"Weibo API", ^{
    it(@"should get timeline of user", ^{
        __block id fetchedData = nil;
        
        NSUInteger userID = 2517184481;
        
        NSString *name = @"PI中国";
        
        __block NSString *receivedName = nil;
        
        [DXSocialPosts getWeiboTimelineForUserID:userID withCallbackBlock:^(id response) {
            id firstPost = response[0];
            id userDictionary = [firstPost objectForKey:@"user"];
            receivedName = [userDictionary objectForKey:@"name"];
            
            fetchedData = response;
        }];
        
        [[expectFutureValue(receivedName) shouldEventuallyBeforeTimingOutAfter(10.0)] equal:name];
    });
});

SPEC_END