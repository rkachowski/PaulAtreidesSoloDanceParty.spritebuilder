//
//  UIFlowManager.m
//  PaulAtreides
//
//  Created by Donald Hutchison on 10/01/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "UIFlowManager.h"

typedef void (^UIBlock)();

static UIFlowManager *__sharedManager;

@implementation UIFlowManager
{
    NSDictionary *_uiFlow;
}

+ (UIFlowManager *)sharedManager
{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
    {
        __sharedManager = [[UIFlowManager alloc] init];
    });

    return __sharedManager;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setupUIFlow];
        [self listenForNotifications];
    }

    return self;
}

- (void)listenForNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onMessage:) name:@"ui" object:nil];
}

- (void)setupUIFlow
{


    _uiFlow = @{
            @"MainScene" : @{
                    @"play" : @"RoomScene"
            },
            @"RoomScene" : @{
                    @"dance" : @"DanceScene",
                    @"die" : @"GameOverScene",
                    @"win" : @"WinScene"
            },
            @"DanceScene" : @{
                    @"pop" : ^()
                    {
                        [[CCDirector sharedDirector] popScene];
                    },
                    @"die" : @"GameOverScene"
            },
            @"GameOverScene" : @{
                    @"again" : ^()
                    {
                        [[CCDirector sharedDirector] popToRootScene];
                    }
            },
            @"WinScene" : @{
                    @"again" : ^()
                    {
                        [[CCDirector sharedDirector] popToRootScene];
                    }
            }
    };
}

- (void)onMessage:(NSNotification *)notification
{
    NSString *message = notification.userInfo[@"message"];
    NSString *sender = notification.userInfo[@"sender"];
    [self handleUIMessage:message from:sender];
}

- (void)handleUIMessage:(NSString *)message from:(NSString *)from
{
    NSString *currentScene = from;
    NSDictionary *flowForScene = _uiFlow[currentScene];

    if (flowForScene[message])
    {
        if (![flowForScene[message] isKindOfClass:[NSString class]])
        {
            UIBlock block = (UIBlock) flowForScene[message];
            block();
        }
        else
        {

            CCScene *nextScene = [CCBReader loadAsScene:flowForScene[message]];
            [[CCDirector sharedDirector] pushScene:nextScene];

        }
    }
    else
    {
        NSLog(@"No flow for message : %@ !!!", message);
    }
}
@end
