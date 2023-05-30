/**
 * Copyright (c) 2015-present, Horcrux.
 * All rights reserved.
 *
 * This source code is licensed under the MIT-style license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import "RNSVGTSpanManager.h"

#import "RNSVGTSpan.h"
#import "RCTConvert+RNSVG.h"

@implementation RNSVGTSpanManager

HIPPY_EXPORT_MODULE(TSpan)

- (RNSVGRenderable *)node
{
  return [RNSVGTSpan new];
}

HIPPY_EXPORT_VIEW_PROPERTY(content, NSString)

@end
