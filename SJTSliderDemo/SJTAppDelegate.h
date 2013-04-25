//
//  SJTAppDelegate.h
//  SJTSliderDemo
//
//  Created by Jqgsninimo on 13-4-17.
//  Copyright (c) 2013年 SJT. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SJTSlider.h"

@interface SJTAppDelegate : NSObject <NSApplicationDelegate, NSWindowDelegate, SJTSliderDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet SJTSlider *centerSlider;
@property (weak) IBOutlet SJTSlider *eastSlider;
@property (weak) IBOutlet SJTSlider *northSlider;
@property (weak) IBOutlet SJTSlider *westSlider;
@property (weak) IBOutlet SJTSlider *southSlider;
@property (weak) IBOutlet SJTSlider *aboveSlider;
@property (weak) IBOutlet SJTSlider *belowSlider;
@property (weak) IBOutlet SJTSlider *leftSlider;
@property (weak) IBOutlet SJTSlider *rightSlider;
@property (strong) NSArray *titleArray;
@property (strong) NSArray *mansions28SliderArray;
@property (strong) NSArray *controlSliderArray;
@property (strong) NSArray *mansions28Array;

- (IBAction)actionFromSlider:(SJTSlider *)sender;

@end
