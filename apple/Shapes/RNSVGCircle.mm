/**
 * Copyright (c) 2015-present, Horcrux.
 * All rights reserved.
 *
 * This source code is licensed under the MIT-style license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import "RNSVGCircle.h"
#import <React/RCTLog.h>

#ifdef RN_FABRIC_ENABLED
#import <react/renderer/components/rnsvg/ComponentDescriptors.h>
#import "RCTFabricComponentsPlugins.h"
#import "RCTConversions.h"
#import <react/renderer/components/view/conversions.h>
#import "RNSVGFabricConversions.h"
#endif

@implementation RNSVGCircle

#ifdef RN_FABRIC_ENABLED
using namespace facebook::react;

- (instancetype)initWithFrame:(CGRect)frame
{
  if (self = [super initWithFrame:frame]) {
    static const auto defaultProps = std::make_shared<const RNSVGCircleProps>();
    _props = defaultProps;
  }
  return self;
}

#pragma mark - RCTComponentViewProtocol

+ (ComponentDescriptorProvider)componentDescriptorProvider
{
  return concreteComponentDescriptorProvider<RNSVGCircleComponentDescriptor>();
}

- (void)updateProps:(Props::Shared const &)props oldProps:(Props::Shared const &)oldProps
{
  const auto &newProps = *std::static_pointer_cast<const RNSVGCircleProps>(props);

    self.cx = [RNSVGLength lengthWithString:RCTNSStringFromString(newProps.cx)];
    self.cy = [RNSVGLength lengthWithString:RCTNSStringFromString(newProps.cy)];
    self.r  = [RNSVGLength lengthWithString:RCTNSStringFromString(newProps.r)];
    setCommonRenderableProps(newProps, self, self);
    [super updateProps:props oldProps:oldProps];
}

- (void)prepareForRecycle
{
    [super prepareForRecycle];
    [self invalidate];
}
#endif

- (void)setCx:(RNSVGLength *)cx
{
    if ([cx isEqualTo:_cx]) {
        return;
    }
    [self invalidate];
    _cx = cx;
}

- (void)setCy:(RNSVGLength *)cy
{
    if ([cy isEqualTo:_cy]) {
        return;
    }
    [self invalidate];
    _cy = cy;
}

- (void)setR:(RNSVGLength *)r
{
    if ([r isEqualTo:_r]) {
        return;
    }
    [self invalidate];
    _r = r;
}

- (CGPathRef)getPath:(CGContextRef)context
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat cx = [self relativeOnWidth:self.cx];
    CGFloat cy = [self relativeOnHeight:self.cy];
    CGFloat r = [self relativeOnOther:self.r];
    CGPathAddArc(path, nil, cx, cy, r, 0, 2 * (CGFloat)M_PI, NO);
    return (CGPathRef)CFAutorelease(path);
}

@end

#ifdef RN_FABRIC_ENABLED
Class<RCTComponentViewProtocol> RNSVGCircleCls(void)
{
  return RNSVGCircle.class;
}
#endif
