//
//  DXCacheStorage.m
//  DXSocialPosts
//
//  Created by TheSooth on 2/11/13.
//  Copyright (c) 2013 TheSooth. All rights reserved.
//

#import "DXCacheStorage.h"

@interface DXCacheStorage ()

@property (nonatomic, strong) NSFileManager *fileManager;
@property (nonatomic, strong) NSString *cacheDirectory;

@property (nonatomic, strong) NSString *facebookAvatarsCacheDirectory;
@property (nonatomic, strong) NSString *twitterAvatarsCacheDirectory;
@property (nonatomic, strong) NSString *weiboAvatarsCacheDirectory;

@end

@implementation DXCacheStorage

- (id)init
{
    self = [super init];
    if (self) {
        self.fileManager = [NSFileManager defaultManager];
        self.cacheDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
        self.facebookAvatarsCacheDirectory = [self.cacheDirectory stringByAppendingPathComponent:Paths.facebookImagesDir];
        self.twitterAvatarsCacheDirectory = [self.cacheDirectory stringByAppendingPathComponent:Paths.twitterUserAvatarsDir];
        self.weiboAvatarsCacheDirectory = [self.cacheDirectory stringByAppendingPathComponent:Paths.weiboUserAvatarDir];
    }
    
    return self;
}

- (NSString *)saveFacebookImageDataCache:(id)aImageData withName:(NSString *)aName
{
    NSString *filePath =  [self saveObject:aImageData atPath:self.facebookAvatarsCacheDirectory withName:aName];
    
    return filePath;
}

- (NSString *)avatarPathForFacebookUserID:(long long)aUserID
{
    NSString *filePath = [self.facebookAvatarsCacheDirectory stringByAppendingFormat:@"/%llu", aUserID];
    
    if ([self.fileManager fileExistsAtPath:filePath]) {
        return filePath;
    }
    
    return nil;
}

- (NSString *)saveTwitterImageDataToCache:(id)aImageData withName:(NSString *)aName
{
    NSString *filePath = [self saveObject:aImageData atPath:self.twitterAvatarsCacheDirectory withName:aName];
    
    return filePath;
}

- (NSString *)saveWeiboImageDataToCache:(id)aImageData withName:(NSString *)aName
{
    NSString *filePath = [self saveObject:aImageData atPath:self.weiboAvatarsCacheDirectory withName:aName];
    
    return filePath;
}

- (NSString *)saveObject:(id)aObject atPath:(NSString *)aPath withName:(NSString *)aObjectName
{
    BOOL isDir = NO;
    
    if (![self.fileManager fileExistsAtPath:aPath isDirectory:&isDir] && isDir == NO) {
        [self.fileManager createDirectoryAtPath:aPath withIntermediateDirectories:NO attributes:nil error:nil];
    }
    
    NSString *filePath = [aPath stringByAppendingPathComponent:aObjectName];
    
    BOOL fileIsCreated = [self.fileManager createFileAtPath:filePath contents:aObject attributes:nil];
    if (fileIsCreated) {
        return filePath;
    }
    
    return nil;
}

@end
