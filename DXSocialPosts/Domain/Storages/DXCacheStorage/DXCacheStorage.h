//
//  DXCacheStorage.h
//  DXSocialPosts
//
//  Created by TheSooth on 2/11/13.
//  Copyright (c) 2013 TheSooth. All rights reserved.
//

@interface DXCacheStorage : NSObject

+ (NSString *)saveObjectToCache:(id)aObject withName:(NSString *)aName;

@end
