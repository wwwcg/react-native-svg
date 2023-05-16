/**
 * Copyright (c) 2015-present, Horcrux.
 * All rights reserved.
 *
 * This source code is licensed under the MIT-style license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import "RNSVGUseManager.h"
#import "RNSVGUse.h"

@implementation RNSVGUseManager

HIPPY_EXPORT_MODULE()

- (RNSVGNode *)node
{
  return [RNSVGUse new];
}

HIPPY_EXPORT_VIEW_PROPERTY(href, NSString)
HIPPY_CUSTOM_VIEW_PROPERTY(x, id, RNSVGUse)
{
    view.x = [HippyConvert RNSVGLength:json];
}
HIPPY_CUSTOM_VIEW_PROPERTY(y, id, RNSVGUse)
{
    view.y = [HippyConvert RNSVGLength:json];
}
HIPPY_EXPORT_VIEW_PROPERTY(useheight, RNSVGLength*)
HIPPY_EXPORT_VIEW_PROPERTY(usewidth, RNSVGLength*)
HIPPY_CUSTOM_VIEW_PROPERTY(height, id, RNSVGUse)
{
    view.useheight = [HippyConvert RNSVGLength:json];
}
HIPPY_CUSTOM_VIEW_PROPERTY(width, id, RNSVGUse)
{
    view.usewidth = [HippyConvert RNSVGLength:json];
}

@end
