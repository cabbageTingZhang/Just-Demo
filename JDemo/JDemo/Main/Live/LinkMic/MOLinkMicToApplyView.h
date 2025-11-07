//
//  MOLinkMicToApplyView.h
//  MiMoLive
//
//  Created by SuperC on 2025/8/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MOLinkMicToApplyView : UIView

@property (nonatomic, copy) MOUserProfile *anchorInfo;//主播信息
@property (nonatomic, copy) NSString *titleStr;//标题
@property (nonatomic, strong) MORtmEntity *entity;

@property (nonatomic, copy) void (^acceptBtnBlock)(void);
@property (nonatomic, copy) void (^viewDismissBlock)(void);

/** 拒绝按钮点击 */
@property (nonatomic, copy) void (^rejectBtnBtnBlock)(void);
/** 超时 */
@property (nonatomic, copy) void (^timeOutBlock)(void);

/// 1秒触发一次
- (void)oneSecondPassed;

- (void)showLinkMicToApplyView;
- (void)dismissLinkMicToApplyView;

@end

NS_ASSUME_NONNULL_END
