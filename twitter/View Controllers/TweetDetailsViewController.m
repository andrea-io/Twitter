//
//  TweetDetailsViewController.m
//  twitter
//
//  Created by Andrea Gonzalez on 6/22/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

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
@interface TweetDetailsViewController ()

@end

@implementation TweetDetailsViewController

- (IBAction)tapDetailFavoriteButton:(id)sender {
    
}

- (IBAction)tapDetailRetweetButton:(id)sender {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Get timeline
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            self.detailDict = [[NSMutableArray alloc] init];
            for (Tweet *tweet in tweets) {
                //NSLog(@"%@", tweetText);
                [self.detailDict addObject:tweet];
            }
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)detailRetweetButton:(id)sender {
}
@end
