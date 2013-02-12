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
        NSString *screenName = @"PwrInt";
        
        __block NSString *receivedTweetPost = nil;
        
        [DXSocialPosts getTwitterTimelineRequestForUser:screenName withRetweets:NO tweetsCount:5 finishCallbackBlock:^(id response) {
            receivedTweetPost = [response[0] valueForKey:@"tweetText"];
        }];
        
        [[expectFutureValue(receivedTweetPost) shouldEventuallyBeforeTimingOutAfter(3.0)] shouldNotBeNil];
    });
});

SPEC_END