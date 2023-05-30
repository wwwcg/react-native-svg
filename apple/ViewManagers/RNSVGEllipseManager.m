/**
 * Copyright (c) 2015-present, Horcrux.
 * All rights reserved.
 *
 * This source code is licensed under the MIT-style license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import "RNSVGEllipseManager.h"

#import "RNSVGEllipse.h"
#import "RCTConvert+RNSVG.h"

@implementation RNSVGEllipseManager

HIPPY_EXPORT_MODULE(Ellipse)

- (RNSVGRenderable *)node
{
  return [RNSVGEllipse new];
}

HIPPY_EXPORT_VIEW_PROPERTY(cx, RNSVGLength*)
HIPPY_EXPORT_VIEW_PROPERTY(cy, RNSVGLength*)
HIPPY_EXPORT_VIEW_PROPERTY(rx, RNSVGLength*)
HIPPY_EXPORT_VIEW_PROPERTY(ry, RNSVGLength*)

@end
