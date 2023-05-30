/**
 * Copyright (c) 2015-present, Horcrux.
 * All rights reserved.
 *
 * This source code is licensed under the MIT-style license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import "RNSVGImageManager.h"
#import "RNSVGVBMOS.h"
#import "RNSVGImage.h"
#import "RCTConvert+RNSVG.h"

@implementation RNSVGImageManager

HIPPY_EXPORT_MODULE(SVGImage)

- (RNSVGRenderable *)node
{
    RNSVGImage *svgImage = [RNSVGImage new];
    svgImage.bridge = self.bridge;

    return svgImage;
}

HIPPY_EXPORT_VIEW_PROPERTY(x, RNSVGLength*)
HIPPY_EXPORT_VIEW_PROPERTY(y, RNSVGLength*)
HIPPY_EXPORT_VIEW_PROPERTY(imagewidth, RNSVGLength*)
HIPPY_EXPORT_VIEW_PROPERTY(imageheight, RNSVGLength*)
HIPPY_CUSTOM_VIEW_PROPERTY(width, id, RNSVGImage)
{
    view.imagewidth = [HippyConvert RNSVGLength:json];
}
HIPPY_CUSTOM_VIEW_PROPERTY(height, id, RNSVGImage)
{
    view.imageheight = [HippyConvert RNSVGLength:json];
}
HIPPY_EXPORT_VIEW_PROPERTY(src, id)
HIPPY_EXPORT_VIEW_PROPERTY(align, NSString)
HIPPY_EXPORT_VIEW_PROPERTY(meetOrSlice, RNSVGVBMOS)

@end
