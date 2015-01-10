#import <Foundation/Foundation.h>

@interface CCNode (UIFlow)


- (void)sendUIMessage:(NSString *)message;

- (void)sendUIMessage:(NSString *)message withInfo:(NSDictionary *)info;
@end