//
//  TouchView.m
//  DrawingDemo
//
//  Created by zhangyafeng on 15/5/24.
//  Copyright (c) 2015年 think. All rights reserved.
//

#import "TouchView.h"

#define POINT(X)	[[self.points objectAtIndex:X] CGPointValue]

@interface TouchView()
@property (retain) NSMutableArray *points;
@property (nonatomic, strong) NSMutableArray * linesArray;
@property (nonatomic, strong) NSMutableArray *colors;
@property (nonatomic, retain) UIImage * image;
@end

@implementation TouchView




-(void)awakeFromNib
{
    self.points = [[NSMutableArray alloc] init];
    self.linesArray = [[NSMutableArray alloc] init];
    self.colors = [[NSMutableArray alloc] init];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{

    //返回NSSet中的一个对象
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    [self.points addObject:[NSValue valueWithCGPoint:point]];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self];
    [self.points addObject:[NSValue valueWithCGPoint:point]];
    //执行重画操作,调用drawRect
    [self setNeedsDisplay];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //一次线结束执行的操作
    [self addLineStore];
}


//电话呼入等事件取消时候发出
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touches Canelled");
}
-(void)addLineStore
{
    //添加points子对象
    [self.linesArray addObject:self.points];

    //创建新的points数组
    self.points = [[NSMutableArray alloc] init];
    //获取当前颜色
    [self.colors addObject:[self.viewController currentColor]];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设置颜色
    [self.color set];
    CGContextSetLineWidth(context, 4.0);
    
    if (self.linesArray.count > 0) {
        int i  = 0;
        for (NSArray *points in self.linesArray) {
            CGContextBeginPath(context);
            UIColor *color = [self.colors objectAtIndex:i];
            [color set];
            [self drawlineFromPoints:points withContext:context];
            i++;
        }
        
    }
    
    CGContextBeginPath(context);
    [self.color set];
    for (int i = 0; i < self.points.count - 1 && self.points.count > 0; i++) {
        CGPoint point1 = [self.points[i] CGPointValue];
        CGPoint point2 = [self.points[i+1] CGPointValue];
        CGContextMoveToPoint(context, point1.x, point1.y);
        CGContextAddLineToPoint(context, point2.x, point2.y);
        
        //执行画操作
        CGContextStrokePath(context);
    }

}

-(void)drawlineFromPoints:(NSArray*)points withContext:(CGContextRef)context
{

    for (int i = 0; i < points.count - 1 && points.count > 0; i++) {
        CGPoint point1 = [points[i] CGPointValue];
        CGPoint point2 = [points[i+1] CGPointValue];
        CGContextMoveToPoint(context, point1.x, point1.y);
        CGContextAddLineToPoint(context, point2.x, point2.y);
        CGContextStrokePath(context);
    }
}

-(UIImage*)imageFromView:(UIView*)view
{
    UIGraphicsBeginImageContext(view.frame.size);
    [[view layer] renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenshot;
}


-(void)setImage
{

}



@end
