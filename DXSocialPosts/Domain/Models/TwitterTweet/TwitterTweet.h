//
//  TwitterTweet.h
//  DXSocialPosts
//
//  Created by TheSooth on 2/12/13.
//  Copyright (c) 2013 TheSooth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TwitterTweet : NSObject

@property (nonatomic, strong) NSDate *tweetDate;
@property (nonatomic, strong) NSString *relativeDateString;
@property (nonatomic, strong) NSString *tweetText;

@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString *userScreenName;
@property (nonatomic, strong) NSString *userAvatarURL;

@end
