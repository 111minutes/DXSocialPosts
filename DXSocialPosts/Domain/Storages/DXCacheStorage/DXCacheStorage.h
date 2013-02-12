//
//  DXCacheStorage.h
//  DXSocialPosts
//
//  Created by TheSooth on 2/11/13.
//  Copyright (c) 2013 TheSooth. All rights reserved.
//

@interface DXCacheStorage : NSObject <DXSingleton>

- (NSString *)saveFacebookImageDataCache:(id)aImageData withName:(NSString *)aName;

- (NSString *)avatarPathForFacebookUserID:(long long)aUserID;

- (NSString *)saveTwitterImageDataToCache:(id)aImageData withName:(NSString *)aName;

@end
