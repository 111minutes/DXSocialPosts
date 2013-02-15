//
//  DXWeiboTweetMapper.m
//  DXSocialPosts
//
//  Created by TheSooth on 2/13/13.
//  Copyright (c) 2013 TheSooth. All rights reserved.
//

#import "DXWeiboTweetMapper.h"

#import "WeiboTweet.h"

#define avatarSizePathComponentIndex 3

@implementation DXWeiboTweetMapper

- (void)additionalMappingToModel:(id)aModel
{
    [self mapUserAvatarToModel:aModel withSize:WeiboAvatarSizes.large];
}

- (void)mapUserAvatarToModel:(WeiboTweet *)aModel withSize:(NSString *)aSize
{
    aModel.userAvatarURL = [self buildAvatarURLFromModel:aModel avatarSize:aSize];
}

- (NSString *)buildAvatarURLFromModel:(WeiboTweet *)aModel avatarSize:(NSString *)aAvatarSize
{
    NSMutableArray *avatarPathsComponents = [[aModel.userAvatarURL pathComponents] mutableCopy];
    [avatarPathsComponents setObject:aAvatarSize atIndexedSubscript:avatarSizePathComponentIndex];
    
    NSString *avatarURL = [avatarPathsComponents componentsJoinedByString:@"//"];
    
    return avatarURL;
}

@end
