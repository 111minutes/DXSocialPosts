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
        
        NSUInteger userID = 2517184481;
        
        NSString *name = @"PI中国";
        
        __block NSString *receivedName = nil;
        
        [DXSocialPosts getWeiboTimelineForUserID:userID tweetsCount:5 withCallbackBlock:^(id response) {
            receivedName = [response[0] valueForKey:@"userScreenName"];
        }];
        
        [[expectFutureValue(receivedName) shouldEventuallyBeforeTimingOutAfter(10.0)] equal:name];
    });
});

SPEC_END