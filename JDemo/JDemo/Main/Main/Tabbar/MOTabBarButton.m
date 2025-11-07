//
//  MOTabBarButton.m
//  MiMoLive
//
//  Created by MiMo on 2025/6/30.
//

#import "MOTabBarButton.h"

@implementation MOTabBarButton

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect expandedBounds = CGRectInset(self.bounds, 0, -20); // Expand the bounds upwards by 20 points
    return CGRectContainsPoint(expandedBounds, point);
}

@end
