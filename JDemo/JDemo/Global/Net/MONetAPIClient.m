//
//  MONetAPIClient.m
//  MiMoLive
//
//  Created by SuperC on 2023/10/12.
//

#import "MONetAPIClient.h"
#import "MOUploadDeviceTool.h"
#import "Reachability+More.h"
#import "NSString+YYAdd.h"
#import "NSBundle+language.h"
#import <AdjustSdk/AdjustSdk.h>

static MONetAPIClient *_sharedClient = nil;
static dispatch_once_t onceToken;

//默认的请求超时时间 (默认30秒)
const static NSTimeInterval kRequestTimeout = 30.0;

@interface MONetAPIClient ()

@property (nonatomic, strong) ADJAttribution *attribution;

@end

@implementation MONetAPIClient

+ (MONetAPIClient *)sharedJsonClient
{
    dispatch_once(&onceToken, ^
    {
        _sharedClient = [[MONetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:kNetPath_Base]];
    });
    return _sharedClient;
}

+ (MONetAPIClient *)jsonClientWithBaseUrl:(NSString *)baseUrl
{
    if ([baseUrl isEqualToString:@""] ||baseUrl == nil)
    {
        _sharedClient = [[MONetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:kNetPath_Base]];
    }
    else
    {
        _sharedClient = [[MONetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:baseUrl]];
    }
    return _sharedClient;
}

+ (void)attempDealloc
{
    onceToken = 0;
    _sharedClient = nil;
    
    MOLogV(@"setHttpHeaderData:::: dealloc");
}

- (id)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (!self)
    {
        return nil;
    }
    
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html",nil];
   
    self.requestSerializer = [AFJSONRequestSerializer serializer];
    self.requestSerializer.timeoutInterval = kRequestTimeout;
 
    //证书校验模式为None
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    securityPolicy.validatesDomainName = NO;
    self.securityPolicy = securityPolicy;
    
    WEAKSELF
    [Adjust attributionWithCompletionHandler:^(ADJAttribution * _Nullable attribution) {
        weakSelf.attribution = attribution;
    }];
    
    return self;
}

- (void)requestJsonDataWithPath:(NSString *)aPath withParams:(NSDictionary*)params withMethodType:(int)networkMethodInt andBlock:(void (^)(NSDictionary * _Nullable data, NSError * _Nullable error))block
{
    [self requestJsonDataWithPath:aPath withParams:params withMethodType:networkMethodInt requestTimeout:kRequestTimeout andBlock:block];
}

- (void)requestJsonDataWithPath:(NSString *)aPath withParams:(NSDictionary*)params withMethodType:(int)networkMethodInt requestTimeout:(NSTimeInterval)requestTimeout andBlock:(void (^)(id data, NSError *error))block{
    //判断请求超时时间是否符合要求
    if (fabs(requestTimeout - self.requestSerializer.timeoutInterval) > 0.1)
    {
        self.requestSerializer.timeoutInterval = requestTimeout;
    }
    
    //log请求数据
    //增加域名信息打印，方便排查问题
    MOLogV(@"\n===========request===========\n%@%@:\n%@",self.baseURL.absoluteString,aPath,params);
    
    [self setHttpHeaderDataWith:params.modelToJSONString];
    
    //发起请求
    switch (networkMethodInt)
    {
        case Get:
        {
            [self GET:aPath parameters:params headers:nil progress:^(NSProgress * _Nonnull downloadProgress)
            {
                
            }
            success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
            {
                //添加接口访问时长计算
                NSTimeInterval apiEndTime = [[NSDate date] timeIntervalSince1970];
                NSUInteger endTimestamp = apiEndTime * 1000;
                
                
                MOLogV(@"=====> %@ response:%@",aPath,responseObject);
                id error = [self handleResponse:responseObject];
                if (error)
                {
                    
                    block(nil, error);
                }
                else
                {
                    block(responseObject, nil);
                }
            }
            failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
            {
                block(nil, error);
            }];
            break;
        }
        case Post:
        {
            [self POST:aPath parameters:params headers:nil progress:^(NSProgress * _Nonnull uploadProgress)
            {
    
            }
            success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
            {
                MOLogV(@"=====> %@ response:%@",aPath,responseObject);
                id error = [self handleResponse:responseObject];
                if (error)
                {
                    block(nil, error);
                }
                else
                {
                    block(responseObject, nil);
                }
            }
            failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
            {
                block(nil, error);
            }];
            break;
        }
        case Put:
        {
            [self PUT:aPath parameters:params headers:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
            {
                MOLogV(@"=====> %@ response:%@",aPath,responseObject);
                id error = [self handleResponse:responseObject];
                if (error)
                {
                    block(nil, error);
                }
                else
                {
                    block(responseObject, nil);
                }
            }
            failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
            {
                block(nil, error);
            }];
            break;
        }
        case Delete:
        {
            [self DELETE:aPath parameters:params headers:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
            {
                MOLogV(@"=====> %@ response:%@",aPath,responseObject);
                id error = [self handleResponse:responseObject];
                if (error)
                {
                    block(nil, error);
                }
                else
                {
                    block(responseObject, nil);
                }
            }
            failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
            {
                block(nil, error);
            }];
            break;
        }
        default:
            break;
    }
}

- (NSURLSessionDataTask *)requestJsonDataWithPath:(NSString *)aPath withData:(NSData *)data withType:(NSString *)type withParams:(NSDictionary *)params withMethodType:(int)networkMethodInt withProgressHandler:(void (^)(NSProgress *))progressHandler andBlock:(void (^)(id, NSError *))block
{
    self.requestSerializer.timeoutInterval = 600;
    
    NSURLSessionDataTask *task = nil;
    switch (networkMethodInt)
    {
        case Post:
        {
            //DDLogDebug(@"-----> request chatserver[post] %@\n params:%@\n headers:%@",aPath,params,self.requestSerializer.HTTPRequestHeaders);
            task = [self POST:aPath parameters:params headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
            {
                if (data)
                {
                    if ([type hasPrefix:@"image"] || [type hasPrefix:@"f_image"])
                    {
                        [formData appendPartWithFileData:data name:@"file" fileName:[NSString stringWithFormat:@"%@.%@",[NSString stringWithFormat:@"%lu",(unsigned long)[data hash]], [type stringByReplacingOccurrencesOfString:@"image/" withString:@""]] mimeType:type];
                    }
                }
            }
            progress:^(NSProgress * _Nonnull uploadProgress)
            {
                progressHandler?progressHandler(uploadProgress):nil;
            }
            success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
            {
                id error = [self handleResponse:responseObject];
                if (error)
                {
                    
                    block(nil, error);
                }
                else
                {
                    block(responseObject, nil);
                }
            }
            failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
            {
                block(nil, error);
            }];
            break;
        }
    }
    return task;
}

#pragma mark -- 错误码处理 --
- (id)handleResponse:(id)responseJSON
{
    NSError *error = nil;
    
    if ([responseJSON isKindOfClass:[NSArray class]])
    {
        return error;
    }
    
    //code为非0值时，表示有错
    NSNumber *resultCode = [responseJSON valueForKeyPath:@"ErrorCode"];
    if (resultCode.intValue!=0)
    {
        error = [NSError errorWithDomain:kNetPath_Base code:resultCode.intValue userInfo:responseJSON];
        return error;
    }
    return error;
}

- (void)setHttpHeaderDataWith:(NSString *)bodyStr{
    
    int64_t timestamp = round([[NSDate date] timeIntervalSince1970]*1000);
    
    //Adjust
//    ADJAttribution *adjInfo = [Adjust attribution];
    
    //生成一个随机的10位字符串
    NSString *randomString = [self getIDRandom];
    NSString *timeString = [NSString stringWithFormat:@"%lld",timestamp];
    NSString *idString = [NSString stringWithFormat:@"%@-%@",randomString,timeString];
    
    //id
    [self.requestSerializer setValue:idString forHTTPHeaderField:@"id"];
    NSString *signStr = [self addNewStringWith:@"" AndNeedStr:idString];
    
    //udid
    NSString *udid = [MOUploadDeviceTool shareTool].adid;
    if (udid.length > 0) {
        [self.requestSerializer setValue:udid forHTTPHeaderField:@"udid"];
    }
    signStr = [self addNewStringWith:signStr AndNeedStr:udid];
    
    //app
    NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
    if(bundleIdentifier.length > 0){
        [self.requestSerializer setValue:bundleIdentifier forHTTPHeaderField:@"app"];
    }
    signStr = [self addNewStringWith:signStr AndNeedStr:bundleIdentifier];
    
    //device
    UIDevice *device = [UIDevice currentDevice];
    NSString *deviceModelString = device.model;
    if(deviceModelString.length > 0){
        [self.requestSerializer setValue:deviceModelString forHTTPHeaderField:@"device"];
    }
    signStr = [self addNewStringWith:signStr AndNeedStr:deviceModelString];
    
    //plaform 2 = Apple
    [self.requestSerializer setValue:@"2" forHTTPHeaderField:@"platform"];
    signStr = [self addNewStringWith:signStr AndNeedStr:@"2"];
    
    //channel
   __block NSString *channelStr = @"apple";
    
    if (self.attribution.network.length > 0) {
        channelStr = [NSString stringWithFormat:@"%@/%@",channelStr,self.attribution.network];
    }
    
    if (self.attribution.campaign.length > 0) {
        channelStr = [NSString stringWithFormat:@"%@/%@",channelStr,self.attribution.campaign];
    }
    [self.requestSerializer setValue:channelStr forHTTPHeaderField:@"channel"];
    signStr = [self addNewStringWith:signStr AndNeedStr:channelStr];
    
//    if(adjInfo){
//        if(adjInfo.network.length > 0){
//            channelStr = [NSString stringWithFormat:@"%@/%@",channelStr,adjInfo.network];
//        }
//        
//        if(adjInfo.campaign.length > 0){
//            channelStr = [NSString stringWithFormat:@"%@/%@",channelStr,adjInfo.campaign];
//        }
//    }
    
    //api
    [self.requestSerializer setValue:@"1" forHTTPHeaderField:@"api"];
    signStr = [self addNewStringWith:signStr AndNeedStr:@"1"];
    
    //version
    NSString *versionString = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [self.requestSerializer setValue:versionString forHTTPHeaderField:@"version"];
    signStr = [self addNewStringWith:signStr AndNeedStr:versionString];
    
    //MARK: network
    //network
    NSString *networkString = [Reachability netName];
    [self.requestSerializer setValue:networkString forHTTPHeaderField:@"network"];
    signStr = [self addNewStringWith:signStr AndNeedStr:networkString];
    
    //time
    [self.requestSerializer setValue:timeString forHTTPHeaderField:@"time"];
    signStr = [self addNewStringWith:signStr AndNeedStr:timeString];
    
//    //测试环境, 可以跳过签名验证
//    if (kAPP_Environment == 2){
//        [self.requestSerializer setValue:@"a66888" forHTTPHeaderField:@"test-skip"];
//    }
    
    //token
    NSString *tokenString = GetToken;
    if(tokenString.length > 0)
    {
        [self.requestSerializer setValue:tokenString forHTTPHeaderField:@"token"];
    }
    else{
        tokenString = @"";
        [self.requestSerializer setValue:tokenString forHTTPHeaderField:@"token"];
    }
    signStr = [self addNewStringWith:signStr AndNeedStr:tokenString];
    
    
    signStr = [self addNewStringWith:signStr AndNeedStr:@"abc|abc|edg|9527|1234"];
    signStr = [self addNewStringWith:signStr AndNeedStr:bodyStr];
    NSString *md5Str = [signStr md5String];
    [self.requestSerializer setValue:md5Str forHTTPHeaderField:@"sign"];
    
    NSString *currentLanguage = [NSBundle currentLanguage];
    [self.requestSerializer setValue:currentLanguage forHTTPHeaderField:@"Accept-Language"];
}

- (NSString *)addNewStringWith:(NSString *)oldStr AndNeedStr:(NSString *)str{
    
    if(!str || str.length == 0){
        str = @"";
    }
    
    oldStr = [oldStr stringByAppendingString:str];
    return oldStr;
    
}

- (NSString *)getIDRandom{
    // 声明一个字符数组，包含所有可能的字符
    NSString *characters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
      
    // 初始化一个空字符串，用来存储随机生成的字符串
    NSString *randomString = [[NSString alloc] init];
      
    // 生成10个随机的字符并拼接到 randomString 中
    for (int i = 0; i < 10; i++) {
        int randomIndex = arc4random() % [characters length];
        randomString = [randomString stringByAppendingString: [characters substringWithRange: NSMakeRange(randomIndex, 1)]];
    }
      
    // 输出结果
    return randomString;
}

@end
