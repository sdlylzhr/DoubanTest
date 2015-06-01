//
//  Movie.m
//  DoubanMovieSample
//
//  Created by lzhr on 15/3/13.
//  Copyright (c) 2015年 lzhr. All rights reserved.
//

#import "Movie.h"

@implementation Movie

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.director_casts = [NSMutableArray array];
    }
    return self;
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"images"]) {
        self.imagesLarge = [value objectForKey:@"large"];
    } else if ([key isEqualToString:@"id"]) {
        self.movieId = value;
    }
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    if ([key isEqualToString:@"rating"] && [value isKindOfClass:[NSDictionary class]]) {
        self.rating = [[value objectForKey:@"average"] floatValue];
        self.stars = [[value objectForKey:@"stars"] integerValue];
    } else if ([key isEqualToString:@"countries"]) {
        self.countries = [value componentsJoinedByString:@"/"];
    } else if ([key isEqualToString:@"genres"]) {
        self.genres = [value componentsJoinedByString:@"/"];
    } else if ([key isEqualToString:@"durations"] && [value isKindOfClass:[NSArray class]]) {
        self.durations = [value firstObject];
    } else {
        [super setValue:value forKey:key];
    }
}

- (NSString *)pub_Durations
{
    
    NSString *str = nil;
    if (_durations.length != 0) {
        str = [[[_pubdate stringByAppendingFormat:@"/%@",_durations]retain] autorelease];
    }
    
    return str;
}

- (NSMutableArray *)director_casts
{
    if (_director_casts == nil && _directors.count != 0 && _casts != 0) {
        self.director_casts = [NSMutableArray arrayWithArray:_directors];
        [self.director_casts addObjectsFromArray:_casts];
    }
    return _director_casts;
}

- (void)dealloc
{
    
    [_movieId release];
    [_title release];
    [_imagesLarge release];
    [_pubdate release];
    [_durations release];
    [_countries release];
    [_genres release];
    [_photos release];
    [_summary release];
    [_director_casts release];
    [_popular_comments release];
    [super dealloc];
}

@end
