//
//  ZYTableView.m
//  LXDEventChain
//
//  Created by Ray on 2017/7/30.
//  Copyright © 2017年 滕雪. All rights reserved.
//

#import "ZYTableView.h"

@implementation ZYTableView


- (UIView *)hitTest: (CGPoint)point withEvent: (UIEvent *)event
{
    NSLog(@"%@ - %@",NSStringFromClass([self class]), self.gestureRecognizers);
    return [super hitTest: point withEvent: event];
}


////-UIView走         //-UIScrollView不走
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    NSLog(@"%@ - %@",NSStringFromClass([self class]), self.gestureRecognizers);
//    [super touchesBegan:touches withEvent:event];
//}

@end
