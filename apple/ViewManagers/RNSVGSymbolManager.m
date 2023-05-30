/**
 * Copyright (c) 2015-present, Horcrux.
 * All rights reserved.
 *
 * This source code is licensed under the MIT-style license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import "RNSVGSymbolManager.h"
#import "RNSVGRenderable.h"
#import "RNSVGSymbol.h"
#import "RCTConvert+RNSVG.h"
#import "RNSVGVBMOS.h"

@implementation RNSVGSymbolManager

HIPPY_EXPORT_MODULE(Symbol)

- (RNSVGRenderable *)node
{
  return [RNSVGSymbol new];
}

HIPPY_EXPORT_VIEW_PROPERTY(minX, CGFloat)
HIPPY_EXPORT_VIEW_PROPERTY(minY, CGFloat)
HIPPY_EXPORT_VIEW_PROPERTY(vbWidth, CGFloat)
HIPPY_EXPORT_VIEW_PROPERTY(vbHeight, CGFloat)
HIPPY_EXPORT_VIEW_PROPERTY(align, NSString)
HIPPY_EXPORT_VIEW_PROPERTY(meetOrSlice, RNSVGVBMOS)

@end
