//
//  SJTSlider.h
//  SJTSliderDemo
//
//  Created by Jqgsninimo on 13-4-17.
//  Copyright (c) 2013年 SJT. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class SJTSlider;

@protocol SJTSliderDelegate <NSObject>
- (NSString *)slider:(SJTSlider *)slider tipForValue:(double)value;
@end

@interface SJTSlider : NSSlider
@property (assign) BOOL tipEnabled;
@property (assign) BOOL tipAutoAlignment;
@property (assign) NSTextAlignment tipAlignment;
@property (assign) NSPopoverAppearance tipPopoverAppearance;
@property (weak) id<SJTSliderDelegate> delegate;
@end
