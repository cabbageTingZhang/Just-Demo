//
//  MOCustomTabBarView.h
//  MiMoLive
//
//  Created by MiMo on 2025/6/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MOCustomTabBarViewDelegate <NSObject>
- (void)customTabBarDidSelectIndex:(NSInteger)index;
@end

@interface MOCustomTabBarView : UIView

@property (nonatomic, weak) id<MOCustomTabBarViewDelegate> delegate;
/** 未读数 (只有在聊天VC在一级界面的时候才有) */
@property (nonatomic, copy) NSString *badgeValue;

- (void)setSelectedIndex:(NSInteger)index;

- (void)setIMUnreadMsgCount:(NSString *)badgeString;

@end

NS_ASSUME_NONNULL_END
