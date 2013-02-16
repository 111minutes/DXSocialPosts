//
//  DXSPRequest.h
//  DXSocialPosts
//
//  Created by TheSooth on 2/15/13.
//  Copyright (c) 2013 TheSooth. All rights reserved.
//

#import "DXDALRequestHTTP.h"
#import "DXSPMapper.h"

@interface DXSPRequest : DXDALRequestHTTP

@property (nonatomic, strong) id <DXSPMapper> spMapper;

@end
