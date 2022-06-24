//
//  User.h
//  twitter
//
//  Created by Andrea Gonzalez on 6/20/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject

// TODO: Add properties

// Properties needed for displaying a User
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *screenName;
@property (nonatomic, strong) NSString *profilePicture;
@property (nonatomic, strong) NSString *tagLine;
@property (nonatomic, strong) NSString *followers;
@property (nonatomic, strong) NSString *following;

// TODO: Create initializer

// Initializer that can set all the User properties based on the dictionary.
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
