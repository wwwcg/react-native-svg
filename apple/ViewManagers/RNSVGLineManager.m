/**
 * Copyright (c) 2015-present, Horcrux.
 * All rights reserved.
 *
 * This source code is licensed under the MIT-style license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import "RNSVGLineManager.h"

#import "RNSVGLine.h"
#import "RCTConvert+RNSVG.h"

@implementation RNSVGLineManager

HIPPY_EXPORT_MODULE()

- (RNSVGRenderable *)node
{
  return [RNSVGLine new];
}

HIPPY_EXPORT_VIEW_PROPERTY(x1, RNSVGLength*)
HIPPY_EXPORT_VIEW_PROPERTY(y1, RNSVGLength*)
HIPPY_EXPORT_VIEW_PROPERTY(x2, RNSVGLength*)
HIPPY_EXPORT_VIEW_PROPERTY(y2, RNSVGLength*)

@end
