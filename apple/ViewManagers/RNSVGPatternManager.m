/**
 * Copyright (c) 2015-present, Horcrux.
 * All rights reserved.
 *
 * This source code is licensed under the MIT-style license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import "RNSVGPatternManager.h"
#import "RNSVGPattern.h"

@implementation RNSVGPatternManager

HIPPY_EXPORT_MODULE(SVGPattern)

- (RNSVGPattern *)node
{
    return [RNSVGPattern new];
}

HIPPY_EXPORT_VIEW_PROPERTY(x, RNSVGLength*)
HIPPY_EXPORT_VIEW_PROPERTY(y, RNSVGLength*)
HIPPY_EXPORT_VIEW_PROPERTY(patternheight, RNSVGLength*)
HIPPY_EXPORT_VIEW_PROPERTY(patternwidth, RNSVGLength*)
HIPPY_CUSTOM_VIEW_PROPERTY(height, id, RNSVGPattern)
{
    view.patternheight = [HippyConvert RNSVGLength:json];
}

HIPPY_CUSTOM_VIEW_PROPERTY(width, id, RNSVGPattern)
{
    view.patternwidth = [HippyConvert RNSVGLength:json];
}
HIPPY_EXPORT_VIEW_PROPERTY(patternUnits, RNSVGUnits)
HIPPY_EXPORT_VIEW_PROPERTY(patternContentUnits, RNSVGUnits)
HIPPY_EXPORT_VIEW_PROPERTY(patternTransform, CGAffineTransform)

HIPPY_EXPORT_VIEW_PROPERTY(minX, CGFloat)
HIPPY_EXPORT_VIEW_PROPERTY(minY, CGFloat)
HIPPY_EXPORT_VIEW_PROPERTY(vbWidth, CGFloat)
HIPPY_EXPORT_VIEW_PROPERTY(vbHeight, CGFloat)
HIPPY_EXPORT_VIEW_PROPERTY(align, NSString)
HIPPY_EXPORT_VIEW_PROPERTY(meetOrSlice, RNSVGVBMOS)

@end
