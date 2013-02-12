//
//  DXTwitterTweetMapper.m
//  DXSocialPosts
//
//  Created by TheSooth on 2/12/13.
//  Copyright (c) 2013 TheSooth. All rights reserved.
//
#import <DXDateFormatter.h>

#import "DXTwitterTweetMapper.h"
#import "TwitterTweet.h"

#import "DXDownloader.h"
#import "DXCacheStorage.h"

@implementation DXTwitterTweetMapper

- (id)mapFromInputData:(id)inputData withClass:(Class)mappingClass
{
    NSMutableArray *tweetsArray = [NSMutableArray new];
    
    for (NSDictionary *tweetDict in inputData) {
        TwitterTweet *tweet = [TwitterTweet new];
        
        NSString *tweetDateString = [tweetDict valueForKey:@"created_at"];
        NSDictionary *twitterUserDict = [tweetDict valueForKey:@"user"];
        
        tweet.tweetDate = [self dateFromString:tweetDateString];
        tweet.tweetText = [tweetDict valueForKey:@"text"];
        tweet.userAvatarURL = [twitterUserDict valueForKey:@"profile_image_url"];
        
        [self mapUserAvatarToModel:tweet];
        
        [tweetsArray addObject:tweet];
    }
    
    return tweetsArray;
}

- (NSDate *)dateFromString:(NSString *)aString
{
   return [[DXDateFormatter shared] dateFromString:aString dateFormat:@"EEE MMM d HH:mm:ss Z y"];
}

- (void)mapUserAvatarToModel:(TwitterTweet *)aModel
{
    if (aModel.userAvatarURL) {
        [DXDownloader downloadObjectAtURLPath:aModel.userAvatarURL finishCallbackBlock:^(id aObject) {
           aModel.localUserAvatarPath = [[DXCacheStorage shared] saveTwitterImageDataToCache:aObject withName:aModel.userAvatarURL.lastPathComponent];
        }];
    }
}

@end
