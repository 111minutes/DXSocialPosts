//
//  DXSocialPostsFacebookFeedSpec.m
//  DXSocialPosts
//
//  Created by TheSooth on 1/30/13.
//  Copyright (c) 2013 TheSooth. All rights reserved.
//


SPEC_BEGIN(FacebookFeedPostsSpec)

describe(@"Facebook Feed API", ^{
    it(@"should get feed of user", ^{
        long long powerIntegrationFacebookUserID = 116882680454;
        
        __block NSString *receivedTitle;
        NSString *powerIntegrationWallTitle = @"Power Integrations's Facebook Wall";
        
        [DXSocialPosts getFacebookFeedPostsForUserID:powerIntegrationFacebookUserID withCallbackBlock:^(id response) {
            receivedTitle = [response objectForKey:@"title"];
        }];
        
        [[expectFutureValue(receivedTitle) shouldEventuallyBeforeTimingOutAfter(3.0)] equal:powerIntegrationWallTitle];
    });
});

SPEC_END