/**
 * Copyright (c) 2015-present, Horcrux.
 * All rights reserved.
 *
 * This source code is licensed under the MIT-style license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import "RNSVGCircleManager.h"

#import "RNSVGCircle.h"
#import "RCTConvert+RNSVG.h"

@implementation RNSVGCircleManager

HIPPY_EXPORT_MODULE(Circle)

- (RNSVGRenderable *)node
{
    return [RNSVGCircle new];
}

HIPPY_EXPORT_VIEW_PROPERTY(cx, RNSVGLength*)
HIPPY_EXPORT_VIEW_PROPERTY(cy, RNSVGLength*)
HIPPY_EXPORT_VIEW_PROPERTY(r, RNSVGLength*)

@end
