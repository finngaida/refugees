//
//  MyAnnotation.h
//  Refugees
//
//  Created by Finn Gaida on 20.09.15.
//  Copyright © 2015 Refugees Welcome. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <Foundation/Foundation.h>

@interface MyAnnotation : NSObject <MKAnnotation>

@property (nonatomic) NSString *title;
@property (nonatomic) NSString *subtitle;
@property (nonatomic) NSString *opening;
@property (nonatomic) CLLocationCoordinate2D coordinate;

@end
