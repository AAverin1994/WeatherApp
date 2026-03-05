//
//  TaoJsonDecoder.m
//  WeatherApp
//
//  Created by Andrey on 04.03.2026.
//

#import "TaoJsonDecoder.h"
#import "include/tao/json.hpp"

@implementation TaoJsonDecoder

- (id)decode:(NSData*)data
{
    try {
        std::string jsonString(
                               (const char *)[data bytes],
                               [data length]
                               );
        
        tao::json::value root = tao::json::from_string(jsonString);
        return [self convertValue:root];
    }
    catch (const std::exception& error) {
        return [NSError errorWithDomain:@"TaoJsonDecoder"
                                   code:1
                               userInfo:@{
          NSLocalizedDescriptionKey :
          [NSString stringWithUTF8String:error.what()]
      }];
    }
}

- (id)convertValue:(const tao::json::value &)v
{
    if (v.is_null()) return [NSNull null];
    if (v.is_boolean()) return @(v.get_boolean());
    if (v.is_signed()) return @(v.get_signed());
    if (v.is_unsigned()) return @(v.get_unsigned());
    if (v.is_double()) return @(v.get_double());
    if (v.is_string()) return [NSString stringWithUTF8String:v.get_string().c_str()];
    if (v.is_array()) return [self convertArray:v];
    if (v.is_object()) return [self convertObject:v];
    return nil;
}

- (NSArray *)convertArray:(const tao::json::value &)v
{
    NSMutableArray *array = [NSMutableArray array];
    for (const auto &element : v.get_array()) {
        [array addObject:[self convertValue:element]];
    }
    return array;
}

- (NSDictionary *)convertObject:(const tao::json::value &)v
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    for (const auto &[key, value] : v.get_object()) {
        NSString *nsKey = [NSString stringWithUTF8String:key.c_str()];
        dictionary[nsKey] = [self convertValue:value];
    }
    return dictionary;
}

@end
