/**
 * Copyright (c) 2015-present, Horcrux.
 * All rights reserved.
 *
 * This source code is licensed under the MIT-style license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import <hippy/HippyBridge.h>
#import <hippy/HippyUIManager.h>
//#import <hippy/HippyUIManagerUtils.h>
#import "RNSVGSvgViewManager.h"
#import "RNSVGSvgView.h"

@implementation RNSVGSvgViewManager

HIPPY_EXPORT_MODULE()

- (RNSVGView *)view
{
    return [RNSVGSvgView new];
}

HIPPY_EXPORT_VIEW_PROPERTY(bbWidth, RNSVGLength*)
HIPPY_EXPORT_VIEW_PROPERTY(bbHeight, RNSVGLength*)
HIPPY_EXPORT_VIEW_PROPERTY(minX, CGFloat)
HIPPY_EXPORT_VIEW_PROPERTY(minY, CGFloat)
HIPPY_EXPORT_VIEW_PROPERTY(vbWidth, CGFloat)
HIPPY_EXPORT_VIEW_PROPERTY(vbHeight, CGFloat)
HIPPY_EXPORT_VIEW_PROPERTY(align, NSString)
HIPPY_EXPORT_VIEW_PROPERTY(meetOrSlice, RNSVGVBMOS)
HIPPY_CUSTOM_VIEW_PROPERTY(tintColor, id, RNSVGSvgView)
{
    view.tintColor = [HippyConvert UIColor:json];
}
HIPPY_CUSTOM_VIEW_PROPERTY(color, id, RNSVGSvgView)
{
    view.tintColor = [HippyConvert UIColor:json];
}


- (void)toDataURL:(nonnull NSNumber *)reactTag options:(NSDictionary *)options callback:(HippyResponseSenderBlock)callback attempt:(int)attempt {
    [self.bridge.uiManager addUIBlock:^(HippyUIManager *uiManager, NSDictionary<NSNumber *,RNSVGView *> *viewRegistry) {
        __kindof RNSVGView *view = viewRegistry[reactTag];
        NSString * b64;
        if ([view isKindOfClass:[RNSVGSvgView class]]) {
            RNSVGSvgView *svg = view;
            if (options == nil) {
                b64 = [svg getDataURL];
            } else {
                id width = [options objectForKey:@"width"];
                id height = [options objectForKey:@"height"];
                if (![width isKindOfClass:NSNumber.class] ||
                    ![height isKindOfClass:NSNumber.class]) {
                    HippyLogError(@"Invalid width or height given to toDataURL");
                    return;
                }
                NSNumber* w = width;
                NSInteger wi = (NSInteger)[w intValue];
                NSNumber* h = height;
                NSInteger hi = (NSInteger)[h intValue];

                CGRect bounds = CGRectMake(0, 0, wi, hi);
                b64 = [svg getDataURLwithBounds:bounds];
            }
        } else {
            HippyLogError(@"Invalid svg returned frin registry, expecting RNSVGSvgView, got: %@", view);
            return;
        }
        if (b64) {
            callback(@[b64]);
        } else if (attempt < 1) {
            void (^retryBlock)(void) = ^{
                [self toDataURL:reactTag options:options callback:callback attempt:(attempt + 1)];
            };

            [uiManager executeBlockOnUIManagerQueue:retryBlock];
        } else {
            callback(@[]);
        }
    }];
}

HIPPY_EXPORT_METHOD(toDataURL:(nonnull NSNumber *)reactTag options:(NSDictionary *)options callback:(HippyResponseSenderBlock)callback)
{
    [self toDataURL:reactTag options:options callback:callback attempt:0];
}

@end
