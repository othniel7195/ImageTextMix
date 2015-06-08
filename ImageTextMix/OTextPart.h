//
//  OTextPart.h
//  ImageTextMix
//
//  Created by 赵锋 on 15/6/8.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OTextPart : NSObject

/**text  这段文字的内容 */
@property(nonatomic, copy) NSString *text;
/**range 这段文字的范围 */
@property(nonatomic, assign) NSRange range;
/**special 是否为特殊的文字  特殊文字要加颜色 */
@property(nonatomic, assign, getter=isSpecial) BOOL special;
/**emotion 是否为表情*/
@property(nonatomic, assign, getter=isEmotion) BOOL emotion;

@end
