/**
 * Copyright (c) 2015-present, Horcrux.
 * All rights reserved.
 *
 * This source code is licensed under the MIT-style license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import "RNSVGRadialGradientManager.h"
#import "RNSVGRadialGradient.h"

@implementation RNSVGRadialGradientManager

HIPPY_EXPORT_MODULE()

- (RNSVGNode *)node
{
  return [RNSVGRadialGradient new];
}

HIPPY_EXPORT_VIEW_PROPERTY(fx, RNSVGLength*)
HIPPY_EXPORT_VIEW_PROPERTY(fy, RNSVGLength*)
HIPPY_EXPORT_VIEW_PROPERTY(cx, RNSVGLength*)
HIPPY_EXPORT_VIEW_PROPERTY(cy, RNSVGLength*)
HIPPY_EXPORT_VIEW_PROPERTY(rx, RNSVGLength*)
HIPPY_EXPORT_VIEW_PROPERTY(ry, RNSVGLength*)
HIPPY_EXPORT_VIEW_PROPERTY(gradient, NSArray<NSNumber *>)
HIPPY_EXPORT_VIEW_PROPERTY(gradientUnits, RNSVGUnits)
HIPPY_EXPORT_VIEW_PROPERTY(gradientTransform, CGAffineTransform)

@end
