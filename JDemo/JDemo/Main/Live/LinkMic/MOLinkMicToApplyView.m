//
//  MOLinkMicToApplyView.m
//  MiMoLive
//
//  Created by SuperC on 2025/8/21.
//

#import "MOLinkMicToApplyView.h"

@interface MOLinkMicToApplyView ()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UILabel *titleLab;

@property (nonatomic, strong) BigBtn *closeBtn;

@property (nonatomic, strong) UIImageView *headImgView;

@property (nonatomic, strong) UIButton *rejectBtn;
@property (nonatomic, strong) UIButton *acceptBtn;

@property (nonatomic, assign) NSInteger theSecond;//倒计时

@end

@implementation MOLinkMicToApplyView

- (instancetype)init {
    if (self = [super init] ) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    [self addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(@(kScaleWidth(231.0)));
    }];
    
    [self addSubview:self.headImgView];
    [self.headImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.bgView.mas_top).offset(-36.0);
        make.width.height.equalTo(@72.0);
    }];
    
    [self.bgView addSubview:self.closeBtn];
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView).offset(12.0);
        make.right.equalTo(self.bgView).offset(-12.0);
        make.width.height.equalTo(@24.0);
    }];
    
    [self.bgView addSubview:self.rejectBtn];
    [self.rejectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(12.0);
        make.height.equalTo(@44.0);
        make.bottom.equalTo(self.bgView).offset(-46.0);
        make.width.equalTo(@140.0);
    }];
    
    [self.bgView addSubview:self.acceptBtn];
    [self.acceptBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@44.0);
        make.right.equalTo(self.bgView).offset(-12.0);
        make.centerY.equalTo(self.rejectBtn);
        make.left.equalTo(self.rejectBtn.mas_right).offset(7.0);
    }];
    
    [self.bgView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImgView.mas_bottom).offset(16.0);
        make.left.equalTo(self.bgView).offset(60.0);
        make.right.equalTo(self.bgView).offset(-60.0);
        make.bottom.equalTo(self.rejectBtn.mas_top).offset(-30.0);
    }];
}

- (void)setAnchorInfo:(MOUserProfile *)anchorInfo{
    _anchorInfo = anchorInfo;
    
    [self.headImgView sd_setImageWithURL:[NSURL URLWithString:anchorInfo.avatar] placeholderImage:[UIImage imageNamed:@"icon_mine_placeHolder"]];
}

- (void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
    
    self.titleLab.text = titleStr;
}

- (void)showLinkMicToApplyView{
    self.theSecond = 11;
    
    self.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
    
    CGRect actionViewRect = self.bgView.frame;
    actionViewRect.origin.y = SCREENHEIGHT;
    self.bgView.frame = actionViewRect;
    
    WEAKSELF
    [UIView animateWithDuration:0.3 animations:^{
        CGRect actionViewRect = weakSelf.bgView.frame;
        actionViewRect.origin.y = SCREENHEIGHT - kScaleWidth(231.0);
        weakSelf.bgView.frame = actionViewRect;
    }];
}

- (void)dismissLinkMicToApplyView{
    //完成下移动画
    WEAKSELF
    self.viewDismissBlock ? self.viewDismissBlock() : nil;
    
    [UIView animateWithDuration:0.3 animations:^
     {
        CGRect actionSheetViewRect = weakSelf.bgView.frame;
        actionSheetViewRect.origin.y = SCREENHEIGHT;
        weakSelf.bgView.frame = actionSheetViewRect;
    } completion:^(BOOL finished)
     {
        [self removeFromSuperview];
    }];
}

- (void)oneSecondPassed{
    self.theSecond --;
    
    if(self.theSecond <= 0){
        self.timeOutBlock ? self.timeOutBlock() : nil;
        [self dismissLinkMicToApplyView];
    }
    else{
        [self.rejectBtn setTitle:[NSString stringWithFormat:@"%@(%zd)",NSLocalString(@"B20052"),self.theSecond] forState:UIControlStateNormal];
    }
}

#pragma mark - Lazy
- (UIView *)bgView{
    if(!_bgView){
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [MOTools colorWithHexString:@"#FFFFFF"];
        _bgView.layer.cornerRadius = 16.0;
        _bgView.layer.masksToBounds = YES;
        _bgView.layer.maskedCorners = kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner;
    }
    return _bgView;
}

- (UIImageView *)headImgView{
    if (!_headImgView)
    {
        _headImgView = [[UIImageView alloc] init];
        _headImgView.contentMode = UIViewContentModeScaleAspectFill;
        [_headImgView setImage:[UIImage imageNamed:@"icon_mine_placeHolder"]];
        _headImgView.layer.cornerRadius = 36.0;
        _headImgView.layer.masksToBounds = YES;
    }
    return _headImgView;
}

- (UILabel *)titleLab{
    if(!_titleLab)
    {
        _titleLab = [UILabel new];
        _titleLab.textColor = kBaseTextColor_1;
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.font = [MOTextTools semiboldFont:16.0];
        _titleLab.text = NSLocalString(@"B20054");
        _titleLab.numberOfLines = 2;
    }
    return _titleLab;
}

- (BigBtn *)closeBtn{
    if (!_closeBtn) {
        _closeBtn = [[BigBtn alloc] init];
        [_closeBtn setImage:[UIImage imageNamed:@"icon_popup_close_grey"] forState:UIControlStateNormal];
        _closeBtn.backgroundColor = [MOTools colorWithHexString:@"#000000" alpha:0.1];
        [_closeBtn addTarget:self action:@selector(closeBtnClickAction) forControlEvents:UIControlEventTouchUpInside];
        _closeBtn.layer.cornerRadius = 12.0;
        _closeBtn.layer.masksToBounds = YES;
    }
    return _closeBtn;
}

- (void)closeBtnClickAction{
    [self dismissLinkMicToApplyView];
}

- (UIButton *)rejectBtn{
    if (!_rejectBtn) {
        _rejectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rejectBtn setTitle:NSLocalString(@"B20052") forState:UIControlStateNormal];
        [_rejectBtn setFont:[MOTextTools poppinsMediumFont:16.0]];
        [_rejectBtn setTitleColor:[MOTools colorWithHexString:@"#4363FF" alpha:1.0] forState:UIControlStateNormal];
        _rejectBtn.layer.cornerRadius = 12.0;
        _rejectBtn.layer.masksToBounds = YES;
        _rejectBtn.layer.borderColor = [MOTools colorWithHexString:@"#4363FF" alpha:1.0].CGColor;
        _rejectBtn.layer.borderWidth = 1.0;
        [_rejectBtn addTarget:self action:@selector(rejectBtnClickAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rejectBtn;
}

- (void)rejectBtnClickAction{
    self.rejectBtnBtnBlock ? self.rejectBtnBtnBlock() : nil;
    
    [self dismissLinkMicToApplyView];
}

- (UIButton *)acceptBtn{
    if (!_acceptBtn) {
        _acceptBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_acceptBtn setTitle:NSLocalString(@"B20053") forState:UIControlStateNormal];
        [_acceptBtn setFont:[MOTextTools poppinsMediumFont:16.0]];
        [_acceptBtn setTitleColor:[MOTools colorWithHexString:@"#FFFFFF" alpha:1.0] forState:UIControlStateNormal];
        [_acceptBtn addTarget:self action:@selector(acceptBtnClickAction) forControlEvents:UIControlEventTouchUpInside];
        NSArray *colorArr = @[kBaseColorLeft,kBaseColorRight];
        UIImage *image = [MOTools createGradientRectImageWithBounds:CGRectMake(0, 0, 100.0, 44.0) Colors:colorArr GradientType:0];
        [_acceptBtn setBackgroundImage:image forState:UIControlStateNormal];
        _acceptBtn.layer.cornerRadius = 12.0;
        _acceptBtn.layer.masksToBounds = YES;
    }
    return _acceptBtn;
}

- (void)acceptBtnClickAction{
    self.acceptBtnBlock ? self.acceptBtnBlock() : nil;
}


@end
