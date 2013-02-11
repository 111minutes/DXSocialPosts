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

@end

@implementation DXCacheStorage

- (id)init
{
    self = [super init];
    if (self) {
        self.fileManager = [NSFileManager defaultManager];
        self.cacheDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        self.facebookAvatarsCacheDirectory = [self.cacheDirectory stringByAppendingPathComponent:Paths.facebookImagesDir];
    }
    
    return self;
}

- (NSString *)saveFacebookImageDataCache:(id)aImageData withName:(NSString *)aName
{
    NSString *filePath = [self.facebookAvatarsCacheDirectory stringByAppendingPathComponent:aName];
    
    BOOL isDir = NO;
    
    if (![self.fileManager fileExistsAtPath:self.facebookAvatarsCacheDirectory isDirectory:&isDir] && isDir == NO) {
        [self.fileManager createDirectoryAtPath:self.facebookAvatarsCacheDirectory withIntermediateDirectories:NO attributes:nil error:nil];
    }
    
    [self.fileManager createFileAtPath:filePath contents:aImageData attributes:nil];
    
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

@end
