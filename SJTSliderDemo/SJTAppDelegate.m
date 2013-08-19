//
//  SJTAppDelegate.m
//  SJTSliderDemo
//
//  Created by Jqgsninimo on 13-4-17.
//  Copyright (c) 2013年 SJT. All rights reserved.
//

#import "SJTAppDelegate.h"

@implementation SJTAppDelegate

#pragma mark -
#pragma mark Methods From NSApplicationDelegate
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    self.mansions28SliderArray = @[self.centerSlider, self.eastSlider, self.northSlider, self.westSlider, self.southSlider];
    self.controlSliderArray = @[self.aboveSlider, self.belowSlider, self.leftSlider, self.rightSlider];
    self.titleArray = @[@"二十八宿", @"二十八宿（にじゅうはっしゅく）", @"Twenty-eight Mansions"];
    self.mansions28Array = @[@[@"中央钧天・东方青龙・角木蛟", @"東方青龍・角・すぼし", @"Azure Dragon of the East(Spring): Horn"],
                             @[@"中央钧天・东方青龙・亢金龙", @"東方青龍・亢・網星（あみぼし）", @"Azure Dragon of the East(Spring): Neck"],
                             @[@"中央钧天・东方青龙・氐土貉", @"東方青龍・氐・ともぼし", @"Azure Dragon of the East(Spring): Root"],
                             @[@"东方苍天・东方青龙・房日兔", @"東方青龍・房・添星（そいぼし）", @"Azure Dragon of the East(Spring): Room"],
                             @[@"东方苍天・东方青龙・心月狐", @"東方青龍・心・中子星（なかごぼし）", @"Azure Dragon of the East(Spring): Heart"],
                             @[@"东方苍天・东方青龙・尾火虎", @"東方青龍・尾・足垂れ星（あしたれぼし）", @"Azure Dragon of the East(Spring): Tail"],
                             @[@"东北变天・东方青龙・箕水豹", @"東方青龍・箕・箕星（みぼし）", @"Azure Dragon of the East(Spring): Winnowing Basket"],
                             @[@"东北变天・北方玄武・斗木獬", @"北方玄武・斗・ひきつぼし", @"Black Tortoise of the North(Winter): Dipper"],
                             @[@"东北变天・北方玄武・牛金牛", @"北方玄武・牛・稲見星（いなみぼし）", @"Black Tortoise of the North(Winter): Ox"],
                             @[@"北方玄天・北方玄武・女土蝠", @"北方玄武・女・うるきぼし", @"Black Tortoise of the North(Winter): Girl"],
                             @[@"北方玄天・北方玄武・虚日鼠", @"北方玄武・虚・とみてぼし", @"Black Tortoise of the North(Winter): Emptiness"],
                             @[@"北方玄天・北方玄武・危月燕", @"北方玄武・危・うみやめぼし", @"Black Tortoise of the North(Winter): Rooftop"],
                             @[@"北方玄天・北方玄武・室火猪", @"北方玄武・室・はついぼし", @"Black Tortoise of the North(Winter): Encampment"],
                             @[@"西北幽天・北方玄武・壁水貐", @"北方玄武・壁・なまめぼし", @"Black Tortoise of the North(Winter): Wall"],
                             @[@"西北幽天・西方白虎・奎木狼", @"西方白虎・奎・斗掻き星（とかきぼし）", @"White Tiger of the West(Fall): Legs"],
                             @[@"西北幽天・西方白虎・娄金狗", @"西方白虎・婁・たたらぼし", @"White Tiger of the West(Fall): Bond"],
                             @[@"西方颢天・西方白虎・胃土雉", @"西方白虎・胃・えきえぼし", @"White Tiger of the West(Fall): Stomach"],
                             @[@"西方颢天・西方白虎・昴日鸡", @"西方白虎・昴・すばるぼし（六連星：異称）", @"White Tiger of the West(Fall): Hairy Head"],
                             @[@"西方颢天・西方白虎・毕月乌", @"西方白虎・畢・あめふりぼし", @"White Tiger of the West(Fall): Net"],
                             @[@"西南朱天・西方白虎・觜火猴", @"西方白虎・觜・とろきぼし", @"White Tiger of the West(Fall): Turtle Beak"],
                             @[@"西南朱天・西方白虎・参水猿", @"西方白虎・参・唐鋤星（からすきぼし）", @"White Tiger of the West(Fall): Three Stars"],
                             @[@"西南朱天・南方朱雀・井木犴", @"南方朱雀・井・ちちりぼし", @"Vermilion Bird of the South(Summer): Well"],
                             @[@"南方炎天・南方朱雀・鬼金羊", @"南方朱雀・鬼・たまをのぼし", @"Vermilion Bird of the South(Summer): Ghost"],
                             @[@"南方炎天・南方朱雀・柳土獐", @"南方朱雀・柳・ぬりこぼし", @"Vermilion Bird of the South(Summer): Willow"],
                             @[@"南方炎天・南方朱雀・星日马", @"南方朱雀・星・ほとおりぼし", @"Vermilion Bird of the South(Summer): Star"],
                             @[@"东南阳天・南方朱雀・张月鹿", @"南方朱雀・張・ちりこぼし", @"Vermilion Bird of the South(Summer): Extended Net"],
                             @[@"东南阳天・南方朱雀・翼火蛇", @"南方朱雀・翼・襷星（たすきぼし）", @"Vermilion Bird of the South(Summer): Wings"],
                             @[@"东南阳天・南方朱雀・轸水蚓", @"南方朱雀・軫・みつかけぼし", @"Vermilion Bird of the South(Summer): Chariot"]];
    
    [self.mansions28SliderArray makeObjectsPerformSelector:@selector(setDelegate:) withObject:self];
    [self.controlSliderArray makeObjectsPerformSelector:@selector(setDelegate:) withObject:self];
}

#pragma mark -
#pragma mark Methods From NSWindowDelegate
- (BOOL)windowShouldClose:(id)sender {
    [NSApp terminate:self];
    return YES;
}

#pragma mark -
#pragma mark Methods From SJTSliderDelegate
- (NSString *)slider:(SJTSlider *)slider tipForValue:(double)value {
    NSString *result;
    NSInteger integerValue = value;
    if (slider==self.aboveSlider) {
        result = @[@"Minimal Tip", @"HUD Tip", @"Disable Tip"][integerValue];
    } else if (slider==self.belowSlider) {
        result = @[@"Tick Mark Values Only", @"All Values"][integerValue];
    } else if (slider==self.leftSlider) {
        result = @[@"中文", @"日本語", @"English", @"All Languages"][integerValue];
    } else if (slider==self.rightSlider) {
        result = @[@"Auto Alignment", @"Center Alignment", @"Left Alignment", @"Right Alignment"][integerValue];
    } else {
        NSInteger dataIndex = [self dataIndexFromValue:integerValue forSlider:slider];
        if (self.leftSlider.integerValue<3) {
            result = self.mansions28Array[dataIndex][self.leftSlider.integerValue];
        } else {
            result = [NSString stringWithFormat:@"%@\n%@\n%@",
                      self.mansions28Array[dataIndex][0],
                      self.mansions28Array[dataIndex][1],
                      self.mansions28Array[dataIndex][2]];
        }
    }
    
    return result;
}

- (void)valueDidSelectInSlider:(SJTSlider *)slider {
    if ([self.mansions28SliderArray containsObject:slider]) {
        [[NSAlert alertWithMessageText:self.titleArray[self.leftSlider.integerValue%3]
                         defaultButton:@"OK"
                       alternateButton:nil
                           otherButton:nil
             informativeTextWithFormat:@"%@", [self slider:self.centerSlider tipForValue:self.centerSlider.doubleValue]]
         beginSheetModalForWindow:self.window modalDelegate:nil didEndSelector:NULL contextInfo:nil];
    }
}

#pragma mark -
#pragma mark Own Methods
- (IBAction)actionFromSlider:(SJTSlider *)sender {
    if (sender==self.aboveSlider) {
        switch (sender.integerValue) {
            case 0:
                for (SJTSlider *slider in self.mansions28SliderArray) {
                    slider.tipEnabled = YES;
                    slider.tipPopoverAppearance = NSPopoverAppearanceMinimal;
                }
                break;
            case 1:
                for (SJTSlider *slider in self.mansions28SliderArray) {
                    slider.tipEnabled = YES;
                    slider.tipPopoverAppearance = NSPopoverAppearanceHUD;
                }
                break;
            default:
                for (SJTSlider *slider in self.mansions28SliderArray) {
                    slider.tipEnabled = NO;
                }
                break;
        }
    } else if (sender==self.belowSlider) {
        if (sender.integerValue==0) {
            for (SJTSlider *slider in self.mansions28SliderArray) {
                slider.numberOfTickMarks = slider==self.centerSlider?28:7;
                slider.allowsTickMarkValuesOnly = YES;
            }
        } else {
            for (SJTSlider *slider in self.mansions28SliderArray) {
                slider.numberOfTickMarks = 0;
                slider.allowsTickMarkValuesOnly = NO;
            }
        }
    } else if (sender==self.leftSlider) {
        self.window.title = self.titleArray[self.leftSlider.integerValue%3];
    } else if (sender==self.rightSlider) {
        switch (self.rightSlider.integerValue) {
            case 1:
                for (SJTSlider *slider in self.mansions28SliderArray) {
                    slider.tipAutoAlignment = NO;
                    slider.tipAlignment = NSCenterTextAlignment;
                }
                break;
            case 2:
                for (SJTSlider *slider in self.mansions28SliderArray) {
                    slider.tipAutoAlignment = NO;
                    slider.tipAlignment = NSLeftTextAlignment;
                }
                break;
            case 3:
                for (SJTSlider *slider in self.mansions28SliderArray) {
                    slider.tipAutoAlignment = NO;
                    slider.tipAlignment = NSRightTextAlignment;
                }
                break;
            default:
                for (SJTSlider *slider in self.mansions28SliderArray) {
                    slider.tipAutoAlignment = YES;
                }
                break;
        }
    } else {
        for (SJTSlider *slider in self.mansions28SliderArray) {
            if (slider!=sender) {
                slider.integerValue = [self valueFromDataIndex:[self dataIndexFromValue:sender.integerValue forSlider:sender] forSlider:slider];
            }
        }
    }
}

- (NSInteger)dataIndexFromValue:(NSInteger)value forSlider:(SJTSlider *)slider {
    NSInteger index = 0;
    if (slider==self.centerSlider) {
        index = (value+10)%28;
    } else if (slider==self.eastSlider) {
        index = value;
    } else if (slider==self.northSlider) {
        index = (value+7)%28;
    } else if (slider==self.westSlider) {
        index = (6-value+14)%28;
    } else if (slider==self.southSlider) {
        index = (6-value+21)%28;
    }
    return index;
}

- (NSInteger)valueFromDataIndex:(NSInteger)index forSlider:(SJTSlider *)slider {
    NSInteger value = 0;
    if (slider==self.centerSlider) {
        value = (index+28-10)%28;
    } else if (slider==self.eastSlider) {
        value = index;
    } else if (slider==self.northSlider) {
        value = index-7;
    } else if (slider==self.westSlider) {
        value = 6-(index-14);
    } else if (slider==self.southSlider) {
        value = 6-(index-21);
    }
    if (slider!=self.centerSlider) {
        value = MAX(MIN(value, 7), 0);
    }
    return value;
}

@end
