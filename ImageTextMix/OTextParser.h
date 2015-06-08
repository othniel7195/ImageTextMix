//
//  OTextParser.h
//  ImageTextMix
//
//  Created by 赵锋 on 15/6/8.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//
//   文字解析器  普通文字转属性文字

#import <Foundation/Foundation.h>

@interface OTextParser : NSObject
/** 属性文字*/
@property(nonatomic, copy) NSAttributedString *attributedText;
/** 普通文字*/
@property(nonatomic, copy) NSString *text;
@end
