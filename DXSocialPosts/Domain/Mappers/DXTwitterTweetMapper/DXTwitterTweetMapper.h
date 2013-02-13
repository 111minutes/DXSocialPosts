//
//  DXTwitterTweetMapper.h
//  DXSocialPosts
//
//  Created by TheSooth on 2/12/13.
//  Copyright (c) 2013 TheSooth. All rights reserved.
//

#import "DXDownloader.h"
#import "DXCacheStorage.h"

@interface DXTwitterTweetMapper : NSObject <DXDALMapper>

- (void)additionalMappingToModel:(id)aModel;

@end
