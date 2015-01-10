#import "GameConfig.h"


static GameConfig *__sharedConfig;

@implementation GameConfig
{

    NSMutableDictionary *_config;
}

+ (GameConfig*)sharedConfig
{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedConfig = [[GameConfig alloc] init];
    });

    return __sharedConfig;
}


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setup];
    }

    return self;
}

- (void)setup
{
    _config = [NSMutableDictionary dictionary];
}

- (void)setValue:(id)value forKey:(id)key
{
    _config[key] = value;
}

-(id)getValueForKey:(id)key
{
    return _config[key];
}


@end