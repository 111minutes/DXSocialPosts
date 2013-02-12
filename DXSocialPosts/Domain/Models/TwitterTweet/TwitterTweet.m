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
    NSString *description = [NSString stringWithFormat:@"tweetDate = %@\ntweetText = %@\nuserAvatarURL = %@\nlocalUserAvatarPath = %@",
                             self.tweetDate, self.tweetText, self.userAvatarURL, self.localUserAvatarPath];
    
    return description;
}

@end
