/**
 * Copyright (c) 2015-present, Horcrux.
 * All rights reserved.
 *
 * This source code is licensed under the MIT-style license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import "RNSVGTextPathManager.h"

#import "RNSVGTextPath.h"

@implementation RNSVGTextPathManager

HIPPY_EXPORT_MODULE(TextPath)

- (RNSVGRenderable *)node
{
  return [RNSVGTextPath new];
}

HIPPY_EXPORT_VIEW_PROPERTY(href, NSString)
HIPPY_EXPORT_VIEW_PROPERTY(side, NSString)
HIPPY_EXPORT_VIEW_PROPERTY(method, NSString)
HIPPY_EXPORT_VIEW_PROPERTY(midLine, NSString)
HIPPY_EXPORT_VIEW_PROPERTY(spacing, NSString)
HIPPY_EXPORT_VIEW_PROPERTY(startOffset, RNSVGLength*)

@end
