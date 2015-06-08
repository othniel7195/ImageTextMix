//
//  OTextPart.m
//  ImageTextMix
//
//  Created by 赵锋 on 15/6/8.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "OTextPart.h"

@implementation OTextPart

-(NSString *)description
{
   return  [NSString stringWithFormat:@"text--%@ , range--%@",self.text,NSStringFromRange(self.range)];
}
@end
