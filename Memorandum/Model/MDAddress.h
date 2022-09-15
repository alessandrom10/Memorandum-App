//
//  MDAddress.h
//  Memorandum
//
//  Created by Alessandro Masini on 08/09/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MDAddress : NSObject

@property (strong, nonatomic) NSString* commonName;
@property (strong, nonatomic) NSNumber* latitude;
@property (strong, nonatomic) NSNumber* longitude;

@end

NS_ASSUME_NONNULL_END
