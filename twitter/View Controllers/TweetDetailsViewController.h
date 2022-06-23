//
//  TweetDetailsViewController.h
//  twitter
//
//  Created by Andrea Gonzalez on 6/22/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@protocol TweetDetailViewControllerDelegate
@end

@interface TweetDetailsViewController : UIViewController
@property (nonatomic, strong) Tweet *detailDict;
@property (weak, nonatomic) IBOutlet UIButton *detailFavoriteButton;
@property (weak, nonatomic) IBOutlet UIButton *detailRetweetButton;

@property (weak, nonatomic) IBOutlet UILabel *detailFavoriteNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailRetweetNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailTweetDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailTweetTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailUserNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailFullNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *detailProfileImage;
@property (nonatomic, weak) id<TweetDetailViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
