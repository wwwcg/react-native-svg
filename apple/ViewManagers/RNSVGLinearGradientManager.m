/**
 * Copyright (c) 2015-present, Horcrux.
 * All rights reserved.
 *
 * This source code is licensed under the MIT-style license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import "RNSVGLinearGradientManager.h"
#import "RNSVGLinearGradient.h"

@implementation RNSVGLinearGradientManager

HIPPY_EXPORT_MODULE(LinearGradient)

- (RNSVGNode *)node
{
  return [RNSVGLinearGradient new];
}

HIPPY_EXPORT_VIEW_PROPERTY(x1, RNSVGLength*)
HIPPY_EXPORT_VIEW_PROPERTY(y1, RNSVGLength*)
HIPPY_EXPORT_VIEW_PROPERTY(x2, RNSVGLength*)
HIPPY_EXPORT_VIEW_PROPERTY(y2, RNSVGLength*)
HIPPY_EXPORT_VIEW_PROPERTY(gradient, NSArray<NSNumber *>)
HIPPY_EXPORT_VIEW_PROPERTY(gradientUnits, RNSVGUnits)
HIPPY_EXPORT_VIEW_PROPERTY(gradientTransform, CGAffineTransform)

@end
