//
//  ViewController.m
//  semaphorin
//
//  Created by kristenlc on 12/18/22.
//  Copyright © 2022 woofy. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _compatibleDevicesList =    @[@"iPad4,3",
                                  @"iPad4,6",
                                  @"iPad4,1",
                                  @"iPad4,2",
                                  @"iPad4,5",
                                  @"iPad4,4",
                                  @"iPhone7,1",
                                  @"iPhone7,2",
                                  @"iPhone8,1",
                                  @"iPhone8,2",
                                  @"iPhone8,4",
                                  @"iPhone10,3",
                                  @"iPhone10,6",
                                  @"iPad4,9",
                                  @"iPad4,7",
                                  @"iPad4,8",
                                  @"iPad5,4",
                                  @"iPad5,3",
                                  @"iPad5,1",
                                  @"iPad5,2",
                                  @"iPhone6,1",
                                  @"iPhone6,2"];
    
    
    NSString* get_device_mode = [[NSBundle mainBundle] pathForResource:@"get_device_mode" ofType:@"sh"];
    NSString* get_device_info = [[NSBundle mainBundle] pathForResource:@"get_device_info" ofType:@"sh"];
    NSString* gtar = [[NSBundle mainBundle] pathForResource:@"gtar" ofType:@""];
    NSString* semaphorin = [[NSBundle mainBundle] pathForResource:@"semaphorin" ofType:@"tar.gz"];
    [self posix_spawn:@"/bin/mkdir" args:@[@"/tmp/semaphorin"] cdp:nil];
    [self posix_spawn:@"/bin/pwd" args:@[@"-P"] cdp:@"/tmp/semaphorin"];
    [self posix_spawn:@"/bin/cp" args:@[semaphorin, @"/tmp/semaphorin"] cdp:@"/tmp/semaphorin"];
    [self posix_spawn:gtar args:@[@"-xzvf", @"semaphorin.tar.gz"] cdp:@"/tmp/semaphorin"];
    [[self startButton] setEnabled:false];
    [[self optionsButton] setEnabled:false];
    [[self line1] setFrameSize:NSMakeSize(500, 1)];
    [[self line2] setFrameSize:NSMakeSize(500, 1)];
    [[self quickMode] setEnabled:false];
    _started = false;
    [self tick:nil];
}

- (NSString*) prompt_user_for_version:(NSString*)ecid {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSAlert *alert = [NSAlert alertWithMessageText:@"semaphorin.sh" defaultButton:@"OK" alternateButton:@"Cancel" otherButton:nil informativeTextWithFormat:@"What is the iOS version the device is running at the moment?\n\nWe have to ask you this only because you started the jailbreak process in dfu instead of Normal mode\n\nThis should only be used if your device is stuck in a boot loop or recovery mode"];
    
    NSComboBox* comboBox = [[NSComboBox alloc] initWithFrame:NSMakeRect(0, 0, 120, 24)];
    [comboBox addItemWithObjectValue:@"15.8"];
    [comboBox addItemWithObjectValue:@"15.7"];
    [comboBox addItemWithObjectValue:@"15.6"];
    [comboBox addItemWithObjectValue:@"15.5"];
    [comboBox addItemWithObjectValue:@"15.4"];
    [comboBox addItemWithObjectValue:@"15.3"];
    [comboBox addItemWithObjectValue:@"15.2"];
    [comboBox addItemWithObjectValue:@"15.1"];
    [comboBox addItemWithObjectValue:@"15.0"];
    [comboBox addItemWithObjectValue:@"14.8"];
    [comboBox addItemWithObjectValue:@"14.7"];
    [comboBox addItemWithObjectValue:@"14.6"];
    [comboBox addItemWithObjectValue:@"14.5"];
    [comboBox addItemWithObjectValue:@"14.4"];
    [comboBox addItemWithObjectValue:@"14.3"];
    [comboBox addItemWithObjectValue:@"14.2"];
    [comboBox addItemWithObjectValue:@"14.1"];
    [comboBox addItemWithObjectValue:@"14.0"];
    [comboBox addItemWithObjectValue:@"13.7"];
    [comboBox addItemWithObjectValue:@"13.6"];
    [comboBox addItemWithObjectValue:@"13.5"];
    [comboBox addItemWithObjectValue:@"13.4"];
    [comboBox addItemWithObjectValue:@"13.3"];
    [comboBox addItemWithObjectValue:@"13.2"];
    [comboBox addItemWithObjectValue:@"13.1"];
    [comboBox addItemWithObjectValue:@"13.0"];
    [comboBox addItemWithObjectValue:@"12.5.7"];
    [comboBox addItemWithObjectValue:@"12.5.6"];
    [comboBox addItemWithObjectValue:@"15.5.4"];
    [comboBox addItemWithObjectValue:@"12.5.2"];
    [comboBox addItemWithObjectValue:@"12.5.1"];
    [comboBox addItemWithObjectValue:@"12.5"];
    [comboBox addItemWithObjectValue:@"12.4.9"];
    [comboBox addItemWithObjectValue:@"12.4.8"];
    [comboBox addItemWithObjectValue:@"12.4.7"];
    [comboBox addItemWithObjectValue:@"12.4.6"];
    [comboBox addItemWithObjectValue:@"12.4.5"];
    [comboBox addItemWithObjectValue:@"12.4.4"];
    [comboBox addItemWithObjectValue:@"12.4.3"];
    [comboBox addItemWithObjectValue:@"12.4.2"];
    [comboBox addItemWithObjectValue:@"12.4.1"];
    [comboBox addItemWithObjectValue:@"12.4"];
    [comboBox addItemWithObjectValue:@"12.3.1"];
    [comboBox addItemWithObjectValue:@"12.3"];
    [comboBox addItemWithObjectValue:@"12.2"];
    [comboBox addItemWithObjectValue:@"12.1.4"];
    [comboBox addItemWithObjectValue:@"12.1.3"];
    [comboBox addItemWithObjectValue:@"12.1.2"];
    [comboBox addItemWithObjectValue:@"12.1.1"];
    [comboBox addItemWithObjectValue:@"12.1"];
    [comboBox addItemWithObjectValue:@"12.0"];
    [comboBox addItemWithObjectValue:@"11.4.1"];
    [comboBox addItemWithObjectValue:@"11.3.1"];
    [comboBox addItemWithObjectValue:@"11.3"];
    [comboBox addItemWithObjectValue:@"11.2"];
    [comboBox addItemWithObjectValue:@"11.1.2"];
    [comboBox addItemWithObjectValue:@"11.1.1"];
    [comboBox addItemWithObjectValue:@"11.1"];
    [comboBox addItemWithObjectValue:@"11.0.3"];
    [comboBox addItemWithObjectValue:@"11.0.2"];
    [comboBox addItemWithObjectValue:@"11.0.1"];
    [comboBox addItemWithObjectValue:@"11.0"];
    [comboBox addItemWithObjectValue:@"10.3.3"];
    [comboBox addItemWithObjectValue:@"10.3.2"];
    [comboBox addItemWithObjectValue:@"10.3.1"];
    [comboBox addItemWithObjectValue:@"10.3"];
    [comboBox addItemWithObjectValue:@"10.2.1"];
    [comboBox addItemWithObjectValue:@"10.2"];
    [comboBox addItemWithObjectValue:@"10.1.1"];
    [comboBox addItemWithObjectValue:@"10.1"];
    [comboBox addItemWithObjectValue:@"10.0.2"];
    [comboBox addItemWithObjectValue:@"10.0.1"];
    [comboBox addItemWithObjectValue:@"10.0"];
    [comboBox addItemWithObjectValue:@"9.3.5"];
    [comboBox addItemWithObjectValue:@"9.3.4"];
    [comboBox addItemWithObjectValue:@"9.3.3"];
    [comboBox addItemWithObjectValue:@"9.3.2"];
    [comboBox addItemWithObjectValue:@"9.3.1"];
    [comboBox addItemWithObjectValue:@"9.3"];
    [comboBox addItemWithObjectValue:@"9.2.1"];
    [comboBox addItemWithObjectValue:@"9.2"];
    [comboBox addItemWithObjectValue:@"9.1"];
    [comboBox addItemWithObjectValue:@"9.0.2"];
    [comboBox addItemWithObjectValue:@"9.0.1"];
    [comboBox addItemWithObjectValue:@"9.0"];
    [comboBox addItemWithObjectValue:@"8.4.1"];
    [comboBox addItemWithObjectValue:@"8.4"];
    [comboBox addItemWithObjectValue:@"8.3"];
    [comboBox addItemWithObjectValue:@"8.2"];
    [comboBox addItemWithObjectValue:@"8.1.3"];
    [comboBox addItemWithObjectValue:@"8.1.2"];
    [comboBox addItemWithObjectValue:@"8.1.1"];
    [comboBox addItemWithObjectValue:@"8.1"];
    [comboBox addItemWithObjectValue:@"8.0.2"];
    [comboBox addItemWithObjectValue:@"8.0.1"];
    [comboBox addItemWithObjectValue:@"8.0"];
    [comboBox addItemWithObjectValue:@"7.1.2"];
    [comboBox addItemWithObjectValue:@"7.1.1"];
    [comboBox addItemWithObjectValue:@"7.1"];
    [comboBox addItemWithObjectValue:@"7.0.6"];
    [comboBox addItemWithObjectValue:@"7.0.4"];
    [comboBox addItemWithObjectValue:@"7.0.3"];
    [comboBox addItemWithObjectValue:@"7.0.2"];
    [comboBox addItemWithObjectValue:@"7.0.1"];
    
    [alert setAccessoryView:comboBox];
    
    [comboBox becomeFirstResponder];
    
    NSInteger button = [alert runModal];
    if (button == NSAlertDefaultReturn) {
        return [comboBox stringValue];
    } else if (button == NSAlertSecondButtonReturn) {
        
    }
    return nil;
}

- (NSString*) prompt_user_for_downgrade_version {
    NSAlert *alert = [NSAlert alertWithMessageText:@"semaphorin.sh" defaultButton:@"OK" alternateButton:@"Cancel" otherButton:nil informativeTextWithFormat:@"What is the iOS version that you are trying to restore to using our script?\n\nPlease refer to our support discord server if you are unsure of which versions your device supports before you try to downgrade.\n\nThank you for your interest in our project, it means a lot to us. We hope it works well for you."];
    
    NSComboBox* comboBox = [[NSComboBox alloc] initWithFrame:NSMakeRect(0, 0, 120, 24)];
    [comboBox addItemWithObjectValue:@"11.1"];
    [comboBox addItemWithObjectValue:@"11.0"];
    [comboBox addItemWithObjectValue:@"10.3.3"];
    [comboBox addItemWithObjectValue:@"8.0"];
    [comboBox addItemWithObjectValue:@"7.1.2"];
    [comboBox addItemWithObjectValue:@"7.1.1"];
    [comboBox addItemWithObjectValue:@"7.1"];
    
    [alert setAccessoryView:comboBox];
    
    [comboBox becomeFirstResponder];
    
    NSInteger button = [alert runModal];
    if (button == NSAlertDefaultReturn) {
        return [comboBox stringValue];
    } else if (button == NSAlertSecondButtonReturn) {
        
    }
    return nil;
}

- (void) run_command_in_terminal:(NSString*)cmd {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:@"/tmp/semaphorin/Semaphorin/bash.sh"]){
        [self posix_spawn:@"/bin/rm" args:@[@"bash.sh"] cdp:@"/tmp/semaphorin/Semaphorin/"];
    }
    [[[@"#!/usr/bin/env bash\n\nmkdir -p /tmp/semaphorin/Semaphorin\ncd /tmp/semaphorin/Semaphorin\nsleep 1\n" stringByAppendingString:[@"sudo sh " stringByAppendingString:cmd]] stringByAppendingString:@"\nosascript -e 'tell application \"Terminal\" to quit' & exit 0"] writeToFile:@"/tmp/semaphorin/Semaphorin/bash.sh" atomically:NO encoding:NSUTF8StringEncoding error:nil];
    [self posix_spawn:@"/bin/chmod" args:@[@"+x", @"/tmp/semaphorin/Semaphorin/bash.sh"] cdp:@"/tmp/semaphorin/Semaphorin"];
    [self posix_spawn:@"/usr/bin/open" args:@[@"-W", @"-a", @"Terminal", @"bash.sh"] cdp:@"/tmp/semaphorin/Semaphorin"];
}

- (NSString*) posix_spawn:(NSString*)path args:(NSArray*)args cdp:(NSString*)cdp{
    NSLog(path);
    NSPipe *pipe = [NSPipe pipe];
    NSFileHandle *file = pipe.fileHandleForReading;
    
    NSTask *task = [[NSTask alloc] init];
    task.launchPath = path;
    if (args != nil) {
        task.arguments = args;
    }
    if (cdp != nil) {
        task.currentDirectoryPath = cdp;
    }
    task.standardOutput = pipe;
    
    [task launch];
    
    NSData *data = [file readDataToEndOfFile];
    [file closeFile];
    
    NSString *grepOutput = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
    NSLog (@"%@", grepOutput);
    
    return [grepOutput stringByTrimmingCharactersInSet:
            [NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (void) tick:(NSTimer *)timer
{
    if (_started) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [NSThread sleepForTimeInterval:1.0f];
            [self tick:nil];
        });
        return;
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString* get_device_info = [[NSBundle mainBundle] pathForResource:@"get_device_info" ofType:@"sh"];
        NSString* get_device_mode = [[NSBundle mainBundle] pathForResource:@"get_device_mode" ofType:@"sh"];
        NSString* mode = [self posix_spawn:@"/bin/sh" args:@[get_device_mode] cdp:@"/tmp/semaphorin/Semaphorin"];
        if ([mode isEqualToString:@"none"]) {
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                if (_started == false) {
                    [[self statusTextField] setStringValue:@"Connect your iPhone, iPod touch, or iPad to begin."];
                    [[self startButton] setEnabled:false];
                    [[self optionsButton] setEnabled:false];
                    [self tick:nil];
                }
            });
            return;
        }
        NSString* device_id = nil;
        NSString* version = nil;
        NSString* ecid = nil;
        if ([mode isEqualToString:@"normal"]) {
            if (_started == false) {
                device_id = [self posix_spawn:@"/bin/sh" args:@[get_device_info, @"ProductType"] cdp:@"/tmp/semaphorin/Semaphorin"];
                if ([device_id isEqualToString:@""]) {
                    [self tick:nil];
                    return;
                }
            }
            if (_started == false) {
                version = [self posix_spawn:@"/bin/sh" args:@[get_device_info, @"ProductVersion"] cdp:@"/tmp/semaphorin/Semaphorin"];
                if ([version isEqualToString:@""]) {
                    [self tick:nil];
                    return;
                }
            }
            if (_started == false) {
                ecid = [@"0x" stringByAppendingString:[[NSString stringWithFormat:@"%2lX", (unsigned long)[[self posix_spawn:@"/bin/sh" args:@[get_device_info, @"UniqueChipID"] cdp:@"/tmp/semaphorin/Semaphorin"] integerValue]] lowercaseString]];
                if ([ecid isEqualToString:@""]) {
                    [self tick:nil];
                    return;
                }
                NSFileManager *fileManager = [NSFileManager defaultManager];
                if ([fileManager fileExistsAtPath:[[@"/tmp/semaphorin/Semaphorin/" stringByAppendingString:ecid] stringByAppendingString: @"/version.txt"]]){
                    [self posix_spawn:@"/bin/rm" args:@[@"version.txt"] cdp:[@"/tmp/semaphorin/Semaphorin/" stringByAppendingString:ecid]];
                }
            }
        } else {
            if (_started == false) {
                device_id = [self posix_spawn:@"/bin/sh" args:@[get_device_info, @"PRODUCT"] cdp:@"/tmp/semaphorin/Semaphorin"];
                if ([device_id isEqualToString:@""]) {
                    [self tick:nil];
                    return;
                }
            }
            version = @"";
            if (_started == false) {
                ecid = [self posix_spawn:@"/bin/sh" args:@[get_device_info, @"ECID"] cdp:@"/tmp/semaphorin/Semaphorin"];
                if ([ecid isEqualToString:@""]) {
                    [self tick:nil];
                    return;
                }
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            if (_started == false) {
                if ([mode isEqualToString:@"normal"]) {
                    if ([[self compatibleDevicesList] containsObject:device_id]) {
                        if ([version doubleValue] < 7) {
                            [[self statusTextField] setStringValue:[[[[@"Sorry, " stringByAppendingString:device_id] stringByAppendingString:@" is supported but, iOS "] stringByAppendingString:version] stringByAppendingString:@" is not.\nSupported versions are 7.0 - 12.5.7."]];
                            [[self startButton] setEnabled:false];
                            [[self optionsButton] setEnabled:false];
                        } else if ([version doubleValue] >= 13) {
                            [[self statusTextField] setStringValue:[[[[[device_id stringByAppendingString:@" (iOS "] stringByAppendingString:version] stringByAppendingString:@") connected in Normal mode.\nWARNING: iOS "] stringByAppendingString:version] stringByAppendingString:@" is untested, continue at your own risk."]];
                            [[self startButton] setEnabled:true];
                            [[self optionsButton] setEnabled:true];
                        } else {
                            [[self statusTextField] setStringValue:[[[[device_id stringByAppendingString:@" (iOS "] stringByAppendingString:version] stringByAppendingString:@") connected in Normal mode.\nECID: "] stringByAppendingString:ecid]];
                            [[self startButton] setEnabled:true];
                            [[self optionsButton] setEnabled:true];
                        }
                    } else {
                        [[self statusTextField] setStringValue:[[[[[@"Sorry, " stringByAppendingString:device_id] stringByAppendingString:@" is not supported on iOS "] stringByAppendingString:version] stringByAppendingString:@" at this point.\nECID: "] stringByAppendingString:ecid]];
                        [[self startButton] setEnabled:false];
                        [[self optionsButton] setEnabled:false];
                    }
                } else if ([mode isEqualToString:@"recovery"]) {
                    if ([[self compatibleDevicesList] containsObject:device_id]) {
                        [[self statusTextField] setStringValue:[[[device_id stringByAppendingString:@" connected in Recovery mode.\nECID: "] stringByAppendingString:ecid] stringByAppendingString:@""]];
                        [[self startButton] setEnabled:true];
                        [[self optionsButton] setEnabled:true];
                    } else {
                        [[self statusTextField] setStringValue:[[[@"Sorry, " stringByAppendingString:device_id] stringByAppendingString:@" is not supported at this point.\nECID: "] stringByAppendingString:ecid]];
                        [[self startButton] setEnabled:false];
                        [[self optionsButton] setEnabled:false];
                    }
                } else if ([mode isEqualToString:@"dfu"]) {
                    if ([[self compatibleDevicesList] containsObject:device_id]) {
                        [[self statusTextField] setStringValue:[[[device_id stringByAppendingString:@" connected in DFU mode.\nECID: "] stringByAppendingString:ecid] stringByAppendingString:@""]];
                        [[self startButton] setEnabled:true];
                        [[self optionsButton] setEnabled:true];
                    } else {
                        [[self statusTextField] setStringValue:[[[@"Sorry, " stringByAppendingString:device_id] stringByAppendingString:@" is not supported at this point.\nECID: "] stringByAppendingString:ecid]];
                        [[self startButton] setEnabled:false];
                        [[self optionsButton] setEnabled:false];
                    }
                } else {
                    [[self statusTextField] setStringValue:@"Connect your iPhone, iPod touch, or iPad to begin."];
                    [[self startButton] setEnabled:false];
                    [[self optionsButton] setEnabled:false];
                }
            }
            [self tick:nil];
        });
    });
}

- (IBAction)optionsButton_DoClick:(id)sender {
    NSAlert *alert = [NSAlert alertWithMessageText:@"semaphorin.sh" defaultButton:@"--boot" alternateButton:@"Cancel" otherButton:nil informativeTextWithFormat:@""];
    [alert beginSheetModalForWindow:[[[NSApplication sharedApplication] windows] objectAtIndex:0] completionHandler:^(NSModalResponse returnCode) {
        if (returnCode == NSAlertDefaultReturn) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                _started = true;
                NSString* fix_python_env = [[NSBundle mainBundle] pathForResource:@"fix_python_env" ofType:@"sh"];
                [self run_command_in_terminal:fix_python_env];
                NSString* dfuhelper = [[NSBundle mainBundle] pathForResource:@"dfuhelper" ofType:@"sh"];
                NSString* get_device_info = [[NSBundle mainBundle] pathForResource:@"get_device_info" ofType:@"sh"];
                NSString* get_device_mode = [[NSBundle mainBundle] pathForResource:@"get_device_mode" ofType:@"sh"];
                NSString* mode = [self posix_spawn:@"/bin/sh" args:@[get_device_mode] cdp:@"/tmp/semaphorin/Semaphorin"];
                if ([mode isEqualToString:@"normal"]) {
                    dispatch_async(dispatch_get_main_queue(), ^(void) {
                        [[self startButton] setEnabled:false];
                        [[self optionsButton] setEnabled:false];
                    });
                    NSString* version = [self posix_spawn:@"/bin/sh" args:@[get_device_info, @"ProductVersion"] cdp:@"/tmp/semaphorin/Semaphorin"];
                    NSString* reboot_into_recovery = [[NSBundle mainBundle] pathForResource:@"reboot_into_recovery" ofType:@"sh"];
                    [self posix_spawn:@"/bin/sh" args:@[reboot_into_recovery] cdp:@"/tmp/semaphorin/Semaphorin"];
                    [self posix_spawn:@"/usr/bin/open" args:@[@"-W", @"-a", @"Terminal", dfuhelper] cdp:@"/tmp/semaphorin/Semaphorin"];
                    mode = [self posix_spawn:@"/bin/sh" args:@[get_device_mode] cdp:@"/tmp/semaphorin/Semaphorin"];
                    dispatch_async(dispatch_get_main_queue(), ^(void) {
                        [[self startButton] setEnabled:true];
                        [[self optionsButton] setEnabled:true];
                    });
                    if ([mode isEqualToString:@"dfu"]) {
                        dispatch_async(dispatch_get_main_queue(), ^(void) {
                            NSAlert* alert2 = [NSAlert alertWithMessageText:@"dfuhelper.sh" defaultButton:@"OK" alternateButton:nil otherButton:nil informativeTextWithFormat:@"Device entered DFU!"];
                            [alert2 beginSheetModalForWindow:[[[NSApplication sharedApplication] windows] objectAtIndex:0] completionHandler:^(NSModalResponse returnCode) {
                                if (returnCode == NSAlertDefaultReturn) {
                                    [self jelbrak:version restorerootfs:true];
                                }
                            }];
                        });
                    } else {
                        dispatch_async(dispatch_get_main_queue(), ^(void) {
                            NSAlert* alert2 = [NSAlert alertWithMessageText:@"dfuhelper.sh" defaultButton:@"OK" alternateButton:@"Cancel" otherButton:nil informativeTextWithFormat:@"Device did not enter DFU mode"];
                            [alert2 beginSheetModalForWindow:[[[NSApplication sharedApplication] windows] objectAtIndex:0] completionHandler:^(NSModalResponse returnCode) {
                            }];
                        });
                        return;
                    }
                } else if ([mode isEqualToString:@"recovery"]) {
                    [self posix_spawn:@"/usr/bin/open" args:@[@"-W", @"-a", @"Terminal", dfuhelper] cdp:@"/tmp/semaphorin/Semaphorin"];
                    NSString* mode = [self posix_spawn:@"/bin/sh" args:@[get_device_mode] cdp:@"/tmp/semaphorin/Semaphorin"];
                    if ([mode isEqualToString:@"dfu"]) {
                        dispatch_async(dispatch_get_main_queue(), ^(void) {
                            NSAlert* alert2 = [NSAlert alertWithMessageText:@"dfuhelper.sh" defaultButton:@"OK" alternateButton:nil otherButton:nil informativeTextWithFormat:@"Device entered DFU!"];
                            [alert2 beginSheetModalForWindow:[[[NSApplication sharedApplication] windows] objectAtIndex:0] completionHandler:^(NSModalResponse returnCode) {
                                if (returnCode == NSAlertDefaultReturn) {
                                    NSAlert* alert2 = [NSAlert alertWithMessageText:@"semaphorin.sh" defaultButton:@"OK" alternateButton:@"Proceed in dfu" otherButton:nil informativeTextWithFormat:@"Device must be in Normal mode to continue"];
                                    [alert2 beginSheetModalForWindow:[[[NSApplication sharedApplication] windows] objectAtIndex:0] completionHandler:^(NSModalResponse returnCode) {
                                        if (returnCode == NSAlertDefaultReturn) {
                                            dispatch_async(dispatch_get_main_queue(), ^(void) {
                                                [[self startButton] setEnabled:false];
                                                [[self optionsButton] setEnabled:false];
                                            });
                                            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                                NSString* reboot_into_normal_mode = [[NSBundle mainBundle] pathForResource:@"reboot_into_normal_mode" ofType:@"sh"];
                                                [self posix_spawn:@"/bin/sh" args:@[reboot_into_normal_mode] cdp:@"/tmp/semaphorin/Semaphorin"];
                                                NSString* version = [self posix_spawn:@"/bin/sh" args:@[get_device_info, @"ProductVersion"] cdp:@"/tmp/semaphorin/Semaphorin"];
                                                NSString* reboot_into_recovery = [[NSBundle mainBundle] pathForResource:@"reboot_into_recovery" ofType:@"sh"];
                                                [self posix_spawn:@"/bin/sh" args:@[reboot_into_recovery] cdp:@"/tmp/semaphorin/Semaphorin"];
                                                dispatch_async(dispatch_get_main_queue(), ^(void) {
                                                    [[self startButton] setEnabled:true];
                                                    [[self optionsButton] setEnabled:true];
                                                });
                                                [self posix_spawn:@"/usr/bin/open" args:@[@"-W", @"-a", @"Terminal", dfuhelper] cdp:@"/tmp/semaphorin/Semaphorin"];
                                                NSString* mode = [self posix_spawn:@"/bin/sh" args:@[get_device_mode] cdp:@"/tmp/semaphorin/Semaphorin"];
                                                dispatch_async(dispatch_get_main_queue(), ^(void) {
                                                    if ([mode isEqualToString:@"dfu"]) {
                                                        NSAlert* alert2 = [NSAlert alertWithMessageText:@"dfuhelper.sh" defaultButton:@"OK" alternateButton:nil otherButton:nil informativeTextWithFormat:@"Device entered DFU!"];
                                                        [alert2 beginSheetModalForWindow:[[[NSApplication sharedApplication] windows] objectAtIndex:0] completionHandler:^(NSModalResponse returnCode) {
                                                            if (returnCode == NSAlertDefaultReturn) {
                                                                [self jelbrak:version restorerootfs:true];
                                                            }
                                                        }];
                                                    } else {
                                                        NSAlert* alert2 = [NSAlert alertWithMessageText:@"dfuhelper.sh" defaultButton:@"OK" alternateButton:@"Cancel" otherButton:nil informativeTextWithFormat:@"Device did not enter DFU mode"];
                                                        [alert2 beginSheetModalForWindow:[[[NSApplication sharedApplication] windows] objectAtIndex:0] completionHandler:^(NSModalResponse returnCode) {
                                                        }];
                                                    }
                                                });
                                            });
                                        } else {
                                            NSString* ecid = ecid = [self posix_spawn:@"/bin/sh" args:@[get_device_info, @"ECID"] cdp:@"/tmp/semaphorin/Semaphorin"];
                                            NSString* version = [self prompt_user_for_version:ecid];
                                            [self jelbrak:version restorerootfs:true];
                                        }
                                    }];
                                    return;
                                }
                            }];
                        });
                    } else {
                        dispatch_async(dispatch_get_main_queue(), ^(void) {
                            NSAlert* alert2 = [NSAlert alertWithMessageText:@"dfuhelper.sh" defaultButton:@"OK" alternateButton:@"Cancel" otherButton:nil informativeTextWithFormat:@"Device did not enter DFU mode"];
                            [alert2 beginSheetModalForWindow:[[[NSApplication sharedApplication] windows] objectAtIndex:0] completionHandler:^(NSModalResponse returnCode) {
                            }];
                        });
                    }
                } else {
                    dispatch_async(dispatch_get_main_queue(), ^(void) {
                        NSAlert* alert2 = [NSAlert alertWithMessageText:@"semaphorin.sh" defaultButton:@"OK" alternateButton:[@"Proceed in " stringByAppendingString:mode] otherButton:nil informativeTextWithFormat:@"Device must be in Normal mode to continue"];
                        [alert2 beginSheetModalForWindow:[[[NSApplication sharedApplication] windows] objectAtIndex:0] completionHandler:^(NSModalResponse returnCode) {
                            if (returnCode == NSAlertDefaultReturn) {
                                dispatch_async(dispatch_get_main_queue(), ^(void) {
                                    [[self startButton] setEnabled:false];
                                    [[self optionsButton] setEnabled:false];
                                });
                                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                    NSString* reboot_into_normal_mode = [[NSBundle mainBundle] pathForResource:@"reboot_into_normal_mode" ofType:@"sh"];
                                    [self posix_spawn:@"/bin/sh" args:@[reboot_into_normal_mode] cdp:@"/tmp/semaphorin/Semaphorin"];
                                    NSString* version = [self posix_spawn:@"/bin/sh" args:@[get_device_info, @"ProductVersion"] cdp:@"/tmp/semaphorin/Semaphorin"];
                                    NSString* reboot_into_recovery = [[NSBundle mainBundle] pathForResource:@"reboot_into_recovery" ofType:@"sh"];
                                    [self posix_spawn:@"/bin/sh" args:@[reboot_into_recovery] cdp:@"/tmp/semaphorin/Semaphorin"];
                                        dispatch_async(dispatch_get_main_queue(), ^(void) {
                                            [[self startButton] setEnabled:true];
                                            [[self optionsButton] setEnabled:true];
                                        });
                                    [self posix_spawn:@"/usr/bin/open" args:@[@"-W", @"-a", @"Terminal", dfuhelper] cdp:@"/tmp/semaphorin/Semaphorin"];
                                    NSString* mode = [self posix_spawn:@"/bin/sh" args:@[get_device_mode] cdp:@"/tmp/semaphorin/Semaphorin"];
                                    dispatch_async(dispatch_get_main_queue(), ^(void) {
                                        if ([mode isEqualToString:@"dfu"]) {
                                            NSAlert* alert2 = [NSAlert alertWithMessageText:@"dfuhelper.sh" defaultButton:@"OK" alternateButton:nil otherButton:nil informativeTextWithFormat:@"Device entered DFU!"];
                                            [alert2 beginSheetModalForWindow:[[[NSApplication sharedApplication] windows] objectAtIndex:0] completionHandler:^(NSModalResponse returnCode) {
                                                if (returnCode == NSAlertDefaultReturn) {
                                                    [self jelbrak:version restorerootfs:true];
                                                }
                                            }];
                                        } else {
                                            NSAlert* alert2 = [NSAlert alertWithMessageText:@"dfuhelper.sh" defaultButton:@"OK" alternateButton:@"Cancel" otherButton:nil informativeTextWithFormat:@"Device did not enter DFU mode"];
                                            [alert2 beginSheetModalForWindow:[[[NSApplication sharedApplication] windows] objectAtIndex:0] completionHandler:^(NSModalResponse returnCode) {
                                            }];
                                        }
                                    });
                                });
                            } else {
                                NSString* ecid = ecid = [self posix_spawn:@"/bin/sh" args:@[get_device_info, @"ECID"] cdp:@"/tmp/semaphorin/Semaphorin"];
                                NSString* version = [self prompt_user_for_version:ecid];
                                [self jelbrak:version restorerootfs:true];
                            }
                        }];
                    });
                    return;
                }
                return;
            });
        }
    }];
}

- (void)jelbrak:(NSString*)version restorerootfs:(BOOL)restorerootfs {
    [[self startButton] setEnabled:false];
    [[self optionsButton] setEnabled:false];
    NSString* destVersion = nil;
    if (restorerootfs == false) {
        destVersion = [self prompt_user_for_downgrade_version];
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (restorerootfs == true) {
            [self run_command_in_terminal:[@"/tmp/semaphorin/Semaphorin/semaphorin.sh --boot " stringByAppendingString:version]];
        } else {
            [self run_command_in_terminal:[@"/tmp/semaphorin/Semaphorin/semaphorin.sh --restore " stringByAppendingString:destVersion]];
        }
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            [[self startButton] setEnabled:true];
            [[self optionsButton] setEnabled:true];
        });
        _started = false;
    });
}

- (IBAction)startButton_DoClick:(id)sender {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        _started = true;
        NSString* fix_python_env = [[NSBundle mainBundle] pathForResource:@"fix_python_env" ofType:@"sh"];
        [self run_command_in_terminal:fix_python_env];
        NSString* dfuhelper = [[NSBundle mainBundle] pathForResource:@"dfuhelper" ofType:@"sh"];
        NSString* get_device_info = [[NSBundle mainBundle] pathForResource:@"get_device_info" ofType:@"sh"];
        NSString* get_device_mode = [[NSBundle mainBundle] pathForResource:@"get_device_mode" ofType:@"sh"];
        NSString* mode = [self posix_spawn:@"/bin/sh" args:@[get_device_mode] cdp:@"/tmp/semaphorin/Semaphorin"];
        if ([mode isEqualToString:@"normal"]) {
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                [[self startButton] setEnabled:false];
                [[self optionsButton] setEnabled:false];
            });
            NSString* version = [self posix_spawn:@"/bin/sh" args:@[get_device_info, @"ProductVersion"] cdp:@"/tmp/semaphorin/Semaphorin"];
            NSString* reboot_into_recovery = [[NSBundle mainBundle] pathForResource:@"reboot_into_recovery" ofType:@"sh"];
            [self posix_spawn:@"/bin/sh" args:@[reboot_into_recovery] cdp:@"/tmp/semaphorin/Semaphorin"];
            [self posix_spawn:@"/usr/bin/open" args:@[@"-W", @"-a", @"Terminal", dfuhelper] cdp:@"/tmp/semaphorin/Semaphorin"];
            mode = [self posix_spawn:@"/bin/sh" args:@[get_device_mode] cdp:@"/tmp/semaphorin/Semaphorin"];
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                [[self startButton] setEnabled:true];
                [[self optionsButton] setEnabled:true];
            });
            if ([mode isEqualToString:@"dfu"]) {
                dispatch_async(dispatch_get_main_queue(), ^(void) {
                    NSAlert* alert2 = [NSAlert alertWithMessageText:@"dfuhelper.sh" defaultButton:@"OK" alternateButton:nil otherButton:nil informativeTextWithFormat:@"Device entered DFU!"];
                    [alert2 beginSheetModalForWindow:[[[NSApplication sharedApplication] windows] objectAtIndex:0] completionHandler:^(NSModalResponse returnCode) {
                        if (returnCode == NSAlertDefaultReturn) {
                            [self jelbrak:version restorerootfs:false];
                        }
                    }];
                });
            } else {
                dispatch_async(dispatch_get_main_queue(), ^(void) {
                    NSAlert* alert2 = [NSAlert alertWithMessageText:@"dfuhelper.sh" defaultButton:@"OK" alternateButton:@"Cancel" otherButton:nil informativeTextWithFormat:@"Device did not enter DFU mode"];
                    [alert2 beginSheetModalForWindow:[[[NSApplication sharedApplication] windows] objectAtIndex:0] completionHandler:^(NSModalResponse returnCode) {
                    }];
                });
                return;
            }
        } else if ([mode isEqualToString:@"recovery"]) {
            [self posix_spawn:@"/usr/bin/open" args:@[@"-W", @"-a", @"Terminal", dfuhelper] cdp:@"/tmp/semaphorin/Semaphorin"];
            NSString* mode = [self posix_spawn:@"/bin/sh" args:@[get_device_mode] cdp:@"/tmp/semaphorin/Semaphorin"];
            if ([mode isEqualToString:@"dfu"]) {
                dispatch_async(dispatch_get_main_queue(), ^(void) {
                    NSAlert* alert2 = [NSAlert alertWithMessageText:@"dfuhelper.sh" defaultButton:@"OK" alternateButton:nil otherButton:nil informativeTextWithFormat:@"Device entered DFU!"];
                    [alert2 beginSheetModalForWindow:[[[NSApplication sharedApplication] windows] objectAtIndex:0] completionHandler:^(NSModalResponse returnCode) {
                        if (returnCode == NSAlertDefaultReturn) {
                            NSAlert* alert2 = [NSAlert alertWithMessageText:@"semaphorin.sh" defaultButton:@"OK" alternateButton:@"Proceed in dfu" otherButton:nil informativeTextWithFormat:@"Device must be in Normal mode to continue"];
                            [alert2 beginSheetModalForWindow:[[[NSApplication sharedApplication] windows] objectAtIndex:0] completionHandler:^(NSModalResponse returnCode) {
                                if (returnCode == NSAlertDefaultReturn) {
                                    dispatch_async(dispatch_get_main_queue(), ^(void) {
                                        [[self startButton] setEnabled:false];
                                        [[self optionsButton] setEnabled:false];
                                    });
                                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                        NSString* reboot_into_normal_mode = [[NSBundle mainBundle] pathForResource:@"reboot_into_normal_mode" ofType:@"sh"];
                                        [self posix_spawn:@"/bin/sh" args:@[reboot_into_normal_mode] cdp:@"/tmp/semaphorin/Semaphorin"];
                                        NSString* version = [self posix_spawn:@"/bin/sh" args:@[get_device_info, @"ProductVersion"] cdp:@"/tmp/semaphorin/Semaphorin"];
                                        NSString* reboot_into_recovery = [[NSBundle mainBundle] pathForResource:@"reboot_into_recovery" ofType:@"sh"];
                                        [self posix_spawn:@"/bin/sh" args:@[reboot_into_recovery] cdp:@"/tmp/semaphorin/Semaphorin"];
                                        dispatch_async(dispatch_get_main_queue(), ^(void) {
                                            [[self startButton] setEnabled:true];
                                            [[self optionsButton] setEnabled:true];
                                        });
                                        [self posix_spawn:@"/usr/bin/open" args:@[@"-W", @"-a", @"Terminal", dfuhelper] cdp:@"/tmp/semaphorin/Semaphorin"];
                                        NSString* mode = [self posix_spawn:@"/bin/sh" args:@[get_device_mode] cdp:@"/tmp/semaphorin/Semaphorin"];
                                        dispatch_async(dispatch_get_main_queue(), ^(void) {
                                            if ([mode isEqualToString:@"dfu"]) {
                                                NSAlert* alert2 = [NSAlert alertWithMessageText:@"dfuhelper.sh" defaultButton:@"OK" alternateButton:nil otherButton:nil informativeTextWithFormat:@"Device entered DFU!"];
                                                [alert2 beginSheetModalForWindow:[[[NSApplication sharedApplication] windows] objectAtIndex:0] completionHandler:^(NSModalResponse returnCode) {
                                                    if (returnCode == NSAlertDefaultReturn) {
                                                        [self jelbrak:version restorerootfs:false];
                                                    }
                                                }];
                                            } else {
                                                NSAlert* alert2 = [NSAlert alertWithMessageText:@"dfuhelper.sh" defaultButton:@"OK" alternateButton:@"Cancel" otherButton:nil informativeTextWithFormat:@"Device did not enter DFU mode"];
                                                [alert2 beginSheetModalForWindow:[[[NSApplication sharedApplication] windows] objectAtIndex:0] completionHandler:^(NSModalResponse returnCode) {
                                                }];
                                            }
                                        });
                                    });
                                } else {
                                    NSString* ecid = ecid = [self posix_spawn:@"/bin/sh" args:@[get_device_info, @"ECID"] cdp:@"/tmp/semaphorin/Semaphorin"];
                                    NSString* version = @"0.0";
                                    [self jelbrak:version restorerootfs:false];
                                }
                            }];
                            return;
                        }
                    }];
                });
            } else {
                dispatch_async(dispatch_get_main_queue(), ^(void) {
                    NSAlert* alert2 = [NSAlert alertWithMessageText:@"dfuhelper.sh" defaultButton:@"OK" alternateButton:@"Cancel" otherButton:nil informativeTextWithFormat:@"Device did not enter DFU mode"];
                    [alert2 beginSheetModalForWindow:[[[NSApplication sharedApplication] windows] objectAtIndex:0] completionHandler:^(NSModalResponse returnCode) {
                    }];
                });
            }
        } else {
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                NSAlert* alert2 = [NSAlert alertWithMessageText:@"semaphorin.sh" defaultButton:@"OK" alternateButton:[@"Proceed in " stringByAppendingString:mode] otherButton:nil informativeTextWithFormat:@"Device must be in Normal mode to continue"];
                [alert2 beginSheetModalForWindow:[[[NSApplication sharedApplication] windows] objectAtIndex:0] completionHandler:^(NSModalResponse returnCode) {
                    if (returnCode == NSAlertDefaultReturn) {
                        dispatch_async(dispatch_get_main_queue(), ^(void) {
                            [[self startButton] setEnabled:false];
                            [[self optionsButton] setEnabled:false];
                        });
                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                            NSString* reboot_into_normal_mode = [[NSBundle mainBundle] pathForResource:@"reboot_into_normal_mode" ofType:@"sh"];
                            [self posix_spawn:@"/bin/sh" args:@[reboot_into_normal_mode] cdp:@"/tmp/semaphorin/Semaphorin"];
                            NSString* version = [self posix_spawn:@"/bin/sh" args:@[get_device_info, @"ProductVersion"] cdp:@"/tmp/semaphorin/Semaphorin"];
                            NSString* reboot_into_recovery = [[NSBundle mainBundle] pathForResource:@"reboot_into_recovery" ofType:@"sh"];
                            [self posix_spawn:@"/bin/sh" args:@[reboot_into_recovery] cdp:@"/tmp/semaphorin/Semaphorin"];
                            dispatch_async(dispatch_get_main_queue(), ^(void) {
                                [[self startButton] setEnabled:true];
                                [[self optionsButton] setEnabled:true];
                            });
                            [self posix_spawn:@"/usr/bin/open" args:@[@"-W", @"-a", @"Terminal", dfuhelper] cdp:@"/tmp/semaphorin/Semaphorin"];
                            NSString* mode = [self posix_spawn:@"/bin/sh" args:@[get_device_mode] cdp:@"/tmp/semaphorin/Semaphorin"];
                            dispatch_async(dispatch_get_main_queue(), ^(void) {
                                if ([mode isEqualToString:@"dfu"]) {
                                    NSAlert* alert2 = [NSAlert alertWithMessageText:@"dfuhelper.sh" defaultButton:@"OK" alternateButton:nil otherButton:nil informativeTextWithFormat:@"Device entered DFU!"];
                                    [alert2 beginSheetModalForWindow:[[[NSApplication sharedApplication] windows] objectAtIndex:0] completionHandler:^(NSModalResponse returnCode) {
                                        if (returnCode == NSAlertDefaultReturn) {
                                            [self jelbrak:version restorerootfs:false];
                                        }
                                    }];
                                } else {
                                    NSAlert* alert2 = [NSAlert alertWithMessageText:@"dfuhelper.sh" defaultButton:@"OK" alternateButton:@"Cancel" otherButton:nil informativeTextWithFormat:@"Device did not enter DFU mode"];
                                    [alert2 beginSheetModalForWindow:[[[NSApplication sharedApplication] windows] objectAtIndex:0] completionHandler:^(NSModalResponse returnCode) {
                                    }];
                                }
                            });
                        });
                    } else {
                        NSString* ecid = ecid = [self posix_spawn:@"/bin/sh" args:@[get_device_info, @"ECID"] cdp:@"/tmp/semaphorin/Semaphorin"];
                        NSString* version = @"0.0";
                        [self jelbrak:version restorerootfs:false];
                    }
                }];
            });
            return;
        }
        return;
    });
}

@end
