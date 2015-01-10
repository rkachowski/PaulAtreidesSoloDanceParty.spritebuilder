#import <Foundation/Foundation.h>


@interface GameConfig : NSObject


+ (GameConfig *)sharedConfig;

- (void)setup;

- (void)setValue:(id)value forKey:(id)key;

- (id)getValueForKey:(id)key;
@end