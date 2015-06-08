//
//  OTextParser.m
//  ImageTextMix
//
//  Created by 赵锋 on 15/6/8.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "OTextParser.h"
#import "RegexKitLite.h"
#import "OTextPart.h"
#import <UIKit/UIKit.h>
@implementation OTextParser



-(NSAttributedString *)attributedTextWithText:(NSString *)text
{
    NSMutableAttributedString *attributedText=[[NSMutableAttributedString alloc] init];
    
    // 表情的规则
    NSString *emotionPattern = @"\\[[0-9a-zA-Z\\u4e00-\\u9fa5]+\\]";
    // @的规则
    NSString *atPattern = @"@[0-9a-zA-Z\\u4e00-\\u9fa5-_]+";
    // #话题#的规则
    NSString *topicPattern = @"#[0-9a-zA-Z\\u4e00-\\u9fa5]+#";
    // url链接的规则
    NSString *urlPattern = @"\\b(([\\w-]+://?|www[.])[^\\s()<>]+(?:\\([\\w\\d]+\\)|([^[:punct:]\\s]|/)))";
    NSString *pattern = [NSString stringWithFormat:@"%@|%@|%@|%@", emotionPattern, atPattern, topicPattern, urlPattern];
    
    NSMutableArray *parts = [NSMutableArray array];
    
    //遍历所有特殊字符
    [text enumerateStringsMatchedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        //如果length ==0  舍弃
        if ((*capturedRanges).length==0) return ;
        
        //其他加入数组
        OTextPart *part=[[OTextPart alloc] init];
        part.special=YES;
        part.text=*capturedStrings;
        part.emotion=[part.text hasPrefix:@"["]&&[part.text hasSuffix:@"]"];
        part.range=*capturedRanges;
        [parts addObject:part];
        
    }];
    
    //遍历所有非特殊字符
    [text enumerateStringsSeparatedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        //如果length ==0  舍弃
        if ((*capturedRanges).length==0) return ;
        
        //其他加入数组
        OTextPart *part=[[OTextPart alloc] init];
        part.text=*capturedStrings;
        part.range=*capturedRanges;
        [parts addObject:part];
        
    }];
    
    //按照 range.location 排序
    
    [parts sortedArrayUsingComparator:^NSComparisonResult(OTextPart *obj1, OTextPart *obj2) {
        
        if (obj1.range.location>obj2.range.location) return NSOrderedDescending;
        return NSOrderedAscending;
    }];
    
    UIFont *font=[UIFont systemFontOfSize:14.0];
    
    for (OTextPart *part in parts) {
        
        NSAttributedString *substr=nil;
        if (part.isEmotion) {
            NSTextAttachment *attach=[[NSTextAttachment alloc] init];
            NSString *name;//图片名字
            if (name) { // 能找到对应的图片
                attach.image = [UIImage imageNamed:name];
                attach.bounds = CGRectMake(0, -3, font.lineHeight, font.lineHeight);
                substr = [NSAttributedString attributedStringWithAttachment:attach];
            } else { // 表情图片不存在
                substr = [[NSAttributedString alloc] initWithString:part.text];
            }

        }else if(part.isSpecial)
        {
            substr = [[NSAttributedString alloc] initWithString:part.text attributes:@{
                                                                                       NSForegroundColorAttributeName : [UIColor redColor]
                                                                                       }];
        }else{
            substr = [[NSAttributedString alloc] initWithString:part.text];
        }
    
        [attributedText appendAttributedString:substr];
    }
    
    [attributedText addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, attributedText.length)];
    
    return attributedText;
}
-(void)setText:(NSString *)text
{
    _text=[text copy];
    self.attributedText = [self attributedTextWithText:text];
}
@end
