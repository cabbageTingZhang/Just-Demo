//
//  MOCustomTabBar.m
//  MiMoLive
//
//  Created by SuperC on 2025/9/25.
//

#import "MOCustomTabBar.h"

@implementation MOCustomTabBar

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (self.hidden) {
        return [super hitTest:point withEvent:event];
    }
    
    // 把坐标转到自定义的 view 上
    CGPoint newPoint = [self.customTabBarView convertPoint:point fromView:self];
    if (CGRectContainsPoint(self.customTabBarView.bounds, newPoint)) {
        return [self.customTabBarView hitTest:newPoint withEvent:event];
    }
    
    return [super hitTest:point withEvent:event];
}

@end
