//
//  ProfileViewController.h
//  twitter
//
//  Created by Andrea Gonzalez on 6/24/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
NS_ASSUME_NONNULL_BEGIN

@interface ProfileViewController : UIViewController
@property (nonatomic, strong) User *detailDict;
@property (weak, nonatomic) IBOutlet UILabel *profileFollowersLabel;
@property (weak, nonatomic) IBOutlet UILabel *profileFollowingLabel;

@property (weak, nonatomic) IBOutlet UILabel *profileFollowersCount;
@property (weak, nonatomic) IBOutlet UILabel *profileFollowingCount;

@property (weak, nonatomic) IBOutlet UILabel *profileTagLine;
@property (weak, nonatomic) IBOutlet UILabel *profileUserName;
@property (weak, nonatomic) IBOutlet UILabel *profileFullName;
@property (weak, nonatomic) IBOutlet UIImageView *profileViewProfilePic;

@end

NS_ASSUME_NONNULL_END
