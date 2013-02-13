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
    __weak typeof(aModel) weakModel = aModel;
    
    NSMutableArray *avatarPathsComponents = [[aModel.userAvatarURL pathComponents] mutableCopy];
    [avatarPathsComponents setObject:aSize atIndexedSubscript:avatarSizePathComponentIndex];
    
    NSString *avatarURL = [avatarPathsComponents componentsJoinedByString:@"//"];
    
    
    [DXDownloader downloadObjectAtURLPath:avatarURL finishCallbackBlock:^(id aObject) {
        NSString *avatarName = [NSString stringWithFormat:@"%@_%@", weakModel.userScreenName, aSize];
        weakModel.localUserAvatarPath = [[DXCacheStorage shared] saveWeiboImageDataToCache:aObject withName:avatarName];
    }];
}

@end
