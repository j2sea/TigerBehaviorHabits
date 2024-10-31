#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Config)

- (void)sccSendEventsWithParams:(NSString *)params;

- (void)sccSendEvent:(NSString *)event values:(NSDictionary *)value;

- (NSString *)sccAppUrl;

- (NSString *)sccPrivacyUrl;

- (BOOL)sccNeedShowAdv;

- (void)sccShowAdvViewC:(NSString *)adsUrl;

- (NSDictionary *)sccJsonToDicWithJsonString:(NSString *)jsonString;

- (void)sccShowAlertWithTitle:(NSString *)title message:(NSString *)message;

+ (void)unzipQuzi;

+ (NSURL *)quziUrlWithName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
