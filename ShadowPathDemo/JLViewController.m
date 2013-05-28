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
	
	const CGFloat kHorizontalMargin = 20.f;
	const CGFloat kVerticalMargin = 100.f;
	
	CALayer *imageLayer = [CALayer layer];
	imageLayer.position = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
	imageLayer.bounds = CGRectInset(self.view.bounds, kHorizontalMargin, kVerticalMargin);
	imageLayer.contents = (id)[UIImage imageNamed:@"image.jpg"].CGImage;
	imageLayer.borderWidth = 20;
	imageLayer.borderColor = [UIColor whiteColor].CGColor;
	imageLayer.shadowPath = [self customShadowPathForRect:imageLayer.bounds];
	imageLayer.shadowOffset = CGSizeMake(0, 4);
	imageLayer.shadowOpacity = .5;
	
	[self.view.layer addSublayer:imageLayer];
}

- (CGPathRef)customShadowPathForRect:(CGRect)rect
{
	const CGFloat kCurveSlope = 20.f;
	
	UIBezierPath *shadowPath = [UIBezierPath bezierPath];
	[shadowPath moveToPoint:CGPointMake(CGRectGetMinX(rect), CGRectGetMinY(rect))];
	[shadowPath addLineToPoint:CGPointMake(CGRectGetMinX(rect), CGRectGetMaxY(rect) + kCurveSlope)];
	[shadowPath addQuadCurveToPoint:CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect) + kCurveSlope)
					   controlPoint:CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect) - kCurveSlope)];
	[shadowPath addLineToPoint:CGPointMake(CGRectGetMaxX(rect), CGRectGetMinY(rect))];
	[shadowPath closePath];
	return shadowPath.CGPath;
}

@end
