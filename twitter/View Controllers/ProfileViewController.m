//
//  ProfileViewController.m
//  twitter
//
//  Created by Andrea Gonzalez on 6/24/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "ProfileViewController.h"
#import "TweetDetailsViewController.h"
#import "TimelineViewController.h"
#import "APIManager.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "UIImageView+AFNetworking.h"
#import "ComposeViewController.h"

#import "TweetCell.h"
#import "Tweet.h"
#import "User.h"
#import "DateTools.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Set up all text labels (Full name, tweet text, username)
    self.profileFullName.text = self.detailDict.name;
    //self.profileUserName.text = [@"@" stringByAppendingString:self.detailDict.screenName];

    // Generate URL and URL data for profile image
    NSString *URLString = self.detailDict.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    NSData *urlData = [NSData dataWithContentsOfURL:url];

    // Assign URL data to profile image
    self.profileViewProfilePic.image = nil;
    self.profileViewProfilePic.image = [UIImage imageWithData:urlData];
    self.profileFollowersCount.text = self.detailDict.followers;
    self.profileFollowingCount.text = self.detailDict.following;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
