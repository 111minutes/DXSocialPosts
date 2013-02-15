//
//  DXFacebookPostsMapper.m
//  DXSocialPosts
//
//  Created by TheSooth on 2/10/13.
//  Copyright (c) 2013 TheSooth. All rights reserved.
//

#import "NSString+RegularExpression.h"

#import "DXFacebookPostsMapper.h"
#import "DXDownloader.h"
#import "DXCacheStorage.h"

#import "FacebookPost.h"

@interface DXFacebookPostsMapper ()

@property (nonatomic) long long facebookUserID;

@end

@implementation DXFacebookPostsMapper

- (id)initWithFacebookUserID:(long long)aFacebookUserID
{
    self = [super init];
    if (self) {
        self.facebookUserID = aFacebookUserID;
    }
    
    return self;
}

- (id)mapFromInputData:(id)inputData withClass:(Class)mappingClass
{
    NSMutableArray *facebookPostsArray = [NSMutableArray new];
    
    NSArray *entries = [inputData objectForKey:@"entries"];
    
    for (NSDictionary *postDictionary in entries) {
        
        NSString *content = [postDictionary valueForKey:@"content"];
        
        FacebookPost *post = [FacebookPost new];
        
        [self mapTitleFromContent:content toModel:post];
        
        [self mapSharedLinkFromContent:content toModel:post];
        [self mapPostFromContent:content toModel:post];
        [self mapImageURLFromContent:content toModel:post];
        
        [self mapImageToModel:post];
        
        [facebookPostsArray addObject:post];
    }
    
    return facebookPostsArray;
}

- (void)mapTitleFromContent:(NSString *)aContent toModel:(FacebookPost *)aModel
{
#warning Need to make a "right" regular pattern
    [aContent stringByMatchingRegularExpressionPattern:@">+[^<>]+" finishBlock:^(NSString *string) {
        aModel.title = [string stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@""];
    }];
}

- (void)mapSharedLinkFromContent:(NSString *)aContent toModel:(FacebookPost *)aModel
{
    [aContent stringByMatchingRegularExpressionPattern:@"http%[\\S]+?[^&\\s]+" finishBlock:^(NSString *string) {
        NSString *decodedURLLink = [string stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        aModel.sharedLink = decodedURLLink;
    }];
}

- (void)mapPostFromContent:(NSString *)aContent toModel:(FacebookPost *)aModel
{
    [aContent stringByMatchingRegularExpressionPattern:@"[^</>]+$" finishBlock:^(NSString *string) {
        aModel.postText = string;
    }];
}

- (void)mapImageURLFromContent:(NSString *)aContent toModel:(FacebookPost *)aModel
{
#warning Need to make a "right" regular pattern
    
    [aContent stringByMatchingRegularExpressionPattern:@"?:url=)+http[^\\s\"]+" finishBlock:^(NSString *string) {
        NSString *imageURLString = nil;
        if (string) {
            NSString *imageURLDecodedLink = [string stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            imageURLString = [imageURLDecodedLink stringByReplacingCharactersInRange:NSMakeRange(0, 4) withString:@""];
        }
        aModel.imageLink = imageURLString;
    }];
}

#pragma mark - 
#pragma mark - Image mapping

- (void)mapImageToModel:(FacebookPost *)aModel
{
    if (aModel.imageLink) {
        [self downloadImageAndMapToModel:aModel];
    } else {
        [self mapDefaultUserAvatarToModel:aModel];
    }
}

- (void)downloadImageAndMapToModel:(FacebookPost *)aModel
{
    [DXDownloader downloadObjectAtURLPath:aModel.imageLink finishCallbackBlock:^(id aObject) {
        if (![aObject isKindOfClass:[NSError class]]) {
            aModel.localImagePath = [[DXCacheStorage shared] saveFacebookImageDataCache:aObject
                                                                               withName:aModel.imageLink.lastPathComponent];
        }
    }];
}

- (void)mapDefaultUserAvatarToModel:(FacebookPost *)aModel
{
    NSString *avatarPath = [[DXCacheStorage shared] avatarPathForFacebookUserID:self.facebookUserID];
    if (avatarPath) {
        aModel.localImagePath = avatarPath;
    } else {
        [DXDownloader downloadFacebookUserAvatarByID:self.facebookUserID avatarType:FacebookAvatarTypes.large finishCallbackBlock:^(id aObject) {
            aModel.localImagePath = [[DXCacheStorage shared] saveFacebookImageDataCache:aObject
                                                                               withName:[NSString stringWithFormat:@"%llu", self.facebookUserID]];
        }];
    }
}

@end
