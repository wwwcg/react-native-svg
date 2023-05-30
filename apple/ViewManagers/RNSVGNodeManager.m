/**
 * Copyright (c) 2015-present, Horcrux.
 * All rights reserved.
 *
 * This source code is licensed under the MIT-style license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import "RNSVGNodeManager.h"

#import "RNSVGNode.h"

static const NSUInteger kMatrixArrayLength = 4 * 4;

@implementation RNSVGNodeManager

+ (CGFloat)convertToRadians:(id)json
{
    if ([json isKindOfClass:[NSString class]]) {
        NSString *stringValue = (NSString *)json;
        if ([stringValue hasSuffix:@"deg"]) {
            CGFloat degrees = [[stringValue substringToIndex:stringValue.length - 3] floatValue];
            return degrees * (CGFloat)M_PI / 180;
        }
        if ([stringValue hasSuffix:@"rad"]) {
            return [[stringValue substringToIndex:stringValue.length - 3] floatValue];
        }
    }
    return [json floatValue];
}

+ (CATransform3D)CATransform3DFromMatrix:(id)json
{
    CATransform3D transform = CATransform3DIdentity;
    if (!json) {
        return transform;
    }
    if (![json isKindOfClass:[NSArray class]]) {
        HippyLogConvertError(json, @"a CATransform3D. Expected array for transform matrix.");
        return transform;
    }
    NSArray *array = json;
    if ([array count] != kMatrixArrayLength) {
        HippyLogConvertError(json, @"a CATransform3D. Expected 4x4 matrix array.");
        return transform;
    }
    for (NSUInteger i = 0; i < kMatrixArrayLength; i++) {
        ((CGFloat *)&transform)[i] = [HippyConvert CGFloat:array[i]];
    }
    return transform;
}

+ (CATransform3D)CATransform3D:(id)json
{
    CATransform3D transform = CATransform3DIdentity;
    if (!json) {
        return transform;
    }
    if (![json isKindOfClass:[NSArray class]]) {
        HippyLogConvertError(json, @"a CATransform3D. Did you pass something other than an array?");
        return transform;
    }
    // legacy matrix support
    if ([(NSArray *)json count] == kMatrixArrayLength && [json[0] isKindOfClass:[NSNumber class]]) {
        HippyLogWarn(@"[HippyConvert CATransform3D:] has deprecated a matrix as input. Pass an array of configs (which can contain a matrix key) instead.");
        return [self CATransform3DFromMatrix:json];
    }

    CGFloat zeroScaleThreshold = FLT_EPSILON;

    for (NSDictionary *transformConfig in (NSArray<NSDictionary *> *)json) {
        if (transformConfig.count != 1) {
            HippyLogConvertError(json, @"a CATransform3D. You must specify exactly one property per transform object.");
            return transform;
        }
        NSString *property = transformConfig.allKeys[0];
        id value = transformConfig[property];

        if ([property isEqualToString:@"matrix"]) {
            transform = [self CATransform3DFromMatrix:value];

        } else if ([property isEqualToString:@"perspective"]) {
            transform.m34 = -1 / [value floatValue];

        } else if ([property isEqualToString:@"rotateX"]) {
            CGFloat rotate = [self convertToRadians:value];
            transform = CATransform3DRotate(transform, rotate, 1, 0, 0);

        } else if ([property isEqualToString:@"rotateY"]) {
            CGFloat rotate = [self convertToRadians:value];
            transform = CATransform3DRotate(transform, rotate, 0, 1, 0);

        } else if ([property isEqualToString:@"rotate"] || [property isEqualToString:@"rotateZ"]) {
            CGFloat rotate = [self convertToRadians:value];
            transform = CATransform3DRotate(transform, rotate, 0, 0, 1);

        } else if ([property isEqualToString:@"scale"]) {
            CGFloat scale = [value floatValue];
            scale = ABS(scale) < zeroScaleThreshold ? zeroScaleThreshold : scale;
            transform = CATransform3DScale(transform, scale, scale, 1);

        } else if ([property isEqualToString:@"scaleX"]) {
            CGFloat scale = [value floatValue];
            scale = ABS(scale) < zeroScaleThreshold ? zeroScaleThreshold : scale;
            transform = CATransform3DScale(transform, scale, 1, 1);

        } else if ([property isEqualToString:@"scaleY"]) {
            CGFloat scale = [value floatValue];
            scale = ABS(scale) < zeroScaleThreshold ? zeroScaleThreshold : scale;
            transform = CATransform3DScale(transform, 1, scale, 1);

        } else if ([property isEqualToString:@"translate"]) {
            NSArray *array = (NSArray<NSNumber *> *)value;
            CGFloat translateX = [array[0] floatValue];
            CGFloat translateY = [array[1] floatValue];
            CGFloat translateZ = array.count > 2 ? [array[2] floatValue] : 0;
            transform = CATransform3DTranslate(transform, translateX, translateY, translateZ);

        } else if ([property isEqualToString:@"translateX"]) {
            CGFloat translate = [value floatValue];
            transform = CATransform3DTranslate(transform, translate, 0, 0);

        } else if ([property isEqualToString:@"translateY"]) {
            CGFloat translate = [value floatValue];
            transform = CATransform3DTranslate(transform, 0, translate, 0);

        } else if ([property isEqualToString:@"skewX"]) {
            CGFloat skew = [self convertToRadians:value];
            transform.m21 = tanf((float)skew);

        } else if ([property isEqualToString:@"skewY"]) {
            CGFloat skew = [self convertToRadians:value];
            transform.m12 = tanf((float)skew);

        } else {
            HippyLogError(@"Unsupported transform type for a CATransform3D: %@.", property);
        }
    }
    return transform;
}

HIPPY_EXPORT_MODULE(SVGNode)

- (RNSVGNode *)node
{
    return [RNSVGNode new];
}

- (RNSVGView *)view
{
    return [self node];
}

HIPPY_EXPORT_VIEW_PROPERTY(name, NSString)
HIPPY_EXPORT_VIEW_PROPERTY(opacity, CGFloat)
HIPPY_EXPORT_VIEW_PROPERTY(matrix, CGAffineTransform)
HIPPY_CUSTOM_VIEW_PROPERTY(transform, CATransform3D, RNSVGNode)
{
    CATransform3D transform3d = json ? [RNSVGNodeManager CATransform3D:json] : defaultView.layer.transform;
    CGAffineTransform transform = CATransform3DGetAffineTransform(transform3d);
    view.invTransform = CGAffineTransformInvert(transform);
    view.transforms = transform;
    [view invalidate];
}
HIPPY_EXPORT_VIEW_PROPERTY(mask, NSString)
HIPPY_EXPORT_VIEW_PROPERTY(markerStart, NSString)
HIPPY_EXPORT_VIEW_PROPERTY(markerMid, NSString)
HIPPY_EXPORT_VIEW_PROPERTY(markerEnd, NSString)
HIPPY_EXPORT_VIEW_PROPERTY(clipPath, NSString)
HIPPY_EXPORT_VIEW_PROPERTY(clipRule, RNSVGCGFCRule)
HIPPY_EXPORT_VIEW_PROPERTY(responsible, BOOL)
HIPPY_EXPORT_VIEW_PROPERTY(onLayout, HippyDirectEventBlock)

HIPPY_CUSTOM_SHADOW_PROPERTY(top, id, RNSVGNode) {}
HIPPY_CUSTOM_SHADOW_PROPERTY(right, id, RNSVGNode) {}
HIPPY_CUSTOM_SHADOW_PROPERTY(start, id, RNSVGNode) {}
HIPPY_CUSTOM_SHADOW_PROPERTY(end, id, RNSVGNode) {}
HIPPY_CUSTOM_SHADOW_PROPERTY(bottom, id, RNSVGNode) {}
HIPPY_CUSTOM_SHADOW_PROPERTY(left, id, RNSVGNode) {}

HIPPY_CUSTOM_SHADOW_PROPERTY(width, id, RNSVGNode) {}
HIPPY_CUSTOM_SHADOW_PROPERTY(height, id, RNSVGNode) {}

HIPPY_CUSTOM_SHADOW_PROPERTY(minWidth, id, RNSVGNode) {}
HIPPY_CUSTOM_SHADOW_PROPERTY(maxWidth, id, RNSVGNode) {}
HIPPY_CUSTOM_SHADOW_PROPERTY(minHeight, id, RNSVGNode) {}
HIPPY_CUSTOM_SHADOW_PROPERTY(maxHeight, id, RNSVGNode) {}

HIPPY_CUSTOM_SHADOW_PROPERTY(borderTopWidth, id, RNSVGNode) {}
HIPPY_CUSTOM_SHADOW_PROPERTY(borderRightWidth, id, RNSVGNode) {}
HIPPY_CUSTOM_SHADOW_PROPERTY(borderBottomWidth, id, RNSVGNode) {}
HIPPY_CUSTOM_SHADOW_PROPERTY(borderLeftWidth, id, RNSVGNode) {}
HIPPY_CUSTOM_SHADOW_PROPERTY(borderStartWidth, id, RNSVGNode) {}
HIPPY_CUSTOM_SHADOW_PROPERTY(borderEndWidth, id, RNSVGNode) {}
HIPPY_CUSTOM_SHADOW_PROPERTY(borderWidth, id, RNSVGNode) {}

HIPPY_CUSTOM_SHADOW_PROPERTY(marginTop, id, RNSVGNode) {}
HIPPY_CUSTOM_SHADOW_PROPERTY(marginRight, id, RNSVGNode) {}
HIPPY_CUSTOM_SHADOW_PROPERTY(marginBottom, id, RNSVGNode) {}
HIPPY_CUSTOM_SHADOW_PROPERTY(marginLeft, id, RNSVGNode) {}
HIPPY_CUSTOM_SHADOW_PROPERTY(marginStart, id, RNSVGNode) {}
HIPPY_CUSTOM_SHADOW_PROPERTY(marginEnd, id, RNSVGNode) {}
HIPPY_CUSTOM_SHADOW_PROPERTY(marginVertical, id, RNSVGNode) {}
HIPPY_CUSTOM_SHADOW_PROPERTY(marginHorizontal, id, RNSVGNode) {}
HIPPY_CUSTOM_SHADOW_PROPERTY(margin, id, RNSVGNode) {}

HIPPY_CUSTOM_SHADOW_PROPERTY(paddingTop, id, RNSVGNode) {}
HIPPY_CUSTOM_SHADOW_PROPERTY(paddingRight, id, RNSVGNode) {}
HIPPY_CUSTOM_SHADOW_PROPERTY(paddingBottom, id, RNSVGNode) {}
HIPPY_CUSTOM_SHADOW_PROPERTY(paddingLeft, id, RNSVGNode) {}
HIPPY_CUSTOM_SHADOW_PROPERTY(paddingStart, id, RNSVGNode) {}
HIPPY_CUSTOM_SHADOW_PROPERTY(paddingEnd, id, RNSVGNode) {}
HIPPY_CUSTOM_SHADOW_PROPERTY(paddingVertical, id, RNSVGNode) {}
HIPPY_CUSTOM_SHADOW_PROPERTY(paddingHorizontal, id, RNSVGNode) {}
HIPPY_CUSTOM_SHADOW_PROPERTY(padding, id, RNSVGNode) {}

HIPPY_CUSTOM_SHADOW_PROPERTY(flex, id, RNSVGNode) {}
HIPPY_CUSTOM_SHADOW_PROPERTY(flexGrow, id, RNSVGNode) {}
HIPPY_CUSTOM_SHADOW_PROPERTY(flexShrink, id, RNSVGNode) {}
HIPPY_CUSTOM_SHADOW_PROPERTY(flexBasis, id, RNSVGNode) {}
HIPPY_CUSTOM_SHADOW_PROPERTY(flexDirection, id, RNSVGNode) {}
HIPPY_CUSTOM_SHADOW_PROPERTY(flexWrap, id, RNSVGNode) {}
HIPPY_CUSTOM_SHADOW_PROPERTY(justifyContent, id, RNSVGNode) {}
HIPPY_CUSTOM_SHADOW_PROPERTY(alignItems, id, RNSVGNode) {}
HIPPY_CUSTOM_SHADOW_PROPERTY(alignSelf, id, RNSVGNode) {}
HIPPY_CUSTOM_SHADOW_PROPERTY(alignContent, id, RNSVGNode) {}
HIPPY_CUSTOM_SHADOW_PROPERTY(position, id, RNSVGNode) {}
HIPPY_CUSTOM_SHADOW_PROPERTY(aspectRatio, id, RNSVGNode) {}

HIPPY_CUSTOM_SHADOW_PROPERTY(overflow, id, RNSVGNode) {}
HIPPY_CUSTOM_SHADOW_PROPERTY(display, id, RNSVGNode) {}
HIPPY_CUSTOM_VIEW_PROPERTY(display, id, RNSVGNode)
{
    view.display = json;
}

HIPPY_CUSTOM_SHADOW_PROPERTY(direction, id, RNSVGNode) {}

HIPPY_CUSTOM_VIEW_PROPERTY(pointerEvents, HippyPointerEvents, RNSVGNode)
{
    view.pointerEvents = json ? [HippyConvert HippyPointerEvents:json] : defaultView.pointerEvents;
}

@end
