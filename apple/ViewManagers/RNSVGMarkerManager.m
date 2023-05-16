/**
 * Copyright (c) 2015-present, Horcrux.
 * All rights reserved.
 *
 * This source code is licensed under the MIT-style license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import "RNSVGMarkerManager.h"
#import "RNSVGMarker.h"

@implementation RNSVGMarkerManager

HIPPY_EXPORT_MODULE()

- (RNSVGMarker *)node
{
    return [RNSVGMarker new];
}

HIPPY_EXPORT_VIEW_PROPERTY(refX, RNSVGLength*)
HIPPY_EXPORT_VIEW_PROPERTY(refY, RNSVGLength*)
HIPPY_EXPORT_VIEW_PROPERTY(markerHeight, RNSVGLength*)
HIPPY_EXPORT_VIEW_PROPERTY(markerWidth, RNSVGLength*)
HIPPY_EXPORT_VIEW_PROPERTY(markerUnits, NSString*)
HIPPY_EXPORT_VIEW_PROPERTY(orient, NSString*)

HIPPY_EXPORT_VIEW_PROPERTY(minX, CGFloat)
HIPPY_EXPORT_VIEW_PROPERTY(minY, CGFloat)
HIPPY_EXPORT_VIEW_PROPERTY(vbWidth, CGFloat)
HIPPY_EXPORT_VIEW_PROPERTY(vbHeight, CGFloat)
HIPPY_EXPORT_VIEW_PROPERTY(align, NSString)
HIPPY_EXPORT_VIEW_PROPERTY(meetOrSlice, RNSVGVBMOS)

@end

