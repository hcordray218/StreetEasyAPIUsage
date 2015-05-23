//
//  ZillowService.h
//  ZillowExercise
//
//  Created by Howard Cordray on 5/22/15.
//  Copyright (c) 2015 Howard. All rights reserved.
//

#import "StreetEasyService.h"
#import <AFNetworking/AFNetworking.h>

@interface StreetEasyService ()

@property AFHTTPRequestOperationManager *requestOperationManager;
@property NSString *streetEasyAPIKey;
@property NSString *streatEasyAPIFormat;

@end

@implementation StreetEasyService

+ (StreetEasyService *)sharedInstance
{
    static StreetEasyService *_sharedInstance = nil;
    
    static dispatch_once_t dispatchOnce;
    
    dispatch_once(&dispatchOnce, ^{
        _sharedInstance = [[StreetEasyService alloc] init];
        _sharedInstance.requestOperationManager = [[AFHTTPRequestOperationManager alloc]
                                                   initWithBaseURL:[NSURL URLWithString:@"http://streeteasy.com/nyc/api/"]];
        _sharedInstance.streetEasyAPIKey = @"3cb0bc50f074005bcf1dcd63471eeadb9c72a27c";
        _sharedInstance.streatEasyAPIFormat = @"json";
    });
    
    return _sharedInstance;
}

- (void)getAreaForLocation:(CLLocation *)location withCallback:(void (^)(NSError *, StreetEasyArea *))callback
{
    [self.requestOperationManager GET:@"areas/for_location"
                           parameters:@{@"lat": [NSString stringWithFormat:@"%.04f", location.coordinate.latitude],
                                        @"lon": [NSString stringWithFormat:@"%.04f", location.coordinate.longitude],
                                        @"key": self.streetEasyAPIKey,
                                        @"format": self.streatEasyAPIFormat,}
                              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                  callback(nil, [MTLJSONAdapter modelOfClass:[StreetEasyArea class]
                                                          fromJSONDictionary:responseObject error:nil]);
                              }
                              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                  callback(error, nil);
                              }];
}

- (void)getSalesForArea:(StreetEasyArea *)area withBeds:(NSInteger)beds withBaths:(NSInteger)baths withCallback:(void (^)(NSError *, NSArray *))callback
{
    NSString *criteria = [self criteraStringWithArea:area withBeds:beds withBaths:baths];
    
    [self.requestOperationManager GET:@"sales/data"
                           parameters:@{@"criteria": criteria,
                                        @"key": self.streetEasyAPIKey,
                                        @"format": self.streatEasyAPIFormat}
                              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                  
                              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                  
                              }];
}

- (void)getRentalsForArea:(StreetEasyArea *)area withBeds:(NSInteger)beds withBaths:(NSInteger)baths withCallback:(void (^)(NSError *, NSArray *))callback
{
    NSString *criteria = [self criteraStringWithArea:area withBeds:beds withBaths:baths];
    
    [self.requestOperationManager GET:@"rentals/data"
                           parameters:@{@"criteria": criteria,
                                        @"key": self.streetEasyAPIKey,
                                        @"format": self.streatEasyAPIFormat}
                              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                  
                              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                  
                              }];
}

- (NSString *)criteraStringWithArea:(StreetEasyArea *)area withBeds:(NSInteger)beds withBaths:(NSInteger)baths
{
    NSMutableString *critera = [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"area:%@", area.name]];
    if (beds) {
        [critera appendString:[NSString stringWithFormat:@"|beds:%i", (int)beds]];
    }
    if (baths) {
        [critera appendString:[NSString stringWithFormat:@"|baths:%i", (int)baths]];
    }
    
    return critera;
}

@end
