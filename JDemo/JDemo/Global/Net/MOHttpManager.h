//
//  MOHttpManager.h
//  MiMoLive
//
//  Created by SuperC on 2023/10/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MOHttpManager : NSObject

/** 记录接口返回结果的缓存数据 */
@property (nonatomic,strong) NSMutableDictionary *responseCacheDict;

/// 单例初始化
+ (instancetype)sharedManager;

#pragma mark ----- public ------
/// 缓存接口返回数据
/// @param data 接口返回的responseData
/// @param key 根据接口url+参数构造的唯一key值，仅用于缓存标记
- (void)cacheApiData:(id)data key:(NSString *)key;

#pragma mark =========== Login ============

/// 用户引导信息 - 获取用户引导状态
/// result=引导状态，(0=无注册引导，1=进入编辑资料页面，2=进入关注主播页面)
- (void)getGuideWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 国家 - IP归属地
/// - Parameters:
///   - params: 参数
///   - block: 回调
-(void)getCountryIpithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 登录，手机 + 密码 - 登入
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)loginWithPwdWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 登录，手机验证码 - 登入
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)logineWithMobileWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 登录，手机验证码 - 获取手机验证码
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)loginAndGetMobileCodeWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 登录，Google - 登入
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)loginWithGoogleWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 登录，Facebook - 登入
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)logineWithFacebookWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 登录，Apple(苹果ID) - 登入
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)loginWithAppleWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 用户信息 - 信息设置
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toSettingInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 用户信息 - 随机昵称、随机头像
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)randomProfileWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 用户信息 - 随机昵称、随机头像(区分性别)
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheRandomProfileWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 用户登出 - 操作
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toLogoutWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 用户手机号码 - 新绑定手机号码
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)firstToBingCodeWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 用户手机号码 - 绑定手机号码 提交
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toBingAndSubmitWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 用户手机号码 - 密码重置 - 获取手机验证码
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetPassworkCodeWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 用户手机号码 - 密码重置 - 提交重置
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toResetPasswordWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 用户信息 - 加入粉丝团设置 开关
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toJoinFansClubWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 用户信息 - 删除用户
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toDeleteTheUserWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 用户信息 - 语言设置
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toSetLanguageWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 忘记密码-密码重置2 - 获取手机验证码
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetPasswordCode2WithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 忘记密码-密码重置2 - 检查手机验证码
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toVerifyTheSmsCodeWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 忘记密码-密码重置2 - 提交重置
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toResetThePassword2WithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

#pragma mark =========== Rank ============

/// 排行榜 - 贡献榜
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetRankOutcomeListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 排行榜 - 直播半小时榜单
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetRankHalfHourListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 排行榜 - 收益榜
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetRankIncomeListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 排行榜 - 直播间贡献榜
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetRankOutcomeRoomWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 排行榜 - PK榜
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetRankListAboutPkWeekWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 排行榜 - TOP的前3名用户信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheRankTopsWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 排行榜 - 用户贡献榜TOP的前3名用户信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetUserOutcomeTopsWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 排行榜 - 直播间嘉宾贡献榜
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheOutcomeAboutGuestWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 直播间热度排行榜
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetRoomHeatRankWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 直播间操作 - 音视频操作
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toOperationMediaAboutTheLiveWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 直播间 - 嘉宾连麦统计信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheLiveLinkMicGuestSummaryWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 直播间 - 房间观众恢复在线状态
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toRecoveryTheLiveWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 直播间 - 用户端 - 进入直播间且rtm已上线
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)reportRtmOnlineSuccessWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

#pragma mark =========== LiveRoom ============

/// 直播间相关 - 开启直播间
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toOpenLiveRoomWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 直播间列表 - 直播间列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getLiveRoomListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 直播间列表 - 关注主播列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getLiveRoomFollowListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 直播标签 - 标签列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetLiveTagListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 直播间 - 房间状态
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetLiveRoomStatusWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 直播间 - 主播端 - 设置房管
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toSetLiveManagerWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 直播间 - 房管-主播端 - 禁言
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toSetLiveSilenceWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 直播间 - 房管-主播端 - 移除麦位的人
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)theManageToRemoveLinkMicWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 直播间 - 房管-主播端 - 锁定麦位
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)theManageToLockLinkMicWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 直播间 - 房管-主播端 - 上麦申请审核
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)theManageToAuditLinkMicWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 直播间 - 房管-主播端 - 踢出成员
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)theManageToKickOutSomeOneWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 直播间 - 主播端 - 获取房间的数据中心
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetLiveCenterInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 直播间 - 用户端 - 关闭连麦
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)TheLinkMicToLeaveTheLiveWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 直播间 - 用户端 - 上麦申请
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toApplyLinkMicWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 直播间 - 上麦申请列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetApplyListAboutLinkMicWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 直播间 - 用户端 - 上麦申请取消
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toCancelTheApplyLinkMicWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 直播间 - 贵族列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetJoinVipsAboutLiveWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 直播间 - 查看他人信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheUserInfoInLiveRoomWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 直播间 - 房间在线成员
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetJoinMembersAboutLiveWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 直播间 - 管理员列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetJoinManagesAboutLiveWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 直播间 - 用户端 - 离开直播间
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toLeaveTheLiveWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 直播间 - 用户端 - 进入直播间
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toJoinEnterTheLiveWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 直播间 - 用户端 - 进入直播间（二次确认）
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toJoinLiveWithConfirmWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 直播间 - 主播端 - 关闭直播间
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toCloseTheLiveRoomWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 直播模块 - 用户端 - 心跳汇报
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toReportAboutViewerLiveWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 直播模块 - 主播端 - 心跳汇报
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toReportAboutAnchorLiveWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 直播间 - 主播端 - 正在开启的直播间（只允许直播调用）
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)theAnchorGetLiveRoomWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 直播间 - 开播配置信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getTheLiveConfigInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 直播 - 观看历史
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheLiveHistoryListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 直播 - 观看历史删除
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toDeleteTheLiveHistoryWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 直播弹幕 - 提交
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toSubmitBarrageInLiveWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 直播间 - TOP用户列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)theTopsUserAboutLiveRoomWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 直播公屏 - 提交
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toSubmitPublicScreenWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 直播间 - 不感兴趣的直播间
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toSubmitTheDisinterestRoomWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 直播间 - 根据ID,获取房间信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetLiveRoomInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 直播间 - 主播端 - 房间挂起
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toPendingTheLiveRoomWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 直播间 - 主播端 - 转门票房.设置
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toSettingConvertTheLiveRoomWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 直播间 - 主播端 - 转门票房.提交
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toSubmitConvertAboutLiveRoomWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 直播间 - 转换房间 - 支付
///   - params: 参数
///   - block: 回调
- (void)toConvertPayTheTicketRoomWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 直播间列表 - 检查已经关闭的直播间
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toCheckTheLiveRoomListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 直播间列表 - 分类信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheLiveRoomCategoryDataWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 直播间 - 样式选项
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheLiveRoomCongifThemeWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 直播间 - 主播端 - 音视频锁定.批量操作
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toSwitchTheLinkMicDataWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 用户端 - 直播间送礼物.批量
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toSendMoreOneGiftWithParams:(id)params andBlock:(void (^)(id _Nullable data, NSError *error))block;

/// 用户端 - 直播间送礼物(赠送背包的).批量
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toSendMoreOneGiftAboutPackWithParams:(id)params andBlock:(void (^)(id _Nullable data, NSError *error))block;

/// 直播间 - 连麦邀请列表(仅管理员-主播请求)
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheLinkMicInviteListDataWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 直播间 - 连麦邀请 - 同意上麦
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toAgreedTheLinkMicInviteWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 直播间 - 连麦邀请密钥(仅管理员-主播请求)
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheUserLinkStrWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 直播间变化 - 多人连麦房间样式.麦位发生变化
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toChangeTheMultipleDataWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 直播间 - 封面示例
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getCoverTemplatesDataWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 直播间配置 - 直播间打招呼配置
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)setSayHelloWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 主播端 - 主播获取自己的-互动礼物列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getGiftMenuDataWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 主播端 - 设置互动礼物-开关
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)setGiftMenuOpenWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 主播端 - 设置互动礼物
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)setGiftMenuWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 主播端 - 互动礼物池列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getGiftMenuPoolWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 主播端 - 设置互动礼物-删除
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)deleteGiftMenuWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 用户端 - 用户获取主播的-互动礼物列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getAnchorGiftMenuDataWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 直播间 - 主播端 - 允许联线状态变更
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toChangeTheLiveAllowLinkStatusWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 检查用户是否已经关注指定用户列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toCheckTheContactFollowStatusWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;


#pragma mark ===========   Robot  ============

/// 机器人飘屏 - 飘屏列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheRobotScreenListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

#pragma mark =========== Wish List ============

/// 主播端 - 获取在途的心愿单
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetOnGoingWishGiftWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 主播端 - 设置心愿
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toCreateWishGiftWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 主播端 - 获取心愿单列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetWishGiftConfigWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 主播端 - 取消心愿
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toCancelWishGiftWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 获取主播已完成的心愿
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetWishRecordListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 用户端 - 获取主播被助力过的心愿单
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetWishRecordAboutAnchorWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 用户端 - 获取主播正在进行的心愿单.2 (用于直播间 滚屏)
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetWithGiftOngoingTwoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

#pragma mark - v2.0.2
/// 主播端 - 礼物心愿V2 - 已选择列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getDesireDataWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 主播端 - 礼物心愿V2 - 配置列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getDesireGiftListDataWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 礼物心愿V2 - 已选择列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getDesireChooseDataWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 主播端 - 直播心愿 - 设置
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)setDesireWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 直播心愿 - 主播端 - 关闭心愿单
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)closeDesireWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 直播房心愿 - 排行榜 - 基础列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getDesireRankWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 直播心愿 - 直播房心愿 - 填充排行榜
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getDesireRankFillDataWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

#pragma mark =========== Live Center ============

/// 主播端 - 直播间收到的门票
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)theLiveCenterAboutTicketWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 主播端 - 直播中的数据
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)theLiveCenterInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 主播端 - 直播间完成的心愿单列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)theLiveCenterAboutGiftWishWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 主播端 - 赠送礼物的用户
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)theLiveCenterAboutGiftUserWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 主播端 - 直播间收到的礼物列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)theLiveCenterAboutGiftListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

#pragma mark =========== Live Gift ============
/// 用户端 - 直播间礼物
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetLiveGiftListWithParams:(id)params andBlock:(void (^)(id _Nullable data, NSError *error))block;

/// 用户端 - 直播间送礼物
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGivingGiftAboutLiveWithParams:(id)params andBlock:(void (^)(id _Nullable data, NSError *error))block;

#pragma mark =========== App ============

/// APP版本 - 检查当前APP版本
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toCheckAppVersionWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// APP功能区 - 列表信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheFunctionListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

#pragma mark =========== About IM ============

/// 黑名单 - 移除
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toRemoveBlockWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 黑名单 - 列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getBlockListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 黑名单 - 添加
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toAddSomeOneForBlockWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 联系页 - 关注接口
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toSubmitForFollowWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 联系页 - 关注设置信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toSettingInfoForFollowWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 联系页 - 关注列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getFollowListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 踢出粉丝，移除对方的关注
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toKickSomeOneFormFollowWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 联系页 - 好友列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getFollowFriendListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 联系页 - 粉丝列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getFollowFansListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 黑名单 - 检查是否黑名单用户
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toCheckTheUserIsBlackWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 联系页 - 粉丝新成员已读
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)theNewFansAlreadyReadWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 检查用户是否已经关注指定用户列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toCheckTheContactFollowInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

#pragma mark =========== Feedback ============

/// 用户举报 - 提交
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toSubmitFeedbackReportWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// App问题反馈 - 提交
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toSubmitFeedbackIssueWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 直播间 - 分享短连接转换
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetShareSlinkWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 直播间 - 汇报 (与每日分享 - 汇报 功能相同)
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toReportTheShareStatusWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

#pragma mark =========== About Base ============

/// 国家 - 地区列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getCountryAndRegionListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 国家 - 电话区号列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getCountryMobileListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 基础模块 - Banner信息
/// - Parameters:
///   - params: 1=首页图片，2=直播间图片，3=New页图片，4=启动页图片，5=开播页图片，6=语音列表图片, 7=充值页广告,8=活动页广告,9=弹框页面,10=私聊页面,11=探索页面,12=任务中心
///   - block: 回调
- (void)getBaseBannerListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 基础存储列表信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheBaseStoreListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 基础模块 - 倒计时相关
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheBaseCountDownListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 美颜物料相关控制器
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheBaseMaterialBeautyWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

#pragma mark =========== About User ============

/// 用户信息 - 获得当前登录用户信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getMeUserInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 根据用户ID列表，查询用户数据
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getUserInfoListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 根据用户编号列表，查询用户数据
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getUserInfoByNoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// diamond
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)testWalletGetDiamondWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;


/// 用户礼物 - 接收的礼物
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)theUserReceiveGiftListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 邀请用户 - 我的邀请信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getMyInviteDataInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 用户信息 - 设置邀请人
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toSetTheLeaderInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 用户查询 - 查询用户
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toSearchTheUserInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 用户等级 - 等级信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetUserInfoAboutLevelWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 用户事件 - 事件列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetUserEventListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 用户事件 - ACK信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)theUserEventAckWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 用户安全 - 获取用户安全信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheUserSecurityInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 用户手机号码 - 换绑手机 - 发送原有手机验证码
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toSendTheUserOldMobileChangeCodleWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 用户手机号码 - 换绑手机 - 检验原有手机号码是否通过
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toCheckTheOldMobileCodeWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 用户手机号码 - 换绑手机 - 发送新手机验证码
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toSendTheNewMobileCodeWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 用户手机号码 - 换绑手机 - 绑定新手机
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toBingTheNewMobileWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 用户邮箱 - 换绑邮箱 - 发送新邮箱验证码
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getTheNewEmailCodeWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 用户邮箱 - 换绑邮箱 - 发送原有邮箱验证码
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getTheOldEmailCodeWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 用户邮箱 - 换绑邮箱 - 检验原有邮箱是否通过
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toCheckTheOldEmailCodeWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 用户邮箱 - 换绑邮箱 - 提交换绑
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toBindTheNewEmailWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 用户邮箱 - 绑定新邮箱 - 提交
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toSubmitTheEmailWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 用户邮箱 - 绑定新邮箱 - 发送验证码
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toBindEmailAndGetCodeWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;


/// 用户密码2 - 设置密码 - 校验验证码
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)thePassword2SettingVerifyWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 用户密码2 - 设置密码 - 提交变更
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)thePassword2SettingSubmitWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 用户密码2 - 设置密码 - 发送验证
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)thePassword2SettingSendCodeWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 用户密码2 - 变更 - 校验原密码
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)thePassword2ChangeVerifyWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 用户密码2 - 变更 - 提交变更
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)thePassword2ChangeSubmitWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

#pragma mark =========== Image ============

/// 阿里云 OSS 上传，预签名信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getBaseOssAliWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 亚马逊 S3 上传，预签名信息
///   - params: 参数
///   - block: 回调
- (void)getBaseOssS3WithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 上传图片（type如@"image/png"，png是图片格式，否则上传失败）
/// @param imgData 图片
/// @param params 参数
/// @param type 类型
/// @param uploadProgressHandler 上传进度回调
/// @param block 回调
- (NSURLSessionDataTask *)sendSingleChatImage:(NSData *)imgData params:(id)params type:(NSString *)type andBaseUrl:(NSString *)baseUrl withUploadProgressHandler:(void (^)(NSProgress *))uploadProgressHandler andCompletionBlock:(void (^)(id data, NSError *error))block;

#pragma mark =========== About IM Token ============

/// 环信相关 - 获取环信的IM.Token
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetImTokenWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 单聊信息 - 发送消息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)theChatSingleSubmitWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 单聊信息 - 获取会话信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetChatSingleInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// IM相关 - 获取IM的Token (包括环信和腾讯)
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetChatTokenWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 私聊标记上报
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)reportPrivateChatWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

#pragma mark =========== About Fans Club ============

/// 粉丝团相关 - 用户设置显示铭牌
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toSetFansNameplateWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 粉丝团相关 - 获取粉丝团成员列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetFansMembersListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 粉丝团相关 - 离开粉丝团
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)theFansToLeaveWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 主播粉丝团相关 - 编辑粉丝团信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toEditFansClubInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 主播粉丝团相关 - 创建粉丝团
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toCreateFansClubWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 粉丝团相关 - 加入的粉丝团
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toJoinsTheAnchorClubWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 粉丝团相关 - 获取粉丝团信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetAnchorClubInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 粉丝团 - 成员详情
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheFanMembersDetailWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 粉丝团 - 粉丝团排行榜信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheFanClubRankListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

#pragma mark =========== About Anchor ============

/// 主播信息 - 推荐主播列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getAnchorRecommendListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 主播申请 - 提交申请
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)aboutAnchorToAppleyWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 主播申请 - 申请中的信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)aboutAnchorAppleyingWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 主播中心 - 直播时长
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)aboutAnchorCenterDurationInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 主播中心 - 收益统计
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)aboutAnchorCenterIncomeInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 主播时长任务 - 任务列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheAnchorTaskListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 主播时长任务 - 任务领取
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)completeTheAnchorTaskWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 主播中心 - 钱包信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheAnchorCenterWalletInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;


#pragma mark =========== About Guild ============

/// 工会信息 - 工会引导页面
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetGuildAboutGuideWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 工会申请 - 校验手机验证码，获取申请Code
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetGuildApplyVerifyMobileWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 工会申请 - 提交创建工会申请
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toSubmitGuildApplyWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 工会申请 - 获取手机验证码
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetGuildMobileCodeWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 工会申请 - 获取审核中的申请信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGuildApplyAuditingWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 公会2.0 - 提交创建公会申请
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)theGuild2ToApplySubmit2WithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

#pragma mark =========== About Family ============

/// 家族成员 - 成员列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetFamilyMemberListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 家族成员 - 离开家族
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)theMemberToLeaveFamilyWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 家族成员 - 踢出家族
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toKickSomeOneFormFamilyWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 家族申请加入 - 申请加入
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)submitJoinFamilyWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 家族申请审核 - 审核操作
/// - Parameters:
/////   - params: 参数
///   - block: 回调
- (void)toAuditJoinFamilyWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 家族申请审核 - 等待审核列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getAuditListAboutFamilyWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 家族信息 - 转移家族长
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toTransferFamilyWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 家族信息 - 家族排行榜
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheFamilyRankWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 家族信息 - 根据家族ID，查询家族详情
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetFamilyInfoDetailWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 家族信息 - 编辑家族加入状态
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toEditJoinStatusAboutFamilyWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 家族信息 - 编辑家族信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toEditFamilyInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 家族创建申请 - 提交申请
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toCreateFamilyWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 家族创建申请 - 获取用户的申请
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetFamilyCreateInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 家族信息 - 获取我加入的家族
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetMyFamilyInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 家族信息 - 家族列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetFamilyInfoListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 家族任务 - 我的今日任务
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetFamilyTaskListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 家族任务 - 完成任务领取奖励
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toSubmitTheFamilyTaskWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

#pragma mark =========== About Prop ============

/// 用户道具 - 使用
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toUseThePropWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 用户道具 - 列表信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetThePropUserListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 道具商店 - 列表信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetThePropInfoListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 道具商店 - 购买
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toBuyPropWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 道具存储 - 列表信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetPropStoreListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 用户道具 - 列表信息 v2.0.2
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getUserPropListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

#pragma mark =========== About PK ============

/// PK - PK记录
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetPkRecordListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// PK - 匹配
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toMatchPkInLiveWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// PK邀请 - 列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetPkInviteListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// PK邀请 - 同意上麦
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toAgreePkInviteWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// PK - 关闭
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toCloseThePkInLiveWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// PK - 我的PK信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetMySelfPkInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// PK - PK 结算
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toSettleThePkWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// PK - PK贡献榜
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetThePkContributeInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// PK - 周奖励礼物
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetThePkWeekRewardInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

#pragma mark =========== About Source ============
/// 礼物资源列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheGiftStoreListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 互动特效列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheEffectListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 礼物分类 - 列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetGiftCategoryListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 礼物倍数 - 列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheGiftMultipleListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 用户等级框 - 资源列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheLevelResourcesListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 勋章库 - 资源列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheMedalResourcesListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

#pragma mark =========== About Medal ============

/// 基础勋章列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetBaseMedalInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 基础勋章列表(查看他人勋章)
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetOtherUserMedalInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

#pragma mark =========== About Pack ============

/// 礼物背包 - 用户礼物背包
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetPackGiftListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 直播间 道具列表 v2.0.2
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetPackPropListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 用户端 - 直播间送礼物(赠送背包的)
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGivingPackGiftWithParams:(id)params andBlock:(void (^)(id _Nullable data, NSError *error))block;

/// 礼物背包 - 我的背包礼物列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetThePackGiftAllWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 用户道具 - 用户道具过期记录 v2.0.2
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getPropExpireListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 礼物背包 - 用户礼物背包-过期列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getPackGiftExpireListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

#pragma mark =========== About Vip ============

/// 我的VIP信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getMyVipInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// VIP 配置信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getTheVipConfigWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 购买VIP-续费VIP
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toBuyTheVipWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 领取购买的VIP每日礼包
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheVipDailyGiftWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 领取购买的VIP礼包
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheVipGiftBagWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

//New Vip

/// VIP订单 - 订单列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheVipOrderListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// VIP计划 - 配置列表信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheVipPlanListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 开启或关闭神秘人
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toSetMysteriousWwitchWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 神秘人默认资料信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheMysteriousInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// VIP计划 - 领取每日礼包
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheVipPlanDailyWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// VIP计划 - 购买VIP-续费VIP-升级VIP
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheVipPlanBuyWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

#pragma mark =========== About Wallet ============

/// 钱包充值 - 充值记录
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetWalletRechargeRecordWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 用户收益信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)theUserIncomeInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 钱包充值 - 商品充值预下单
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toRechargeGoodsPrePayWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 钱包充值 - 商品充值支付成功回调
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)theGoodsPayBakWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 钱包充值 - 订单取消
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)theGoodsCancelWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 钱包充值 - 获取商品首充配置
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)theRechargeAboutGoodsRewardWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 钱包充值 - 商品信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheRechargeGoodsInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;


#pragma mark =========== About Device ============

/// 设备汇报
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toReportTheDeviceInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 用户钻石数
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheUserCurrentDiamondWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

#pragma mark =========== About Like Click ============

/// 点赞 - 直播间点赞 - 提交
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toSubmitTheLikeClickWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 点赞 - 直播间点赞 - 列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheLikeClickListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 点赞 - 直播间点赞配置
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheLikeConfingWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

#pragma mark =========== About GiftPack ============

/// 礼包信息 - 预下单
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheGiftPackPreOrderWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 礼包信息 - 获取
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheGiftPackListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 礼包信息 - 支付回调
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)theGiftPackCallBackWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

#pragma mark =========== About Red Rain ============

/// 抢红包雨结果提交
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toSubmitRedRainResultWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 抢红包雨名额
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toRequestTheRedRainWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

#pragma mark =========== About Wame ============

///  信息 - 列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetWameListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 进入
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toEnterWameWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

#pragma mark =========== Sign Task ============

/// 签到任务 - 签到信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheSignTaskInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 签到任务 - 签到 - 提交
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toSubmitTheSignTaskAboutSignWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;


#pragma mark =========== Red Envelope ============

/// 获取红包相关配置
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheRedEnvelopeConfigWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 发红包
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toSendTheRedEnvelopeConfigWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 获取红包领取情况
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheRedEnvelopeReceivingInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 领红包
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toReceiveTheRedEnvelopeWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 获取房间红包列表信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheRedEnvelopeListOfRoomWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 获取用户已发红包列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheUserSendRecordWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 获取用户领红包列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheUserReceiveRecordWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 获取指定红包详情
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheRedEnvelopeInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

#pragma mark =========== Big Winner ============

/// 大赢家活动 - 已经结束的列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getTheBigWinRecordListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 大赢家活动 - 当前正在进行的列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getTheBigWinListDataWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 大赢家活动 - 最近中奖记录
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getTheBigWinLatelyListDataWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 大赢家活动 - 获取活动最后参加记录
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getTheBigWinLastDataWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 大赢家活动 - 参加活动
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toJoinTheBigWinWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 大赢家活动 - 活动详情
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getTheBigWinDetailWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 弹框 - APP 弹框信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getTheDialogInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 领取新人礼包
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)claimNewUserGiftPackWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

#pragma mark =========== Theme ============
/// 当前样式配置
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getThemeWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;


#pragma mark =========== 全民代理 ============
/// 获取用户代理绑定状态
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getAffiliateStateWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;


/// 绑定上级
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)bindAffiliateWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 代理账户 - 获取当前可领取钻石数
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getAffiliateAccountWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;


/// 声网 - 查询用户状态
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toCheckTheUserAboutChannelStatusWith:(id)params andBlock:(void (^)(id data, NSError *error))block;

#pragma mark =========== 充值返利 ============
- (void)getBadgeListDataWithParams:(id)params needCache:(BOOL)cache andBlock:(void (^)(id data, NSError *error))block;

#pragma mark =========== 翻译 ============

/// 获得当前用户的语言配置
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheTranslationInfoAboutMyWith:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 获取支持的语言配置
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheTranslationConfigWith:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 设置当前用户的语言配置
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toSettingTheTranslationConfigWith:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 翻译 (文本翻译接口
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toTranslationTheContentWith:(id)params andBlock:(void (^)(id data, NSError *error))block;

#pragma mark =========== Beauty ============

/// 火山美颜+ar礼物物料相关控制器
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheBaseMaterialHuoShanInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 用户信息 - 美颜信息设置
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toSettingTheUserBeautyInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 获取用户信息设置
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheUserBeautyInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

#pragma mark =========== 盲盒礼物 ============
/// 盲盒礼物 - 抽奖
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)drawBlindBoxWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;


#pragma mark =========== 平台货币调整 ============
/// 获取用户金豆信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getGoldBeanInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 金豆转换钻石
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)exchangeGoldBeanToDiamondWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 金豆转换法币
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)exchangeGoldBeanToCashWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

/// 获取法币汇率
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getGoldBeanExchangeRateWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

- (BOOL)handleError:(id)data;

@end

#define kHttpManager [MOHttpManager sharedManager]

NS_ASSUME_NONNULL_END
