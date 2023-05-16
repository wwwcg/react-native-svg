/**
 * Copyright (c) 2015-present, Horcrux.
 * All rights reserved.
 *
 * This source code is licensed under the MIT-style license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import "RNSVGRectManager.h"

#import "RNSVGRect.h"
#import "RCTConvert+RNSVG.h"

@implementation RNSVGRectManager

HIPPY_EXPORT_MODULE()

- (RNSVGRenderable *)node
{
  return [RNSVGRect new];
}

HIPPY_EXPORT_VIEW_PROPERTY(x, RNSVGLength*)
HIPPY_EXPORT_VIEW_PROPERTY(y, RNSVGLength*)
HIPPY_EXPORT_VIEW_PROPERTY(rectheight, RNSVGLength*)
HIPPY_EXPORT_VIEW_PROPERTY(rectwidth, RNSVGLength*)
HIPPY_CUSTOM_VIEW_PROPERTY(height, id, RNSVGRect)
{
    view.rectheight = [HippyConvert RNSVGLength:json];
}

HIPPY_CUSTOM_VIEW_PROPERTY(width, id, RNSVGRect)
{
    view.rectwidth = [HippyConvert RNSVGLength:json];
}
HIPPY_EXPORT_VIEW_PROPERTY(rx, RNSVGLength*)
HIPPY_EXPORT_VIEW_PROPERTY(ry, RNSVGLength*)

@end
