//
//  TaoJsonDecoder.h
//  WeatherApp
//
//  Created by Andrey on 04.03.2026.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TaoJsonDecoder : NSObject

- (id)decode:(NSData*)data;

@end

NS_ASSUME_NONNULL_END
