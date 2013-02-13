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
    
    NSString *avatarName = [NSString stringWithFormat:@"%@_%@", aModel.userScreenName, aSize];
    
    NSString *avatarPath = [[DXCacheStorage shared] avatarPathForWeiboWithName:avatarName];
    
    if (avatarPath) {
        aModel.localUserAvatarPath = avatarPath;
    } else {
        NSString *avatarURLString = [self buildAvatarURLFromModel:aModel avatarSize:aSize];
        
        [self downloadAvatarAtPath:avatarURLString saveWithAvatarName:avatarName mapToModel:aModel];
    }
}

- (NSString *)buildAvatarURLFromModel:(WeiboTweet *)aModel avatarSize:(NSString *)aAvatarSize
{
    NSMutableArray *avatarPathsComponents = [[aModel.userAvatarURL pathComponents] mutableCopy];
    [avatarPathsComponents setObject:aAvatarSize atIndexedSubscript:avatarSizePathComponentIndex];
    
    NSString *avatarURL = [avatarPathsComponents componentsJoinedByString:@"//"];
    
    return avatarURL;
}

- (void)downloadAvatarAtPath:(NSString *)aAvatarPath saveWithAvatarName:(NSString *)aName mapToModel:(WeiboTweet *)aModel
{
    __weak typeof(aModel) weakModel;
    
    [DXDownloader downloadObjectAtURLPath:aAvatarPath finishCallbackBlock:^(id aObject) {
        weakModel.localUserAvatarPath = [[DXCacheStorage shared] saveWeiboImageDataToCache:aObject withName:aName];
    }];
}

@end
