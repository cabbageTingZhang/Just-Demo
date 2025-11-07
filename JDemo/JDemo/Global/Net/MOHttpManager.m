//
//  MOHttpManager.m
//  MiMoLive
//
//  Created by SuperC on 2023/10/12.
//

#import "MOHttpManager.h"
#import "MONetAPIClient.h"
#import "MODynamicBaseUrlAPI.h"
#import "MOApiResponseCacheModel.h"

#import "MOOtherNetAPIClient.h"

@implementation MOHttpManager

+ (instancetype)sharedManager
{
    static MOHttpManager *shared_manager = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^
    {
        shared_manager = [[self alloc] init];
        shared_manager.responseCacheDict = [NSMutableDictionary new];
    });
    return shared_manager;
}

#pragma mark ----- public ------
/// 缓存接口返回数据
- (void)cacheApiData:(id)data key:(NSString *)key
{
    MOApiResponseCacheModel *cacheModel = [MOApiResponseCacheModel new];
    cacheModel.responseTime = [[NSDate date] timeIntervalSince1970];
    cacheModel.responseData = data;
    @synchronized (self.responseCacheDict)
    {
        self.responseCacheDict[key] = cacheModel;
    }
}

#pragma mark =========== Login ============
/// 用户引导信息 - 获取用户引导状态
/// result=引导状态，(0=无注册引导，1=进入编辑资料页面，2=进入关注主播页面)
- (void)getGuideWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block {
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",KNetPath_Code_Guide] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 国家 - IP归属地
/// - Parameters:
///   - params: 参数
///   - block: 回调
-(void)getCountryIpithParams:(id)params andBlock:(void (^)(id data, NSError *error))block {
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",KNetPath_Code_CountryIp] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 登录，手机 + 密码 - 登入
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)loginWithPwdWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",KNetPath_Code_PwdEnter] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 登录，手机验证码 - 登入
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)logineWithMobileWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",KNetPath_Code_MobileEnter] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 登录，手机验证码 - 获取手机验证码
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)loginAndGetMobileCodeWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",KNetPath_Code_GetMobileCode] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 登录，Google - 登入
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)loginWithGoogleWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",KNetPath_Code_GoogleEnter] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 登录，Facebook - 登入
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)logineWithFacebookWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",KNetPath_Code_FacebookEnter] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 登录，Apple(苹果ID) - 登入
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)loginWithAppleWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",KNetPath_Code_AppleEnter] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 用户信息 - 信息设置
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toSettingInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",KNetPath_Code_InfoSetting] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 用户信息 - 随机昵称、随机头像
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)randomProfileWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block {
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",KNetPath_Code_RandomProfile] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 用户信息 - 随机昵称、随机头像(区分性别)
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheRandomProfileWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_RandomProfiles] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 用户登出 - 操作
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toLogoutWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",KNetPath_Code_Logout] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 用户手机号码 - 新绑定手机号码
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)firstToBingCodeWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",KNetPath_Code_BingCode] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 用户手机号码 - 绑定手机号码 提交
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toBingAndSubmitWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",KNetPath_Code_BindSubmit] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 用户手机号码 - 密码重置 - 获取手机验证码
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetPassworkCodeWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",KNetPath_Code_GetPasswordCode] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 用户手机号码 - 密码重置 - 提交重置
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toResetPasswordWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",KNetPath_Code_PasswordReset] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 用户信息 - 加入粉丝团设置 开关
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toJoinFansClubWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",KNetPath_Code_JoinFansClub] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 用户信息 - 删除用户
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toDeleteTheUserWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",KNetPath_Code_UserToDelete] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 用户信息 - 语言设置
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toSetLanguageWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block {
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",KNetPath_Code_UserInfoLanguage] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 忘记密码-密码重置2 - 获取手机验证码
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetPasswordCode2WithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",KNetPath_Code_GetPasswordCode2] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 忘记密码-密码重置2 - 检查手机验证码
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toVerifyTheSmsCodeWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",KNetPath_Code_TheCodeVerify] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 忘记密码-密码重置2 - 提交重置
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toResetThePassword2WithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",KNetPath_Code_PasswordReset2] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

#pragma mark =========== Rank ============

/// 排行榜 - 贡献榜
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetRankOutcomeListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",KNetPath_Code_RankOutComeList] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 排行榜 - 直播半小时榜单
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetRankHalfHourListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",KNetPath_Code_RankHalfHour] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 排行榜 - 收益榜
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetRankIncomeListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",KNetPath_Code_RankIncome] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 排行榜 - 直播间贡献榜
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetRankOutcomeRoomWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_RankOutComeRoom] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 排行榜 - PK榜
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetRankListAboutPkWeekWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_RankPkWeek] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 排行榜 - TOP的前3名用户信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheRankTopsWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_RankTops] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 排行榜 - 用户贡献榜TOP的前3名用户信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetUserOutcomeTopsWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_RankOutTops] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 排行榜 - 直播间嘉宾贡献榜
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheOutcomeAboutGuestWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_TheGuestRank] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 直播间热度排行榜
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetRoomHeatRankWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_LiveHeatRank] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 直播间操作 - 音视频操作
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toOperationMediaAboutTheLiveWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_LiveOperationMedia] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 直播间 - 嘉宾连麦统计信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheLiveLinkMicGuestSummaryWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_LiveLinkMicSummary] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

- (void)toRecoveryTheLiveWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_LiveRecovery] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 直播间 - 用户端 - 进入直播间且rtm已上线
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)reportRtmOnlineSuccessWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block {
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_OnlineRtm] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

#pragma mark =========== LiveRoom ============

/// 直播间相关 - 开启直播间
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toOpenLiveRoomWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_LiveRoomOpen] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 直播间列表 - 直播间列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getLiveRoomListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_LiveRoomList] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 直播间列表 - 关注主播列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getLiveRoomFollowListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_LiveRoomFollow] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 直播标签 - 标签列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetLiveTagListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_LiveTagList] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 直播间 - 房间状态
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetLiveRoomStatusWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_LiveRoomStatus] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 直播间 - 主播端 - 设置房管
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toSetLiveManagerWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_LiveManageSet] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 直播间 - 房管-主播端 - 禁言
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toSetLiveSilenceWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_LiveSilenceSet] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 直播间 - 房管-主播端 - 移除麦位的人
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)theManageToRemoveLinkMicWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_LiveManageRemove] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 直播间 - 房管-主播端 - 锁定麦位
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)theManageToLockLinkMicWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_LiveMicLock] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 直播间 - 房管-主播端 - 上麦申请审核
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)theManageToAuditLinkMicWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_LiveMicAudit] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 直播间 - 房管-主播端 - 踢出成员
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)theManageToKickOutSomeOneWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_LiveKickOut] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 直播间 - 主播端 - 获取房间的数据中心
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetLiveCenterInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_LiveManageCenter] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 直播间 - 用户端 - 关闭连麦
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)TheLinkMicToLeaveTheLiveWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_LiveMicLeave] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 直播间 - 用户端 - 上麦申请
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toApplyLinkMicWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_LiveMicApply] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 直播间 - 上麦申请列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetApplyListAboutLinkMicWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_LiveMicApplyList] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 直播间 - 用户端 - 上麦申请取消
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toCancelTheApplyLinkMicWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_LiveMicAppleyCancel] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 直播间 - 贵族列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetJoinVipsAboutLiveWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_LiveVipList] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 直播间 - 查看他人信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheUserInfoInLiveRoomWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_TheLiveMember] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 直播间 - 房间在线成员
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetJoinMembersAboutLiveWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_LiveMembers] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 直播间 - 管理员列表 (VIP 列表)
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetJoinManagesAboutLiveWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_LiveVipViewer] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 直播间 - 用户端 - 离开直播间
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toLeaveTheLiveWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_LiveToLeave] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 直播间 - 用户端 - 进入直播间
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toJoinEnterTheLiveWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_LiveToEnter] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 直播间 - 用户端 - 进入直播间（二次确认）
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toJoinLiveWithConfirmWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_LiveJoinConfirm] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 直播间 - 主播端 - 关闭直播间
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toCloseTheLiveRoomWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_LiveToClose] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 直播模块 - 用户端 - 心跳汇报
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toReportAboutViewerLiveWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_LiveReportViewer] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 直播模块 - 主播端 - 心跳汇报
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toReportAboutAnchorLiveWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_LiveReportAnchor] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 直播间 - 主播端 - 正在开启的直播间（只允许直播调用）
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)theAnchorGetLiveRoomWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_TheRoomLiving] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 直播间 - 开播配置信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getTheLiveConfigInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_LiveConfig] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 直播 - 观看历史
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheLiveHistoryListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_LiveHistoryInfo] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 直播 - 观看历史删除
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toDeleteTheLiveHistoryWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_LiveHistoryDelete] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 直播弹幕 - 提交
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toSubmitBarrageInLiveWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_LiveBarrageSubmit] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 直播间 - TOP用户列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)theTopsUserAboutLiveRoomWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_LiveTopsUser] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 直播公屏 - 提交
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toSubmitPublicScreenWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_LivePublicSubmit] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 直播间 - 不感兴趣的直播间
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toSubmitTheDisinterestRoomWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_LiveNoLike] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 直播间 - 根据ID,获取房间信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetLiveRoomInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_LiveRoomInfo] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 直播间 - 主播端 - 房间挂起
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toPendingTheLiveRoomWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_LivePending] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 直播间 - 主播端 - 转门票房.设置
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toSettingConvertTheLiveRoomWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_LiveConvertSet] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 直播间 - 主播端 - 转门票房.提交
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toSubmitConvertAboutLiveRoomWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_LiveConvertSubmit] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 直播间 - 转换房间 - 支付
///   - params: 参数
///   - block: 回调
- (void)toConvertPayTheTicketRoomWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_LiveConvertPay] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 直播间列表 - 检查已经关闭的直播间
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toCheckTheLiveRoomListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_CheckTheLiveRoom] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 直播间列表 - 分类信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheLiveRoomCategoryDataWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_TheLiveRoomCategory] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 直播间 - 样式选项
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheLiveRoomCongifThemeWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_LiveConfigTheme] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 直播间 - 主播端 - 音视频锁定.批量操作
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toSwitchTheLinkMicDataWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_LinkMicSwitch] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 用户端 - 直播间送礼物.批量
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toSendMoreOneGiftWithParams:(id)params andBlock:(void (^)(id _Nullable data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_LiveGiftGivings] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 用户端 - 直播间送礼物(赠送背包的).批量
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toSendMoreOneGiftAboutPackWithParams:(id)params andBlock:(void (^)(id _Nullable data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_LiveGiftGivingPacks] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 直播间 - 连麦邀请列表(仅管理员-主播请求)
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheLinkMicInviteListDataWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_LiveLinkMicInviteList] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 直播间 - 连麦邀请 - 同意上麦
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toAgreedTheLinkMicInviteWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_LiveLinkMicInviteAgreed] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 直播间 - 连麦邀请密钥(仅管理员-主播请求)
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheUserLinkStrWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_GetTheLinkStr] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 直播间变化 - 多人连麦房间样式.麦位发生变化
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toChangeTheMultipleDataWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_ChangeTheMultiple] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 直播间 - 封面示例
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getCoverTemplatesDataWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block {
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_CoverTemplates] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 直播间配置 - 直播间打招呼配置
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)setSayHelloWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block {
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_SetSayHello] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 主播端 - 主播获取自己的-互动礼物列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getGiftMenuDataWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block {
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_InteractGifts] withParams:params withMethodType:Post andBlock:^(id data, NSError *error){
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 直播间 - 主播端 - 允许联线状态变更
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toChangeTheLiveAllowLinkStatusWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_ManageAllowLinkChange] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)

     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 主播端 - 设置互动礼物-开关
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)setGiftMenuOpenWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block {
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_InterractGiftSwitch] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 主播端 - 设置互动礼物
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)setGiftMenuWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block {
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_InterractGiftSet] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 主播端 - 互动礼物池列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getGiftMenuPoolWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block {
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_InterractGiftPool] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 主播端 - 设置互动礼物-删除
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)deleteGiftMenuWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block {
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_InterractGiftRemove] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 用户端 - 用户获取主播的-互动礼物列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getAnchorGiftMenuDataWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block {
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_InterractAnchorGifts] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 检查用户是否已经关注指定用户列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toCheckTheContactFollowStatusWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_CheckContactFollow] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

#pragma mark ===========   Robot  ============

/// 机器人飘屏 - 飘屏列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheRobotScreenListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_RobotScreen] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

#pragma mark =========== Wish List ============

/// 用户端 - 获取主播正在进行的心愿单
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetOnGoingWishGiftWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_TheGiftOnGoing] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 主播端 - 设置心愿
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toCreateWishGiftWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_TheGiftCreate] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 主播端 - 获取心愿单列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetWishGiftConfigWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_TheGiftWishList] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 主播端 - 取消心愿
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toCancelWishGiftWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_WishGiftCancel] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 获取主播已完成的心愿
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetWishRecordListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_WishRecordList] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 用户端 - 获取主播被助力过的心愿单
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetWishRecordAboutAnchorWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_WishAssisted] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 用户端 - 获取主播正在进行的心愿单.2
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetWithGiftOngoingTwoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_TheGiftOnGoingTwo] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}


#pragma mark - v2.0.2
/// 直播心愿 - 获取房间心愿数据
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getDesireDataWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block {
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_getDesire] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 主播端 - 礼物心愿V2 - 配置列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getDesireGiftListDataWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block {
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_desireList] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 礼物心愿V2 - 已选择列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getDesireChooseDataWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block {
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_desireChoose] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 主播端 - 直播心愿 - 设置
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)setDesireWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block {
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_desireSetting] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 直播心愿 - 主播端 - 关闭心愿单
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)closeDesireWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block {
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_desireClose] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 直播房心愿 - 排行榜 - 基础列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getDesireRankWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block {
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_desireRank] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 直播心愿 - 直播房心愿 - 填充排行榜
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getDesireRankFillDataWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block {
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_desireRankFill] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

#pragma mark =========== Live Center ============

/// 主播端 - 直播间收到的门票
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)theLiveCenterAboutTicketWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_LiveCenterTicket] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 主播端 - 直播中的数据
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)theLiveCenterInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_LiveCenterInfo] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 主播端 - 直播间完成的心愿单列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)theLiveCenterAboutGiftWishWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_LiveCenterGiftWish] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 主播端 - 赠送礼物的用户
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)theLiveCenterAboutGiftUserWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_LiveCenterGiftUser] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 主播端 - 直播间收到的礼物列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)theLiveCenterAboutGiftListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_LiveCenterGiftList] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

#pragma mark =========== Live Gift ============
/// 用户端 - 直播间礼物
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetLiveGiftListWithParams:(id)params andBlock:(void (^)(id _Nullable data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_LiveGiftV2List] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 用户端 - 直播间送礼物
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGivingGiftAboutLiveWithParams:(id)params andBlock:(void (^)(id _Nullable data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_LiveGiftGiving] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}


#pragma mark =========== App ============

/// APP版本 - 检查当前APP版本
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toCheckAppVersionWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_VersionCheck] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// APP功能区 - 列表信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheFunctionListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_FunctionalList] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

#pragma mark =========== About IM ============

/// 黑名单 - 移除
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toRemoveBlockWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_RemoveBlock] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 黑名单 - 列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getBlockListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_BlockList] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 黑名单 - 添加
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toAddSomeOneForBlockWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_BlockAdd] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 联系页 - 关注接口
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toSubmitForFollowWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_FollowSubmit] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 联系页 - 关注设置信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toSettingInfoForFollowWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_FollowSet] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 联系页 - 关注列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getFollowListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_FollowList] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 踢出粉丝，移除对方的关注
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toKickSomeOneFormFollowWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_FollowKick] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 联系页 - 好友列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getFollowFriendListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_FollowFriend] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 联系页 - 粉丝列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getFollowFansListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_FansList] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 黑名单 - 检查是否黑名单用户
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toCheckTheUserIsBlackWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_BlockCheck] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 联系页 - 粉丝新成员已读
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)theNewFansAlreadyReadWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_NewFansRead] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 检查用户是否已经关注指定用户列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toCheckTheContactFollowInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_ContactFollowCheck] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

#pragma mark =========== Feedback ============

/// 用户举报 - 提交
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toSubmitFeedbackReportWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_RepoetSubmit] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// App问题反馈 - 提交
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toSubmitFeedbackIssueWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_IssueSubmit] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 直播间 - 分享短连接转换
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetShareSlinkWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_LiveShareSlink] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 直播间 - 汇报 (与每日分享 - 汇报 功能相同)
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toReportTheShareStatusWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_ShareShare] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}


#pragma mark =========== About Country ============
/// 国家 - 地区列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getCountryAndRegionListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_CountryList] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 国家 - 电话区号列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getCountryMobileListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_CountryMobileList] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 基础模块 - Banner信息
/// - Parameters:
///   - params: 1=首页图片，2=直播间图片，3=New页图片，4=启动页图片，5=开播页图片，6=语音列表图片
///   - block: 回调
- (void)getBaseBannerListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",KNetPath_Code_Banner] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 基础存储列表信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheBaseStoreListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    // 定义本接口缓存的有效时长:2小时
    const static NSTimeInterval kRequestBaseStoreListCacheDuration = 2 * 3600;
    if (kHttpManager.responseCacheDict[kNetPath_Code_BaseStoreList]) {
        MOApiResponseCacheModel *cacheModel = kHttpManager.responseCacheDict[kNetPath_Code_BaseStoreList];
        NSTimeInterval nowTime = [[NSDate date] timeIntervalSince1970];
        if (nowTime < cacheModel.responseTime + kRequestBaseStoreListCacheDuration) {
            // 读取缓存数据,主线程返回
            dispatch_async(dispatch_get_main_queue(), ^{
                block(cacheModel.responseData, nil);
            });
            return;
        }
    }
    
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_BaseStoreList] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                if (kCode_Success){
                    // 接口数据业务正常返回，缓存数据
                    MOBaseResData *baseData = [MOBaseResData modelObjectWithDictionary:data[@"data"]];
                    if(baseData.baseInterrupt.prop &&
                       baseData.baseInterrupt.gift &&
                       baseData.baseInterrupt.level &&
                       baseData.baseInterrupt.medal &&
                       baseData.baseInterrupt.vip){
                        [kHttpManager cacheApiData:data key:kNetPath_Code_BaseStoreList];
                    }
                }
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 基础模块 - 倒计时相关
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheBaseCountDownListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_BaseCountDownList] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 美颜物料相关控制器
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheBaseMaterialBeautyWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_BaseMaterialHuoShan] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

#pragma mark =========== About User ============

/// 用户信息 - 获得当前登录用户信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getMeUserInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",KNetPath_Code_UserInfoMe] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 根据用户ID列表，查询用户数据
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getUserInfoListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_UserInfoList] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 根据用户编号列表，查询用户数据
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getUserInfoByNoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_UserInfoByNo] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// diamond
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)testWalletGetDiamondWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_TestDiamond] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 用户礼物 - 接收的礼物
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)theUserReceiveGiftListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_UserGiftReceive] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 邀请用户 - 我的邀请信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getMyInviteDataInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_UserInfoInviteData] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 用户信息 - 设置邀请人
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toSetTheLeaderInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_UserInfoLeader] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 用户查询 - 查询用户
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toSearchTheUserInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_UserInfoSearch] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 用户等级 - 等级信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetUserInfoAboutLevelWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_UserInfoLevel] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 用户事件 - 事件列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetUserEventListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_UserEventList] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 用户事件 - ACK信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)theUserEventAckWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_UserEventAck] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 用户安全 - 获取用户安全信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheUserSecurityInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_UserSecurityInfo] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 用户手机号码 - 换绑手机 - 发送原有手机验证码
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toSendTheUserOldMobileChangeCodleWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_UserMobileChangeGetCode] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 用户手机号码 - 换绑手机 - 检验原有手机号码是否通过
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toCheckTheOldMobileCodeWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_UserMobileChangeCodeCheck] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 用户手机号码 - 换绑手机 - 发送新手机验证码
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toSendTheNewMobileCodeWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_UserMobileChangeSend] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 用户手机号码 - 换绑手机 - 绑定新手机
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toBingTheNewMobileWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_UserMobileChangeBind] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 用户邮箱 - 换绑邮箱 - 发送新邮箱验证码
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getTheNewEmailCodeWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_UserEmailChangeSend] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 用户邮箱 - 换绑邮箱 - 发送原有邮箱验证码
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getTheOldEmailCodeWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_UserGetOldEmailCode] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 用户邮箱 - 换绑邮箱 - 检验原有邮箱是否通过
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toCheckTheOldEmailCodeWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_UserCheckOldEmailCode] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 用户邮箱 - 换绑邮箱 - 提交换绑
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toBindTheNewEmailWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_UserChangeEmailBind] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 用户邮箱 - 绑定新邮箱 - 提交
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toSubmitTheEmailWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_UserEmailBindSubmit] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 用户邮箱 - 绑定新邮箱 - 发送验证码
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toBindEmailAndGetCodeWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_UserEmailBindCode] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}


/// 用户密码2 - 设置密码 - 校验验证码
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)thePassword2SettingVerifyWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_UserPassword2SetVerify] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 用户密码2 - 设置密码 - 提交变更
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)thePassword2SettingSubmitWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_UserPassword2SetSubmit] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 用户密码2 - 设置密码 - 发送验证
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)thePassword2SettingSendCodeWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_UserPassword2SetSendCode] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 用户密码2 - 变更 - 校验原密码
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)thePassword2ChangeVerifyWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_UserPassword2ChangeVerify] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 用户密码2 - 变更 - 提交变更
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)thePassword2ChangeSubmitWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_UserPassword2ChangeSubmit] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

#pragma mark =========== Image ============

- (void)getBaseOssAliWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_ImageOss] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

- (void)getBaseOssS3WithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_ImageS3] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 上传图片（type如@"image/png"，png是图片格式，否则上传失败）
/// @param imgData 图片
/// @param params 参数
/// @param type 类型
/// @param uploadProgressHandler 上传进度回调
/// @param block 回调
- (NSURLSessionDataTask *)sendSingleChatImage:(NSData *)imgData params:(id)params type:(NSString *)type andBaseUrl:(NSString *)baseUrl withUploadProgressHandler:(void (^)(NSProgress *))uploadProgressHandler andCompletionBlock:(void (^)(id, NSError *))block
{
    NSURLSessionDataTask *task = [[MODynamicBaseUrlAPI clientWithBaseUrl:baseUrl] requestJsonDataWithPath:baseUrl withData:imgData withType:type?:@"image/jpg" withParams:params withMethodType:Put withProgressHandler:^(NSProgress *uploadProgress)
    {
        uploadProgressHandler?uploadProgressHandler(uploadProgress):nil;
    }
    andBlock:^(id data, NSError *error)
    {
        if (data)
        {
            block(data, nil);
        }
        else
        {
            block(nil, error);
        }
    }];
    
    return task;
}

#pragma mark =========== About IM Token ============

/// 环信相关 - 获取环信的IM.Token
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetImTokenWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_ImToken] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 单聊信息 - 发送消息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)theChatSingleSubmitWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_SingleSubmit] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 单聊信息 - 获取会话信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetChatSingleInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_SingleGet] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// IM相关 - 获取IM的Token (包括环信和腾讯)
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetChatTokenWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNewPath_Code_BaseChatToken] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 私聊标记上报
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)reportPrivateChatWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block {
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_ChatReport] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

#pragma mark =========== About Anchor ============

/// 主播信息 - 推荐主播列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getAnchorRecommendListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_AnchorRecommend] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 粉丝团相关 - 用户设置显示铭牌
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toSetFansNameplateWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_FansNameplate] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 粉丝团相关 - 获取粉丝团成员列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetFansMembersListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_FansMembers] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 粉丝团相关 - 离开粉丝团
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)theFansToLeaveWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_FansLeave] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 主播粉丝团相关 - 编辑粉丝团信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toEditFansClubInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_FansClubEdit] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 主播粉丝团相关 - 创建粉丝团
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toCreateFansClubWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_FansClubCreate] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 粉丝团相关 - 加入的粉丝团
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toJoinsTheAnchorClubWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_ClubJoins] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 粉丝团相关 - 获取粉丝团信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetAnchorClubInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_ClubInfo] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 粉丝团 - 成员详情
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheFanMembersDetailWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_FansMemberDetail] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 粉丝团 - 粉丝团排行榜信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheFanClubRankListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_FansClubRank] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 主播申请 - 提交申请
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)aboutAnchorToAppleyWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_AnchorApply] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 主播申请 - 申请中的信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)aboutAnchorAppleyingWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_AnchorApplying] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 主播中心 - 直播时长
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)aboutAnchorCenterDurationInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_AnchorCenterDuration] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 主播中心 - 收益统计
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)aboutAnchorCenterIncomeInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_AnchorCenterIncome] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 主播时长任务 - 任务列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheAnchorTaskListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_AnchorTaskList] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 主播时长任务 - 任务领取
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)completeTheAnchorTaskWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_AnchorTaskComplete] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 主播中心 - 钱包信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheAnchorCenterWalletInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_AnchorCenterWallet] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

#pragma mark =========== About Guild ============

/// 工会信息 - 工会引导页面
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetGuildAboutGuideWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_GuildAboutGuide] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 工会申请 - 校验手机验证码，获取申请Code
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetGuildApplyVerifyMobileWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_GuildVerify] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 工会申请 - 提交创建工会申请
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toSubmitGuildApplyWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_GuildApply] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 工会申请 - 获取手机验证码
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetGuildMobileCodeWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_GuildMobile] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 工会申请 - 获取审核中的申请信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGuildApplyAuditingWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_GuildAuditing] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 公会2.0 - 提交创建公会申请
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)theGuild2ToApplySubmit2WithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_GuildApplySubmit2] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

#pragma mark =========== About Family ============

/// 家族成员 - 成员列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetFamilyMemberListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_FamilyMemberList] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 家族成员 - 离开家族
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)theMemberToLeaveFamilyWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_FamilyLeave] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 家族成员 - 踢出家族
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toKickSomeOneFormFamilyWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_FamilyKick] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 家族申请加入 - 申请加入
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)submitJoinFamilyWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_FamilyJoinSub] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 家族申请审核 - 审核操作
/// - Parameters:
/////   - params: 参数
///   - block: 回调
- (void)toAuditJoinFamilyWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_FamilyAuditSub] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 家族申请审核 - 等待审核列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getAuditListAboutFamilyWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_FamilyAuditList] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 家族信息 - 转移家族长
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toTransferFamilyWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_FamilyTransfer] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 家族信息 - 家族排行榜
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheFamilyRankWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_FamilyRank] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 家族信息 - 根据家族ID，查询家族详情
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetFamilyInfoDetailWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_FamilyDetail] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 家族信息 - 编辑家族加入状态
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toEditJoinStatusAboutFamilyWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_FamilyEditJoin] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 家族信息 - 编辑家族信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toEditFamilyInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_FamilyEditSub] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 家族创建申请 - 提交申请
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toCreateFamilyWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_FamilyCreate] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 家族创建申请 - 获取用户的申请
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetFamilyCreateInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_FamilyCreateInfo] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 家族信息 - 获取我加入的家族
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetMyFamilyInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_FamilyForMe] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}


/// 家族信息 - 家族列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetFamilyInfoListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_FamilyInfoList] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 家族任务 - 我的今日任务
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetFamilyTaskListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_FamilyTaskToday] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 家族任务 - 完成任务领取奖励
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toSubmitTheFamilyTaskWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_FamilyTaskSubmit] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

#pragma mark =========== About Prop ============

/// 用户道具 - 使用
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toUseThePropWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_PropUse] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 用户道具 - 列表信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetThePropUserListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_PropList] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 道具商店 - 列表信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetThePropInfoListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_PropInfoList] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 道具商店 - 购买
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toBuyPropWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_PropBuy] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 道具存储 - 列表信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetPropStoreListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_PropStoreList] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 用户道具 - 列表信息 v2.0.2
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getUserPropListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block {
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_PropUserList] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

#pragma mark =========== About PK ============

/// PK - PK记录
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetPkRecordListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_PkRecord] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// PK - 匹配
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toMatchPkInLiveWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_PkMatch] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// PK邀请 - 列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetPkInviteListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_PkInvite] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// PK邀请 - 同意上麦
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toAgreePkInviteWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_PkAgree] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// PK - 关闭
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toCloseThePkInLiveWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_PkClose] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// PK - 我的PK信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetMySelfPkInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_PkMe] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// PK - PK 结算
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toSettleThePkWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_PkSettle] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// PK - PK贡献榜
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetThePkContributeInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_PkContribute] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// PK - 周奖励礼物
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetThePkWeekRewardInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_PkWeekReward] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

#pragma mark =========== About Source ============
/// 礼物资源列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheGiftStoreListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_SourceGift] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 互动特效列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheEffectListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_SourceEffect] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 礼物分类 - 列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetGiftCategoryListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_GiftCategoryList] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 礼物倍数 - 列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheGiftMultipleListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_TheGiftMultipleList] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 用户等级框 - 资源列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheLevelResourcesListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_LevelBoxList] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 勋章库 - 资源列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheMedalResourcesListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_MedalStoreList] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

#pragma mark =========== About Medal ============

/// 基础勋章列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetBaseMedalInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_MedalBase] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 基础勋章列表(查看他人勋章)
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetOtherUserMedalInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_MedalOthers] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

#pragma mark =========== About Pack ============

/// 礼物背包 - 用户礼物背包
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetPackGiftListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_PackGiftV2List] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 直播间 道具列表 v2.0.2
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetPackPropListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_PropListForlive] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 用户端 - 直播间送礼物(赠送背包的)
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGivingPackGiftWithParams:(id)params andBlock:(void (^)(id _Nullable data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_GivingPack] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}


/// 礼物背包 - 我的背包礼物列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetThePackGiftAllWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_PackGiftAll] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 用户道具 - 用户道具过期记录 v2.0.2
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getPropExpireListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block {
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_PropExpireList] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 礼物背包 - 用户礼物背包-过期列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getPackGiftExpireListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block {
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_GiftExpireList] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

#pragma mark =========== About Vip ============

/// 我的VIP信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getMyVipInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_VipMyInfo] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// VIP 配置信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getTheVipConfigWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_VipConfig] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 购买VIP-续费VIP
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toBuyTheVipWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_VipBuy] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 领取购买的VIP每日礼包
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheVipDailyGiftWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_TheVipDaily] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 领取购买的VIP礼包
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheVipGiftBagWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_TheVipGiftBag] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

// New VIP

/// VIP订单 - 订单列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheVipOrderListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_TheVipOrderList] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// VIP计划 - 配置列表信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheVipPlanListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_TheVipPlanList] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 开启或关闭神秘人
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toSetMysteriousWwitchWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_MysteriousSwitch] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}


/// 神秘人默认资料信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheMysteriousInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_MysteriousGetInfo] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// VIP计划 - 领取每日礼包
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheVipPlanDailyWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_TheVipPlanDaily] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// VIP计划 - 购买VIP-续费VIP-升级VIP
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheVipPlanBuyWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_TheVipPlanBuy] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

#pragma mark =========== About Wallet ============

/// 钱包充值 - 充值记录
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetWalletRechargeRecordWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_TheReCharegeRecord] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 用户收益信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)theUserIncomeInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_WalletUserIncome] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 钱包充值 - 商品充值预下单
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toRechargeGoodsPrePayWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_GoodsPrePay] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 钱包充值 - 商品充值支付成功回调
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)theGoodsPayBakWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_GoodsPayBak] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 钱包充值 - 订单取消
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)theGoodsCancelWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_GoodsPayCancel] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 钱包充值 - 获取商品首充配置
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)theRechargeAboutGoodsRewardWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_RechargeReward] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 钱包充值 - 商品信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheRechargeGoodsInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_RechargeGoodsInfo] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

#pragma mark =========== About Device ============

/// 设备汇报
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toReportTheDeviceInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_TheDeviceReport] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 用户钻石数
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheUserCurrentDiamondWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_GetUserDiamond] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

#pragma mark =========== About Like Click ============

/// 点赞 - 直播间点赞 - 提交
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toSubmitTheLikeClickWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_likeRoomSubmit] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 点赞 - 直播间点赞 - 列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheLikeClickListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_likeRoomList] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 点赞 - 直播间点赞配置
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheLikeConfingWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_likeRoomConfig] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

#pragma mark =========== About GiftPack ============

/// 礼包信息 - 预下单
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheGiftPackPreOrderWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_GiftPackPerOrder] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 礼包信息 - 获取
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheGiftPackListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_GiftPackList] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 礼包信息 - 支付回调
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)theGiftPackCallBackWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_GiftPackCallBack] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

#pragma mark =========== About Red Rain ============

/// 抢红包雨结果提交
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toSubmitRedRainResultWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_RedRainSubmit] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 抢红包雨名额
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toRequestTheRedRainWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_RedRainRequest] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

#pragma mark =========== About Wame ============

/// 信息 - 列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetWameListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_WameInfoList] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 进入
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toEnterWameWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_WameInfoEnter] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

#pragma mark =========== Sign Task ============

/// 签到任务 - 签到信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheSignTaskInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_SignTaskInfo] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 签到任务 - 签到 - 提交
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toSubmitTheSignTaskAboutSignWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_SignTaskSubmit] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

#pragma mark =========== Red Envelope ============

/// 获取红包相关配置
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheRedEnvelopeConfigWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_RedEnvelopeConfig] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 发红包
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toSendTheRedEnvelopeConfigWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_RedEnvelopeSend] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            //没钱弹窗继续
            [self handleError:data];
            block(data, nil);
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 获取红包领取情况
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheRedEnvelopeReceivingInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_RedEnvelopeReceivedInfo] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 领红包
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toReceiveTheRedEnvelopeWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_RedReceive] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 获取房间红包列表信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheRedEnvelopeListOfRoomWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_RedListOfRoom] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 获取用户已发红包列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheUserSendRecordWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_RedUserSendRecord] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 获取用户领红包列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheUserReceiveRecordWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_RedUserReceiveRecord] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 获取指定红包详情
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheRedEnvelopeInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_RedEvnelopeGetInfo] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

#pragma mark =========== Big Winner ============

/// 大赢家活动 - 已经结束的列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getTheBigWinRecordListWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_BigWinRecord] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 大赢家活动 - 当前正在进行的列表
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getTheBigWinListDataWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_BigWinWinList] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 大赢家活动 - 最近中奖记录
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getTheBigWinLatelyListDataWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_BigWinWinLately] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 大赢家活动 - 获取活动最后参加记录
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getTheBigWinLastDataWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_BigWinWinLast] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 大赢家活动 - 参加活动
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toJoinTheBigWinWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_BigWinJoin] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 大赢家活动 - 活动详情
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getTheBigWinDetailWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_BigWinDetail] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 弹框 - APP 弹框信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getTheDialogInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_DialogGet] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 领取新人礼包
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)claimNewUserGiftPackWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block {
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_ClaimGiftPack] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}


/// 当前样式配置
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getThemeWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block {
    // 定义本接口缓存的有效时长:24小时
    const static NSTimeInterval kRequestThemeCacheDuration = 24 * 3600;
    if (kHttpManager.responseCacheDict[kNetPath_Code_ThemeGet]) {
        MOApiResponseCacheModel *cacheModel = kHttpManager.responseCacheDict[kNetPath_Code_ThemeGet];
        NSTimeInterval nowTime = [[NSDate date] timeIntervalSince1970];
        if (nowTime < cacheModel.responseTime + kRequestThemeCacheDuration) {
            // 读取缓存数据,主线程返回
            dispatch_async(dispatch_get_main_queue(), ^{
                block(cacheModel.responseData, nil);
            });
            return;
        }
    }
    
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_ThemeGet] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                if (kCode_Success){
                    // 接口数据业务正常返回，缓存数据
                    [kHttpManager cacheApiData:data key:kNetPath_Code_ThemeGet];
                }
                
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

#pragma mark =========== 全民代理 ============
/// 获取用户代理绑定状态
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getAffiliateStateWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block {
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_AffiliateState] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 绑定上级
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)bindAffiliateWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block {
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_BindAffiliate] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 代理账户 - 获取当前可领取钻石数
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getAffiliateAccountWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block {
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_GetAffiliateAccount] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

#pragma mark =========== 充值返利 ============
- (void)getBadgeListDataWithParams:(id)params needCache:(BOOL)cache andBlock:(void (^)(id data, NSError *error))block {
    // 定义本接口缓存的有效时长:15分钟
    const static NSTimeInterval kRequestBadgeCacheDuration = 15 * 60;
    if (kHttpManager.responseCacheDict[kNetPath_Code_BadgeList] && cache) {
        MOApiResponseCacheModel *cacheModel = kHttpManager.responseCacheDict[kNetPath_Code_BadgeList];
        NSTimeInterval nowTime = [[NSDate date] timeIntervalSince1970];
        if (nowTime < cacheModel.responseTime + kRequestBadgeCacheDuration) {
            // 读取缓存数据,主线程返回
            dispatch_async(dispatch_get_main_queue(), ^{
                block(cacheModel.responseData, nil);
            });
            return;
        }
    }
    
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_BadgeList] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                if (kCode_Success && cache){
                    // 接口数据业务正常返回，缓存数据
                    [kHttpManager cacheApiData:data key:kNetPath_Code_BadgeList];
                }
                
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

#pragma mark =========== 翻译 ============

/// 获得当前用户的语言配置
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheTranslationInfoAboutMyWith:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_TranslationSteamGet] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 获取支持的语言配置
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheTranslationConfigWith:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_TranslationSteamConfig] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 设置当前用户的语言配置
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toSettingTheTranslationConfigWith:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_TranslationSteamSetting] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 翻译 (文本翻译接口
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toTranslationTheContentWith:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_TranslationText] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

#pragma mark =========== Beauty ============

/// 火山美颜+ar礼物物料相关控制器
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheBaseMaterialHuoShanInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_BaseMaterialHuoShan] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 用户信息 - 美颜信息设置
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toSettingTheUserBeautyInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_UserSettingBeauty] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 获取用户信息设置
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)toGetTheUserBeautyInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_GetUserBeauty] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

#pragma mark - Error Handling
- (BOOL)handleError:(id)data{
    NSInteger code = [data[@"code"] integerValue];
    
    if(code == 100004){
        //其他设备登录
        
        SendNotification(@"kNotification_CloseTheRTC")
        
        //如果已经执行了登出操作, 则不再执行kNotification_AgainLogin通知
        NSString *tokenString = GetToken;
        if(tokenString.length == 0){
            return NO;
        }
        
        SendObjNotification(@"kNotification_AgainLogin", data);
        return NO;
    }
    
    if(code == 30001){
        //没钱, 提示充值
        SendNotification(@"kNotification_NoMoney")
        return NO;
    }
    
    if(code == 40001){
        //点赞 没有绑定手机
        SendNotification(@"kNotification_NoBindPhone")
        return NO;
    }
    
    if(code == 70001){
        //提示验证超时
        [MBProgressHUD showTipMessageInWindow:NSLocalString(@"mimo_check_long_time")];
        return NO;
    }
    
    
    return YES;
}

#pragma mark - Other
- (void)toCheckTheUserAboutChannelStatusWith:(id)params andBlock:(void (^)(id data, NSError *error))block{
    //https://doc.shengwang.cn/doc/rtc/restful/channel-management/operations/get-user-property
    NSString *baseUrl = @"https://api.sd-rtn.com/dev/v1/channel/user/property";
    NSString *pathStr = [NSString stringWithFormat:@"%@/%@/%@",AgoraAppID,params[@"uid"],params[@"channelName"]];
    [[MOOtherNetAPIClient jsonClientWithBaseUrl:baseUrl] requestJsonDataWithPath:pathStr withParams:nil withMethodType:Get andBlock:^(id  _Nonnull data, NSError * _Nonnull error) {
        if (data)
        {
            block(data, nil);
        }
        else
        {
            block(nil, error);
        }
    }];
}

#pragma mark =========== 盲盒礼物 ============
/// 盲盒礼物 - 抽奖
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)drawBlindBoxWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block {
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_BlindBoxDraw] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

#pragma mark =========== 平台货币调整 ============
/// 获取用户金豆信息
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getGoldBeanInfoWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block {
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_GoldBeanInfo] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 金豆转换钻石
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)exchangeGoldBeanToDiamondWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block {
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_GoldBeanConvertDiamond] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 金豆转换法币
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)exchangeGoldBeanToCashWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block {
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_GoldBeanConvertCash] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

/// 获取法币汇率
/// - Parameters:
///   - params: 参数
///   - block: 回调
- (void)getGoldBeanExchangeRateWithParams:(id)params andBlock:(void (^)(id data, NSError *error))block {
    [[MONetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@",kNetPath_Code_GoldBeanExchangeRate] withParams:params withMethodType:Post andBlock:^(id data, NSError *error)
     {
        if (data)
        {
            if ([self handleError:data])
            {
                block(data, nil);
            }
        }
        else
        {
            block(nil, error);
        }
    }];
}

@end
