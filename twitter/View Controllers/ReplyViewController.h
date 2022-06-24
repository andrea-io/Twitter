//
//  ReplyViewController.h
//  twitter
//
//  Created by Andrea Gonzalez on 6/24/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ReplyViewControllerDelegate
@end

@interface ReplyViewController : UIViewController
@property (nonatomic, strong) Tweet *detailDict;
@property (nonatomic, weak) id<ReplyViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
