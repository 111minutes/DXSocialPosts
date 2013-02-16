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

- (void)mapFromInputData:(id)aData entityClass:(Class)aEntityClass finishCallbackBlock:(void (^)(id))aFinishCallbackBlock
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableArray *facebookPostsArray = [NSMutableArray new];
        
        NSArray *entries = [aData objectForKey:@"entries"];
        
        for (NSDictionary *postDictionary in entries) {
            
            NSString *content = [postDictionary valueForKey:@"content"];
            
            FacebookPost *post = [FacebookPost new];
            
            [self mapTitleFromContent:content toModel:post];
            [self mapSharedLinkFromContent:content toModel:post];
            [self mapPostFromContent:content toModel:post];
            [self mapImageURLFromContent:content toModel:post];
            
            [facebookPostsArray addObject:post];
        }
        
        if(aFinishCallbackBlock) {
            aFinishCallbackBlock(facebookPostsArray);
        }
    });
}

- (void)mapTitleFromContent:(NSString *)aContent toModel:(FacebookPost *)aModel
{
#warning Need to make a "right" regular pattern
    
    NSString *title = [aContent stringByMatchingRegularExpressionPattern:@">+[^<>]+"];
    aModel.title = [title stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@""];
}

- (void)mapSharedLinkFromContent:(NSString *)aContent toModel:(FacebookPost *)aModel
{
    NSString *encodedURLLink = [aContent stringByMatchingRegularExpressionPattern:@"http%[\\S]+?[^&\\s]+"];
    NSString *decodedURLLink = [encodedURLLink stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
    aModel.sharedLink = decodedURLLink;
}

- (void)mapPostFromContent:(NSString *)aContent toModel:(FacebookPost *)aModel
{
    aModel.postText = [aContent stringByMatchingRegularExpressionPattern:@"[^</>]+$"];
}

- (void)mapImageURLFromContent:(NSString *)aContent toModel:(FacebookPost *)aModel
{
#warning Need to make a "right" regular pattern
    
    NSString *imageURLString = [aContent stringByMatchingRegularExpressionPattern:@"(?:url=)+http[^\\s\"]+"];
        
        if (imageURLString) {
            NSString *imageURLDecodedLink = [imageURLString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            imageURLString = [imageURLDecodedLink stringByReplacingCharactersInRange:NSMakeRange(0, 4) withString:@""];
            aModel.imageLink = imageURLString;
        } else {
            [self mapDefaultUserAvatarToModel:aModel avatarType:FacebookAvatarTypes.large];
        }
}

#pragma mark -
#pragma mark - Image mapping

- (void)mapDefaultUserAvatarToModel:(FacebookPost *)aModel avatarType:(NSString *)aAvatarType
{
    
    NSString *imageURLString = [ServicesURL.facebookApiURL stringByAppendingFormat:@"/%llu/picture?type=%@",self.facebookUserID,aAvatarType];
    
    aModel.imageLink = imageURLString;
}

@end
