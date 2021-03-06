//
//  User.m
//  twitter
//
//  Created by Andrea Gonzalez on 6/20/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "User.h"

@implementation User

// Initializer that can set all the User properties based on the dictionary.
- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];

    if(self) {
        self.name = dictionary[@"name"];
        self.screenName = dictionary[@"screen_name"];
        self.profilePicture = dictionary[@"profile_image_url_https"];
        self.tagLine = dictionary[@"description"];
        self.followers = dictionary[@"followers_count"];
        self.following = dictionary[@"friends_count"];
    }
    return self;
}

@end
