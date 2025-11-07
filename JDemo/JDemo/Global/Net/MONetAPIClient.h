//
//  MONetAPIClient.h
//  MiMoLive
//
//  Created by SuperC on 2023/10/12.
//

#import <AFNetworking/AFNetworking.h>
#import "MOAPIUrl.h"

NS_ASSUME_NONNULL_BEGIN

@interface MONetAPIClient : AFHTTPSessionManager

/// 单例
+ (MONetAPIClient *)sharedJsonClient;

/// 初始base url
/// @param baseUrl base url
+ (MONetAPIClient *)jsonClientWithBaseUrl:(NSString *)baseUrl;

/// 销毁单例
+ (void)attempDealloc;

/// 请求(默认)
/// @param aPath 路径
/// @param params 参数
/// @param networkMethodInt 请求类型
/// @param block 回调
- (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSDictionary*)params
                 withMethodType:(int)networkMethodInt
                       andBlock:(void (^)(NSDictionary * _Nullable data, NSError * _Nullable error))block;

/// 请求(自定义超时时间)
/// @param aPath 路径
/// @param params 参数
/// @param networkMethodInt 请求类型
/// @param requestTimeout 请求超时时间
/// @param block 回调
- (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSDictionary*)params
                 withMethodType:(int)networkMethodInt
                 requestTimeout:(NSTimeInterval)requestTimeout
                       andBlock:(void (^)(id data, NSError *error))block;

/// 上传数据
/// @param aPath 路径
/// @param data 数据
/// @param type 类型
/// @param params 参数
/// @param networkMethodInt 请求类型
/// @param progressHandler 进度
/// @param block 回调
- (NSURLSessionDataTask *)requestJsonDataWithPath:(NSString *)aPath
                       withData:(NSData *)data
                       withType:(NSString *)type
                     withParams:(NSDictionary*)params
                 withMethodType:(int)networkMethodInt
            withProgressHandler:(void (^)(NSProgress *))progressHandler
                       andBlock:(void (^)(id data, NSError *error))block;

@end

NS_ASSUME_NONNULL_END
