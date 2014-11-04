//
//  ValidationCodeView.m
//  standard
//
//  Created by 佐筱猪 on 14/11/4.
//  Copyright (c) 2014年 佐筱猪. All rights reserved.
//

#import "ValidationCodeView.h"
#define CODE_LENGTH 5
#define CHAR_HEIGH 16
@implementation ValidationCodeView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self drawCode];
        [self addGesture];
        
    }
    return self;
}
-(void)awakeFromNib{
    [self drawCode];
    [self addGesture];

}

-(void)addGesture{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [tapGesture setNumberOfTapsRequired:1];
    [self addGestureRecognizer:tapGesture];
    
}
-(void)tapAction:(UITapGestureRecognizer *)tapGesture{
    [self drawCode];
}
-(void)drawCode {
//  移除所有视图
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
//  生成随机背景颜色
    float red = arc4random() % 100 / 100.0;
    float green = arc4random() % 100 / 100.0;
    float blue = arc4random() % 100 / 100.0;
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:0.2];
    [self setBackgroundColor:color];
    
//  生成随机验证码
    const int count = CODE_LENGTH;
    char data[count];
    for (int x = 0; x < count; x++) {
        int j = '0' + (arc4random_uniform(75));
        if((j >= 58 && j <= 64) || (j >= 91 && j <= 96)){
            --x;
        }else{
            data[x] = (char)j;
        }
    }
    NSString *text = [[NSString alloc] initWithBytes:data
                                              length:count encoding:NSUTF8StringEncoding];
    self.code = text;
    
//    把验证码添加到view上
    CGSize cSize = [@"S" sizeWithFont:[UIFont systemFontOfSize:CHAR_HEIGH]];
    int width = self.frame.size.width / text.length - cSize.width;
    int height = self.frame.size.height - cSize.height;
    CGPoint point;
    float pX, pY;
    for (int i = 0, count = text.length; i < count; i++) {
        pX = arc4random() % width + self.frame.size.width / text.length * i - 1;
        pY = arc4random() % height;
        point = CGPointMake(pX, pY);
        unichar c = [text characterAtIndex:i];
        UILabel *tempLabel = [[UILabel alloc]
                              initWithFrame:CGRectMake(pX, pY,
                                                       self.bounds.size.width / 4,
                                                       self.bounds.size.height)];
        tempLabel.backgroundColor = [UIColor clearColor];
        
        // 字体颜色
        float red = arc4random() % 100 / 100.0;
        float green = arc4random() % 100 / 100.0;
        float blue = arc4random() % 100 / 100.0;
        UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
        
        NSString *textC = [NSString stringWithFormat:@"%C", c];
        tempLabel.textColor = color;
        tempLabel.text = textC;
        [self addSubview:tempLabel];
    }
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    // 干扰线
    CGContextRef context = UIGraphicsGetCurrentContext();//获得当前view的图形上下文(context)
    CGContextSetLineWidth(context, 1.0);//制定了线的宽度
    
    float pX, pY;
    float red,green,blue;
    UIColor *color;
    for(int i = 0; i < CODE_LENGTH; i++) {
//        生成随机色
        red = arc4random() % 100 / 100.0;
        green = arc4random() % 100 / 100.0;
        blue = arc4random() % 100 / 100.0;
        color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
//        设置画笔颜色
        CGContextSetStrokeColorWithColor(context, [color CGColor]);
//        坐标初始位置
        pX = arc4random() % (int)self.bounds.size.width;
        pY = arc4random() % (int)self.bounds.size.height;
//        移动到点
        CGContextMoveToPoint(context, pX, pY);
//        坐标结束位置
        pX = arc4random() % (int)self.bounds.size.width;
        pY = arc4random() % (int)self.bounds.size.height;
//        画线
        CGContextAddLineToPoint(context, pX, pY);
        CGContextStrokePath(context);
    }

}



@end
