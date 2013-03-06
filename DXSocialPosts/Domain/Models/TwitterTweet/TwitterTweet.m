//
//  TwitterTweet.m
//  DXSocialPosts
//
//  Created by TheSooth on 2/12/13.
//  Copyright (c) 2013 TheSooth. All rights reserved.
//

#import "TwitterTweet.h"

@implementation TwitterTweet

- (NSString *)description
{
    NSString *description = [NSString stringWithFormat:@"userScreenName =%@\ntweetDate = %@\ntweetText = %@\nrelativeDateString = %@",
                             self.userScreenName, self.tweetDate, self.tweetText, self.relativeDateString];
    
    return description;
}

@end
