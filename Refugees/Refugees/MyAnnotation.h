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

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic) CLLocationCoordinate2D coordinate;

@end
