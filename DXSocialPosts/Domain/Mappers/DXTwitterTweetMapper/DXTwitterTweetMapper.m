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
#import "SORelativeDateTransformer.h"

@implementation DXTwitterTweetMapper

- (id)mapFromInputData:(id)inputData withClass:(Class)mappingClass
{
    NSMutableArray *tweetsArray = [NSMutableArray new];
    SORelativeDateTransformer *transformer = [SORelativeDateTransformer new];
    
    [DXDateFormatter shared].locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    for (NSDictionary *tweetDict in inputData) {
        id tweet = [mappingClass new];
        
        NSString *tweetDateString = [tweetDict valueForKey:@"created_at"];
        NSDictionary *twitterUserDict = [tweetDict valueForKey:@"user"];
        
        NSDate *tweetDate = [self dateFromString:tweetDateString];
        
        [tweet setValue:tweetDate forKey:@"tweetDate"];
        [tweet setValue:[transformer transformedValue:tweetDate] forKey:@"relativeDateString"];
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
    return [[DXDateFormatter shared] dateFromString:aString dateFormat:@"ccc MMM dd HH:mm:ss Z yyyy"];
}

- (void)mapUserAvatarToModel:(TwitterTweet *)aModel withSize:(NSString *)aSize
{
    NSString *imageURLString = [ServicesURL.twitterApiURL stringByAppendingFormat:@"/1/users/profile_image?screen_name=%@&size=%@",
                                aModel.userScreenName, aSize];
    aModel.userAvatarURL = imageURLString;
}

@end
