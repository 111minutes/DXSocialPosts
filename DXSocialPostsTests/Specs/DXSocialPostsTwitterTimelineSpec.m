//
//  DXSocialPostsTwitterTimelineSpec.m
//  DXSocialPosts
//
//  Created by TheSooth on 1/30/13.
//  Copyright (c) 2013 TheSooth. All rights reserved.
//

SPEC_BEGIN(TwitterTimelineSpec)

describe(@"Twitter API", ^{
    it(@"should get timeline of user", ^{
        __block id fetchedData = nil;
        
        NSString *screenName = @"PwrInt";
        NSString *name = @"Power Integrations";
        
        __block NSString *receivedName = nil;
        
        [DXSocialPosts getTwitterTimelineForUser:screenName withCallbackBlock:^(id response) {
            id firstPost = response[0];
            id userDictionary = [firstPost objectForKey:@"user"];
            receivedName = [userDictionary objectForKey:@"name"];
            
            fetchedData = response;
        }];
        
        [[expectFutureValue(receivedName) shouldEventuallyBeforeTimingOutAfter(3.0)] equal:name];
    });
});

SPEC_END