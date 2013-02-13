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
        id tweet = [mappingClass new];
        
        NSString *tweetDateString = [tweetDict valueForKey:@"created_at"];
        NSDictionary *twitterUserDict = [tweetDict valueForKey:@"user"];
        
        [tweet setValue:[self dateFromString:tweetDateString] forKey:@"tweetDate"];
        [tweet setValue:[tweetDict valueForKey:@"text"] forKey:@"tweetText"];
        
        [tweet setValue:[twitterUserDict valueForKey:@"id"] forKey:@"userID"];
        [tweet setValue:[twitterUserDict valueForKey:@"screen_name"] forKey:@"userScreenName"];
        [tweet setValue:[twitterUserDict valueForKey:@"profile_image_url"] forKey:@"userAvatarURL"];
        
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
    NSString *avatarName = [NSString stringWithFormat:@"%@_%@", aModel.userScreenName, aSize];
    
    NSString *avatarPath = [[DXCacheStorage shared] avatarPathForTwitterWithName:avatarName];
    
    if (avatarPath) {
        aModel.localUserAvatarPath = avatarPath;
    } else {
        [DXDownloader downloadTwitterUserAvatarByScreenName:aModel.userScreenName avatarSize:aSize finishCallbackBlock:^(id aObject) {
            aModel.localUserAvatarPath = [[DXCacheStorage shared] saveTwitterImageDataToCache:aObject withName:avatarName];
        }];
    }
}

@end
