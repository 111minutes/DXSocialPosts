//
//  DXCacheStorage.h
//  DXSocialPosts
//
//  Created by TheSooth on 2/11/13.
//  Copyright (c) 2013 TheSooth. All rights reserved.
//

@interface DXCacheStorage : NSObject <DXSingleton>

- (NSString *)avatarPathForFacebookUserID:(long long)aUserID;

- (NSString *)saveFacebookImageDataCache:(id)aImageData withName:(NSString *)aName;
- (NSString *)saveTwitterImageDataToCache:(id)aImageData withName:(NSString *)aName;
- (NSString *)saveWeiboImageDataToCache:(id)aImageData withName:(NSString *)aName;

@end
