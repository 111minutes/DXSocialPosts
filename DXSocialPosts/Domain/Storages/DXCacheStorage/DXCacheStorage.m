//
//  DXCacheStorage.m
//  DXSocialPosts
//
//  Created by TheSooth on 2/11/13.
//  Copyright (c) 2013 TheSooth. All rights reserved.
//

#import "DXCacheStorage.h"

@implementation DXCacheStorage

+ (NSString *)saveObjectToCache:(id)aObject withName:(NSString *)aName
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *cacheDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *documentsCacheDirectory = [cacheDirectory stringByAppendingPathComponent:@"NewsImages"];
    
    NSString *filePath = [documentsCacheDirectory stringByAppendingPathComponent:aName];
    
    BOOL isDir = NO;
    
    if (![fileManager fileExistsAtPath:documentsCacheDirectory isDirectory:&isDir] && isDir == NO) {
        [fileManager createDirectoryAtPath:documentsCacheDirectory withIntermediateDirectories:NO attributes:nil error:nil];
    }
    
    [fileManager createFileAtPath:filePath contents:aObject attributes:nil];
    
    return filePath;
}

+ (NSString *)avatarPathForFacebookUserID:(long long)aUserID
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *cacheDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *documentsCacheDirectory = [cacheDirectory stringByAppendingPathComponent:@"NewsImages"];
    
    NSString *filePath = [documentsCacheDirectory stringByAppendingFormat:@"/%llu", aUserID];
    
    if ([fileManager fileExistsAtPath:filePath]) {
        return filePath;
    }
    
    return nil;
}

@end
