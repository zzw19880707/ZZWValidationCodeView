//
//  ValidationCodeView.h
//  standard
//
//  Created by 佐筱猪 on 14/11/4.
//  Copyright (c) 2014年 佐筱猪. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  推荐宽度大于70.高度25到30
 *  最低宽度20.如果要修改，需要修改CHAR_HEIGH的大小
 *  自动生成5个0~9a~zA~Z的字符。需要修改长度，则修改CODE_LENGTH的长度
 */
@interface ValidationCodeView : UIView

@property (nonatomic, strong ) NSString *code ;
@end
