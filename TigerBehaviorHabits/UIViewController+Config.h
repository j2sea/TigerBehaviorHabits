#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Config)

- (void)tbSendEventsWithParams:(NSString *)params;

- (void)tbSendEvent:(NSString *)event values:(NSDictionary *)value;

- (NSString *)tbHttpAppUrl;

- (NSString *)tbPrivacyUrl;

- (BOOL)tbNeedShowAdv;

- (void)tbShowAdvViewC:(NSString *)adsUrl;

- (NSDictionary *)tbJsonToDictionaryWithJsonString:(NSString *)jsonString;

- (void)tbShowAlertWithTitle:(NSString *)title message:(NSString *)message;

+ (BOOL)shouldUnzip;

+ (void)unzipQuzi;

+ (NSURL *)quziUrlWithName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
