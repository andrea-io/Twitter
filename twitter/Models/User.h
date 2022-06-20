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

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *screenName;
@property (nonatomic, strong) NSString *profilePicture;

// TODO: Create initializer

@end

NS_ASSUME_NONNULL_END
