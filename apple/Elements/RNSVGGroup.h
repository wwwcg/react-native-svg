/**
 * Copyright (c) 2015-present, Horcrux.
 * All rights reserved.
 *
 * This source code is licensed under the MIT-style license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import <Foundation/Foundation.h>

#import "RNSVGUIKit.h"

#import "RNSVGContainer.h"
#import "RNSVGCGFCRule.h"
#import "RNSVGSvgView.h"
#import "RNSVGPath.h"
#import "RNSVGGlyphContext.h"

@interface RNSVGGroup : RNSVGPath <RNSVGContainer>

@property (nonatomic, strong) NSDictionary *font;

#pragma mark -
/// 以下是设置文本样式的一些属性
///
/// 说明：兼容hippy-react-svg前端的简略写法
/// 原RNSVG是将部分文字样式合并到font字段一起设置，因此其iOS SDK无需增加该属性。
/// 曲线救国方案：在pushGlyphContext前将其加入font字典中
@property (nonatomic, strong) id kerning;
@property (nonatomic, strong) id fontSize;
@property (nonatomic, strong) NSString *fontData;
@property (nonatomic, strong) NSString *fontStyle;
@property (nonatomic, strong) id fontWeight;
@property (nonatomic, strong) NSString *fontFamily;
@property (nonatomic, strong) NSString *textAnchor;
@property (nonatomic, strong) id wordSpacing;
@property (nonatomic, strong) id letterSpacing;
@property (nonatomic, strong) NSString *textDecoration;
@property (nonatomic, strong) NSString *fontVariantLigatures;

#pragma mark -

- (void)renderPathTo:(CGContextRef)context rect:(CGRect)rect;
- (void)renderGroupTo:(CGContextRef)context rect:(CGRect)rect;

- (RNSVGGlyphContext *)getGlyphContext;
- (void)pushGlyphContext;
- (void)popGlyphContext;
@end
