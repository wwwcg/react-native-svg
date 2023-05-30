/**
 * Copyright (c) 2015-present, Horcrux.
 * All rights reserved.
 *
 * This source code is licensed under the MIT-style license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import "RNSVGForeignObjectManager.h"
#import "RNSVGForeignObject.h"

@implementation RNSVGForeignObjectManager

HIPPY_EXPORT_MODULE(ForeignObject)

- (RNSVGForeignObject *)node
{
    return [RNSVGForeignObject new];
}

HIPPY_EXPORT_VIEW_PROPERTY(x, RNSVGLength*)
HIPPY_EXPORT_VIEW_PROPERTY(y, RNSVGLength*)
HIPPY_EXPORT_VIEW_PROPERTY(foreignObjectheight, RNSVGLength*)
HIPPY_EXPORT_VIEW_PROPERTY(foreignObjectwidth, RNSVGLength*)
HIPPY_CUSTOM_VIEW_PROPERTY(height, id, RNSVGForeignObject)
{
    view.foreignObjectheight = [HippyConvert RNSVGLength:json];
}
HIPPY_CUSTOM_VIEW_PROPERTY(width, id, RNSVGForeignObject)
{
    view.foreignObjectwidth = [HippyConvert RNSVGLength:json];
}

@end
