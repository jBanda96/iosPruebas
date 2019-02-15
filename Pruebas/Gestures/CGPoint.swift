//
//  File.swift
//  Pruebas
//
//  Created by Julio Banda on 2/14/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import simd
import CoreGraphics

extension CGPoint {
    
    var lenght: CGFloat {
        return CGFloat(simd.length(double2(self)))
    }
    
    static func + (point0: CGPoint, point1: CGPoint) -> CGPoint {
        return CGPoint(double2(point0) + double2(point1))
    }
    
    init(_ double2: double2) {
        self.init(x: double2.x, y: double2.y)
    }
    
    func clamped(whitin bounds: CGRect) -> CGPoint {
        return CGPoint(clamp(double2(self),
                             min: double2(x: bounds.minX, y: bounds.minY),
                             max: double2(x: bounds.maxX, y: bounds.maxY)))
    }
    
}

extension double2 {
    
    init(_ cgPoint: CGPoint) {
        self.init(x: cgPoint.x, y: cgPoint.y)
    }
    
    init(x: CGFloat, y: CGFloat) {
        self.init(x: x.native, y: y.native)
    }
}
