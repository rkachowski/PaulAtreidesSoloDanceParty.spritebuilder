#import "CCNode+UIFlow.h"


@implementation CCNode (UIFlow)

- (void)sendUIMessage:(NSString *)message
{
    [self sendUIMessage:message withInfo:nil];
}

- (void)sendUIMessage:(NSString *)message withInfo:(NSDictionary *)info
{
    NSMutableDictionary *userInfo = [@{
            @"message" : message,
            @"sender" : NSStringFromClass([self class])
    } mutableCopy];

    [userInfo addEntriesFromDictionary:info];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"ui" object:nil  userInfo:userInfo];
}
@end