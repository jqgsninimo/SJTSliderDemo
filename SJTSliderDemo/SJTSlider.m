//
//  SJTSlider.m
//  SJTSliderDemo
//
//  Created by Jqgsninimo on 13-4-17.
//  Copyright (c) 2013年 SJT. All rights reserved.
//

#import "SJTSlider.h"

#pragma mark -
#pragma mark Constant Definition
#pragma mark -
static const CGFloat SJTSliderTipPopoverMinWidthX = 60;
static const CGFloat SJTSliderTipPopoverMinWidthY = 40;
static const CGFloat SJTSliderTipPopoverMinHeightX = 38;
static const CGFloat SJTSliderTipPopoverMinHeightY = 24;

#pragma mark -
#pragma mark Class SJTSlider
#pragma mark -
@interface SJTSlider ()
@property (strong) NSPopover *tipPopover;
- (void)initView;
- (void)showTipPopover:(BOOL)animated;
- (void)closeTipPopover:(BOOL)animated;
@end

@implementation SJTSlider
@synthesize tipEnabled;

#pragma mark -
#pragma mark Methods From NSObject
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark -
#pragma mark Methods From NSKeyValueObserving
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object==self.tipPopover&&[@"positioningRect" isEqualToString:keyPath]) {
        NSView *tipContentView = self.tipPopover.contentViewController.view;
        NSTextField *tipView = (NSTextField *)tipContentView.subviews[0];
        NSTextAlignment tipAlignment = NSCenterTextAlignment;
        if (self.tipAutoAlignment) {
            NSRect tipContentFrame = [tipContentView convertRect:tipContentView.bounds toView:nil];
            tipContentFrame = [tipContentView.window convertRectToScreen:tipContentFrame];
            tipContentFrame = [self.window convertRectFromScreen:tipContentFrame];
            tipContentFrame = [self convertRect:tipContentFrame fromView:nil];
            NSRect tipTargetFrame = self.tipPopover.positioningRect;
            
            if (NSMaxX(tipContentFrame)<NSMinX(tipTargetFrame)) {
                tipAlignment = NSRightTextAlignment;
            } else if (NSMinX(tipContentFrame)>NSMaxX(tipTargetFrame)) {
                tipAlignment = NSLeftTextAlignment;
            }
        } else {
            tipAlignment = self.tipAlignment;
        }
        tipView.alignment = tipAlignment;
    }
}

#pragma mark -
#pragma mark Methods From NSResponder
- (void)mouseEntered:(NSEvent *)theEvent {
    if (self.tipEnabled) {
        [self showTipPopover:YES];
    }
}

- (void)mouseExited:(NSEvent *)theEvent {
    [self closeTipPopover:YES];
}

#pragma mark -
#pragma mark Methods From NSView
- (void)setFrame:(NSRect)frameRect {
    [super setFrame:frameRect];
    [self updateTrackingAreas];
}

#pragma mark -
#pragma mark Methods From NSControl
- (id)initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
    if (self) {
        [self initView];
    }
    return self;
}

- (BOOL)sendAction:(SEL)theAction to:(id)theTarget {
    if (self.tipEnabled) {
        [self showTipPopover:NO];
    }
    
    return [super sendAction:theAction to:theTarget];
}

#pragma mark -
#pragma mark Utility Methods
- (void)initView {
    self.continuous = YES;
    self.tipEnabled = YES;
    self.tipAutoAlignment = YES;
    self.tipAlignment = NSCenterTextAlignment;
    self.tipPopoverAppearance = NSPopoverAppearanceMinimal;
    
    NSTrackingArea *trackingArea = [[NSTrackingArea alloc] initWithRect:NSZeroRect
                                                                options:NSTrackingInVisibleRect | NSTrackingMouseEnteredAndExited | NSTrackingMouseMoved | NSTrackingActiveInActiveApp
                                                                  owner:self
                                                               userInfo:nil];
    [self addTrackingArea:trackingArea];

    NSTextField *tipView = [[NSTextField alloc] init];
    tipView.bordered = NO;
    tipView.backgroundColor = [NSColor clearColor];
    tipView.editable = NO;
    tipView.selectable = NO;
    
    NSView *contentView = [[NSView alloc] init];
    [contentView addSubview:tipView];
    
    self.tipPopover = [[NSPopover alloc] init];
    self.tipPopover.contentViewController = [[NSViewController alloc] init];
    self.tipPopover.contentViewController.view = contentView;
    [self.tipPopover addObserver:self forKeyPath:@"positioningRect" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)showTipPopover:(BOOL)animated {
    NSString *tip = nil;
    if (self.delegate&&[self.delegate respondsToSelector:@selector(slider:tipForValue:)]) {
        tip = [self.delegate slider:self tipForValue:self.doubleValue];
    } else {
        tip = [NSString stringWithFormat:@"%0.2f", self.doubleValue];
    }

    if (tip) {
        NSView *contentView = self.tipPopover.contentViewController.view;
        NSTextField *tipView = (NSTextField *)contentView.subviews[0];
        
        NSRect knobRect = [((NSSliderCell *)self.cell) knobRectFlipped:self.isFlipped];
        NSRectEdge preferredEdge;
        if (((NSSliderCell *)self.cell).sliderType==NSCircularSlider) {
            NSPoint tickMartCenter = NSMakePoint(NSMidX(knobRect), NSMidY(knobRect));
            NSPoint viewCenter = NSMakePoint(NSMidX(self.bounds), NSMidY(self.bounds));
            CGFloat cutoffValue = sqrtf(((viewCenter.x-tickMartCenter.x)*(viewCenter.x-tickMartCenter.x)+(viewCenter.y-tickMartCenter.y)*(viewCenter.y-tickMartCenter.y))/2);
            if (viewCenter.x-tickMartCenter.x>cutoffValue) {
                preferredEdge = NSMinXEdge;
            } else if (tickMartCenter.y-viewCenter.y>cutoffValue) {
                preferredEdge = NSMaxYEdge;
            } else if (tickMartCenter.x-viewCenter.x>cutoffValue) {
                preferredEdge = NSMaxXEdge;
            } else {
                preferredEdge = NSMinYEdge;
            }
        } else if (self.isVertical) {
            if (self.tickMarkPosition==NSTickMarkLeft) {
                preferredEdge = NSMinXEdge;
            } else {
                preferredEdge = NSMaxXEdge;
            }
        } else {
            if (self.tickMarkPosition==NSTickMarkBelow) {
                preferredEdge = self.isFlipped?NSMaxYEdge:NSMinYEdge;
            } else {
                preferredEdge = self.isFlipped?NSMinYEdge:NSMaxYEdge;
            }
        }
        
        self.tipPopover.appearance = self.tipPopoverAppearance;
        tipView.textColor = self.tipPopoverAppearance==NSPopoverAppearanceMinimal?[NSColor textColor]:[NSColor textBackgroundColor];
        tipView.stringValue = tip;
        [tipView sizeToFit];
        NSRect tipViewFrame = tipView.bounds;
        NSSize contentViewSize = tipView.bounds.size;
        NSInteger minWidth, minHeight;
        if (preferredEdge==NSMinXEdge||preferredEdge==NSMaxXEdge) {
            minWidth = SJTSliderTipPopoverMinWidthX;
            minHeight = SJTSliderTipPopoverMinHeightX;
        } else {
            minWidth = SJTSliderTipPopoverMinWidthY;
            minHeight = SJTSliderTipPopoverMinHeightY;
        }
        if (tipViewFrame.size.width<minWidth) {
            tipViewFrame.origin.x = (minWidth-tipViewFrame.size.width)/2;
            contentViewSize.width = minWidth;
        }
        if (tipViewFrame.size.height<minHeight) {
            tipViewFrame.origin.y = (minHeight-tipViewFrame.size.height)/2;
            contentViewSize.height = minHeight;
        }
        [contentView setFrameSize:contentViewSize];
        tipView.frame = tipViewFrame;
        self.tipPopover.contentSize = contentViewSize;

        self.tipPopover.animates = animated;
        [self.tipPopover showRelativeToRect:knobRect ofView:self preferredEdge:preferredEdge];
    }
}

- (void)closeTipPopover:(BOOL)animated {
    if (self.tipPopover.isShown) {
        self.tipPopover.animates = animated;
        [self.tipPopover close];
    }
}

@end
