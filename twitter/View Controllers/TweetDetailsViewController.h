//
//  TweetDetailsViewController.h
//  twitter
//
//  Created by Andrea Gonzalez on 6/22/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TweetDetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *detailFavoriteButton;
@property (weak, nonatomic) IBOutlet UIButton *detailRetweetButton;

@property (weak, nonatomic) IBOutlet UILabel *detailFavoriteNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailRetweetNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailTweetDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailTweetTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailUserNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailFullNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *detailProfileImage;

@end

NS_ASSUME_NONNULL_END
