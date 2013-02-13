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
        
        tweet.userID = [twitterUserDict valueForKey:@"id"];
        tweet.userScreenName = [twitterUserDict valueForKey:@"screen_name"];
        tweet.userAvatarURL = [twitterUserDict valueForKey:@"profile_image_url"];
        
        [self additionalMappingToModel:tweet];
        
        [tweetsArray addObject:tweet];
    }
    
    return tweetsArray;
}

- (void)additionalMappingToModel:(id)aModel
{
    [self mapUserAvatarToModel:aModel withSize:TwitterAvatarSizes.bigger];
}

- (NSDate *)dateFromString:(NSString *)aString
{
   return [[DXDateFormatter shared] dateFromString:aString dateFormat:@"EEE MMM d HH:mm:ss Z y"];
}

- (void)mapUserAvatarToModel:(TwitterTweet *)aModel withSize:(NSString *)aSize
{
    [DXDownloader downloadTwitterUserAvatarByScreenName:aModel.userScreenName avatarSize:aSize finishCallbackBlock:^(id aObject) {
        NSString *avatarName = [NSString stringWithFormat:@"%@_%@", aModel.userScreenName, aSize];
        aModel.localUserAvatarPath = [[DXCacheStorage shared] saveTwitterImageDataToCache:aObject withName:avatarName];
    }];
}

@end
