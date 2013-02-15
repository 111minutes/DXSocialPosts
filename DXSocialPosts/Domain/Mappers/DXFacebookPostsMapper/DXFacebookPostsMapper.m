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
    
    [aContent stringByMatchingRegularExpressionPattern:@"(?:url=)+http[^\\s\"]+" finishBlock:^(NSString *string) {
        NSString *imageURLString = nil;
        
        if (string) {
            NSString *imageURLDecodedLink = [string stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            imageURLString = [imageURLDecodedLink stringByReplacingCharactersInRange:NSMakeRange(0, 4) withString:@""];
        }
        
        [self mapImageURL:imageURLString toModel:aModel];
    }];
}

#pragma mark -
#pragma mark - Image mapping

- (void)mapImageURL:(NSString *)aImageURLString toModel:(FacebookPost *)aModel
{
    if (aImageURLString) {
        aModel.imageLink = aImageURLString;
    } else {
        [self mapDefaultUserAvatarToModel:aModel avatarType:FacebookAvatarTypes.large];
    }
}

- (void)mapDefaultUserAvatarToModel:(FacebookPost *)aModel avatarType:(NSString *)aAvatarType
{
    
    NSString *imageURLString = [ServicesURL.facebookApiURL stringByAppendingFormat:@"/%llu/picture?type=%@",self.facebookUserID,aAvatarType];
    
    aModel.imageLink = imageURLString;
}

@end
