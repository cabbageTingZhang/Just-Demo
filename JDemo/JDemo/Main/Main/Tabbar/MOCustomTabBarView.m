//
//  MOCustomTabBarView.m
//  MiMoLive
//
//  Created by MiMo on 2025/6/17.
//

#import "MOCustomTabBarView.h"
#import "MOTabBarButton.h"

@interface MOCustomTabBarView ()

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) NSArray<MOTabBarButton *> *buttons;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) UILabel *badgeLab;

@end

@implementation MOCustomTabBarView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.backgroundColor = UIColor.clearColor;

    // 圆角白底背景
    self.backgroundView = [[UIView alloc] init];
    self.backgroundView.backgroundColor = [UIColor whiteColor];
    self.backgroundView.layer.cornerRadius = 28;
    [self addSubview:self.backgroundView];
    
    // Shadow effect for backgroundView
    self.backgroundView.layer.shadowColor = [MOTools colorWithHexString:@"#404780" alpha:0.1].CGColor;
    self.backgroundView.layer.shadowOpacity = 1.0; // Full opacity for the shadow color
    self.backgroundView.layer.shadowOffset = CGSizeMake(0, 2); // Offset (X: 0pt, Y: 2pt)
    self.backgroundView.layer.shadowRadius = 4; // Blur radius (4pt)
    self.backgroundView.layer.masksToBounds = NO; // Allow shadow to be visible outside bounds

    // 图标按钮（4 个）
    NSArray *icons = @[@"icon_tabbar_home", @"icon_tabbar_explore", @"icon_tabbar_message", @"icon_tabbar_mine"];
    NSMutableArray *btns = [NSMutableArray array];

    for (NSInteger i = 0; i < icons.count; i++) {
        MOTabBarButton *btn = [MOTabBarButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:icons[i]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_selected", icons[i]]] forState:UIControlStateSelected];
        btn.tag = i;
        [btn addTarget:self action:@selector(onTabClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [btns addObject:btn];
        
        if (i == 0) {//默认选中第一个
            btn.selected = YES;
        }
    }

    self.buttons = btns;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (self.isHidden || self.alpha < 0.01 || !self.userInteractionEnabled) {
        return nil;
    }

    CGRect expandedBounds = CGRectInset(self.bounds, 0, -20);
    if (CGRectContainsPoint(expandedBounds, point)) {
        for (UIView *subview in self.subviews.reverseObjectEnumerator) {
            CGPoint convertedPoint = [self convertPoint:point toView:subview];
            UIView *hitView = [subview hitTest:convertedPoint withEvent:event];
            if (hitView) {
                return hitView;
            }
        }
        return self;
    }
    return nil;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    CGFloat barHeight = 80.0 + kBottomSafeAreaInset;

    self.frame = CGRectMake(0, self.superview.bounds.size.height - barHeight, SCREENWIDTH, barHeight);

    // 白色背景容器
    self.backgroundView.frame = CGRectMake(24, 16, SCREENWIDTH - 48, 56);

    // 平均分布按钮
    CGFloat itemWidth = self.backgroundView.bounds.size.width / self.buttons.count;
    for (NSInteger i = 0; i < self.buttons.count; i++) {
        MOTabBarButton *btn = self.buttons[i];
        btn.frame = CGRectMake(CGRectGetMinX(self.backgroundView.frame) + i * itemWidth,
                               CGRectGetMinY(self.backgroundView.frame),
                               itemWidth,
                               56);
        
        if(i == 2){//IM未读数
            self.badgeLab.frame = CGRectMake(0, 23, self.badgeLab.width, 16);
            self.badgeLab.centerX = btn.centerX + 10;
            [self addSubview:self.badgeLab];
        }
    }
}

- (void)onTabClicked:(UIButton *)sender {
    [self setSelectedIndex:sender.tag];
    if ([self.delegate respondsToSelector:@selector(customTabBarDidSelectIndex:)]) {
        [self.delegate customTabBarDidSelectIndex:sender.tag];
    }
}

- (void)setSelectedIndex:(NSInteger)index {
    self.currentIndex = index;
    for (NSInteger i = 0; i < self.buttons.count; i++) {
        self.buttons[i].selected = (i == index);
    }
}

- (void)setIMUnreadMsgCount:(NSString *)badgeString {
    self.badgeLab.text = badgeString;
    if ([badgeString isEqualToString:@""]) {
        self.badgeLab.hidden = YES;
    } else {
        self.badgeLab.hidden = NO;
    }
    if ([badgeString isEqualToString:@"99+"]) {
        self.badgeLab.width = 20;
    } else {
        self.badgeLab.width = 16;
    }
    _badgeValue = badgeString;
}

- (UILabel *)badgeLab {
    if (!_badgeLab) {
        _badgeLab = [[UILabel alloc] init];
        _badgeLab.backgroundColor = [MOTools colorWithHexString:@"#FB5374" alpha:1.0];
        _badgeLab.font = [MOTextTools getTheFontWithSize:10.0 AndFontName:kNormalContentFontStr];
        _badgeLab.textColor = [UIColor whiteColor];
        _badgeLab.layer.cornerRadius = 8.0;
        _badgeLab.layer.masksToBounds = YES;
        _badgeLab.textAlignment = NSTextAlignmentCenter;
    }
    return _badgeLab;
}

@end
