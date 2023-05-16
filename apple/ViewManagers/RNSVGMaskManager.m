/**
 * Copyright (c) 2015-present, Horcrux.
 * All rights reserved.
 *
 * This source code is licensed under the MIT-style license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import "RNSVGMaskManager.h"
#import "RNSVGMask.h"

@implementation RNSVGMaskManager

HIPPY_EXPORT_MODULE()

- (RNSVGMask *)node
{
    return [RNSVGMask new];
}

HIPPY_EXPORT_VIEW_PROPERTY(x, RNSVGLength*)
HIPPY_EXPORT_VIEW_PROPERTY(y, RNSVGLength*)
HIPPY_EXPORT_VIEW_PROPERTY(maskheight, RNSVGLength*)
HIPPY_EXPORT_VIEW_PROPERTY(maskwidth, RNSVGLength*)
HIPPY_CUSTOM_VIEW_PROPERTY(height, id, RNSVGMask)
{
    view.maskheight = [HippyConvert RNSVGLength:json];
}
HIPPY_CUSTOM_VIEW_PROPERTY(width, id, RNSVGMask)
{
    view.maskwidth = [HippyConvert RNSVGLength:json];
}
HIPPY_EXPORT_VIEW_PROPERTY(maskUnits, RNSVGUnits)
HIPPY_EXPORT_VIEW_PROPERTY(maskContentUnits, RNSVGUnits)
HIPPY_EXPORT_VIEW_PROPERTY(maskTransform, CGAffineTransform)

@end
