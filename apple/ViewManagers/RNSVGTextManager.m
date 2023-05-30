/**
 * Copyright (c) 2015-present, Horcrux.
 * All rights reserved.
 *
 * This source code is licensed under the MIT-style license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import "RNSVGTextManager.h"

#import "RNSVGText.h"
#import "RCTConvert+RNSVG.h"

@implementation RNSVGTextManager

HIPPY_EXPORT_MODULE(SVGText)

- (RNSVGRenderable *)node
{
  return [RNSVGText new];
}

HIPPY_CUSTOM_VIEW_PROPERTY(dx, id, RNSVGText)
{
    view.deltaX = [HippyConvert RNSVGLengthArray:json];
}
HIPPY_CUSTOM_VIEW_PROPERTY(dy, id, RNSVGText)
{
    view.deltaY = [HippyConvert RNSVGLengthArray:json];
}
HIPPY_CUSTOM_VIEW_PROPERTY(positionX, id, RNSVGText)
{
    view.positionX = [HippyConvert RNSVGLengthArray:json];
}

HIPPY_CUSTOM_VIEW_PROPERTY(positionY, id, RNSVGText)
{
    view.positionY = [HippyConvert RNSVGLengthArray:json];
}
HIPPY_CUSTOM_VIEW_PROPERTY(x, id, RNSVGText)
{
    view.positionX = [HippyConvert RNSVGLengthArray:json];
}

HIPPY_CUSTOM_VIEW_PROPERTY(y, id, RNSVGText)
{
    view.positionY = [HippyConvert RNSVGLengthArray:json];
}
HIPPY_CUSTOM_VIEW_PROPERTY(rotate, id, RNSVGText)
{
    view.rotate = [HippyConvert RNSVGLengthArray:json];
}
HIPPY_EXPORT_VIEW_PROPERTY(font, NSDictionary)
HIPPY_CUSTOM_VIEW_PROPERTY(inlineSize, id, RNSVGText)
{
    view.inlineSize = [HippyConvert RNSVGLength:json];
}
HIPPY_CUSTOM_VIEW_PROPERTY(textLength, id, RNSVGText)
{
    view.textLength = [HippyConvert RNSVGLength:json];
}
HIPPY_CUSTOM_VIEW_PROPERTY(baselineShift, id, RNSVGText)
{
    if ([json isKindOfClass:[NSString class]]) {
        NSString *stringValue = (NSString *)json;
        view.baselineShift = stringValue;
    } else {
        view.baselineShift = [NSString stringWithFormat:@"%f", [json doubleValue]];
    }
}
HIPPY_EXPORT_VIEW_PROPERTY(lengthAdjust, NSString)
HIPPY_EXPORT_VIEW_PROPERTY(alignmentBaseline, NSString)

//HIPPY_CUSTOM_VIEW_PROPERTY(fontSize, id, RNSVGText)
//{
//    if ([json isKindOfClass:[NSString class]]) {
//        NSString *stringValue = (NSString *)json;
//        view.font = @{ @"fontSize": stringValue };
//    } else {
//        NSNumber* number = (NSNumber*)json;
//        double num = [number doubleValue];
//        view.font = @{@"fontSize": [NSNumber numberWithDouble:num] };
//    }
//}
//
//HIPPY_CUSTOM_VIEW_PROPERTY(fontWeight, id, RNSVGText)
//{
//    if ([json isKindOfClass:[NSString class]]) {
//        NSString *stringValue = (NSString *)json;
//        view.font = @{ @"fontWeight": stringValue };
//    } else {
//        NSNumber* number = (NSNumber*)json;
//        double num = [number doubleValue];
//        view.font = @{@"fontWeight": [NSNumber numberWithDouble:num] };
//    }
//}

#pragma mark -
/// 设置文本样式的textAnchor属性
///
/// 说明：兼容hippy-react-svg前端的简略写法
/// 原RNSVG是将部分文字样式合并到font字段一起设置，因此其iOS SDK无需增加该属性。
HIPPY_EXPORT_VIEW_PROPERTY(kerning, id)
HIPPY_EXPORT_VIEW_PROPERTY(fontSize, id)
HIPPY_EXPORT_VIEW_PROPERTY(fontData, NSString)
HIPPY_EXPORT_VIEW_PROPERTY(fontStyle, NSString)
HIPPY_EXPORT_VIEW_PROPERTY(fontWeight, id)
HIPPY_EXPORT_VIEW_PROPERTY(fontFamily, NSString)
HIPPY_EXPORT_VIEW_PROPERTY(textAnchor, NSString)
HIPPY_EXPORT_VIEW_PROPERTY(wordSpacing, id)
HIPPY_EXPORT_VIEW_PROPERTY(letterSpacing, id)
HIPPY_EXPORT_VIEW_PROPERTY(textDecoration, NSString)
HIPPY_EXPORT_VIEW_PROPERTY(fontVariantLigatures, NSString)

#pragma mark -

@end
