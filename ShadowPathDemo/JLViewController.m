//
//  JLViewController.m
//  ShadowPathDemo
//
//  Created by Jose Luis Piedrahita on 5/27/13.
//  Copyright (c) 2013 Jose Luis Piedrahita. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "JLViewController.h"

@implementation JLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	CALayer *frameLayer = [self frameLayer];
	CALayer *imageLayer = [self imageLayerFromFrameLayer:frameLayer];
	[frameLayer addSublayer:imageLayer];
	
	[self.view.layer addSublayer:frameLayer];
}

- (CALayer *)frameLayer
{
	const CGFloat kVerticalMargin = 100.f;
	const CGFloat kHorizontalMargin = 20.f;
	
    CALayer *frameLayer = [CALayer layer];
	frameLayer.bounds = CGRectInset(self.view.bounds, kHorizontalMargin, kVerticalMargin);
	frameLayer.position = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
	frameLayer.backgroundColor = [UIColor whiteColor].CGColor;
	frameLayer.shadowOffset = CGSizeMake(0, 4);
	frameLayer.shadowOpacity = .5;
	frameLayer.shadowPath = [self shadowPathForFrameLayer:frameLayer];
    return frameLayer;
}

- (CALayer *)imageLayerFromFrameLayer:(CALayer*) frameLayer
{
	const CGFloat kFrameMargin = 20.f;
	
	CALayer *imageLayer = [CALayer layer];
	imageLayer.position = frameLayer.position;
	imageLayer.bounds = CGRectInset(frameLayer.bounds, kFrameMargin, kFrameMargin);
	imageLayer.contents = (id)[UIImage imageNamed:@"image.jpg"].CGImage;
	return imageLayer;
}

- (CGPathRef)shadowPathForFrameLayer:(CALayer *)frameLayer
{
	const CGFloat kMaxYShadowOffset = 20.f;

	UIBezierPath *shadowPath = [UIBezierPath bezierPath];
	[shadowPath moveToPoint:CGPointMake(CGRectGetMinX(frameLayer.bounds), CGRectGetMinY(frameLayer.bounds))];
	[shadowPath addLineToPoint:CGPointMake(CGRectGetMinX(frameLayer.bounds), CGRectGetMaxY(frameLayer.bounds) + kMaxYShadowOffset)];
	[shadowPath addQuadCurveToPoint:CGPointMake(CGRectGetMaxX(frameLayer.bounds), CGRectGetMaxY(frameLayer.bounds) + kMaxYShadowOffset)
					   controlPoint:CGPointMake(CGRectGetMidX(frameLayer.bounds), CGRectGetMaxY(frameLayer.bounds) - 10)];
	[shadowPath addLineToPoint:CGPointMake(CGRectGetMaxX(frameLayer.bounds), CGRectGetMinY(frameLayer.bounds))];
	[shadowPath closePath];
	return shadowPath.CGPath;
}

@end
