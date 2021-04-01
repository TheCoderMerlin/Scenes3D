/*
Scenes3D provides a Swift object library with support for 3D renderable entities.
Scenes3D runs on top of Scenes and IGIS.
Copyright (C) 2021 William Jackson, William Paroff, Camden Thomson,
                   Tango Golf Digital, LLC
This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.
This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.
You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

import Foundation
import Igis

/// A `Vector3` represents a point in 3D space, and is typically
/// used to define the position and size of a three-dimensional object.
public struct Vector3 : Equatable {
    /// The coordinate along the x-axis.
    public var x : Double
    /// The coordinate along the y-axis.
    public var y : Double
    /// The coordinate along the z-axis.
    public var z : Double

    /// The vector3 (x:0, y:0, z:0).
    public static let zero = Vector3(x:0, y:0, z:0)
    /// The vector3 (x:1, y:1, z:1).
    public static let one = Vector3(x:1, y:1, z:1)

    /// Creates a new `Vector3` with the properties (x:0, y:0, z:0).
    public init() {
        self.x = 0
        self.y = 0
        self.z = 0
    }

    /// Creates a new `Vector3` from the specified coordinates.
    /// - Parameters:
    ///   - x: The x-coordinate
    ///   - y: The y-coordinate
    ///   - z: The z-coordinate
    public init(x:Double, y:Double, z:Double) {
        self.x = x
        self.y = y
        self.z = z
    }

    /// Creates a new `Vector3` from the specified quaternion.
    /// - Parameters:
    ///   - quaternion: The `Quaternion` to use.
    public init(_ quaternion:Quaternion) {
        self = Vector3.zero
    }

    /// Rotates a vector3 around another vector3.
    /// - Parameter:
    ///   - point: The vector3 your rotating around.
    ///   - by: The value of the objects rotation.
    public mutating func rotateAround(point:Vector3, by change:Quaternion) {  
        let a = change.w
        let b = change.x
        let c = change.y
        let d = change.z

        let x = point.x
        let y = point.y
        let z = point.z
        
        let m = self.x - x
        let n = self.y - y
        let o = self.z - z
        
        let q = a*a + b*b + c*c + d*d
        let xQ = a*a + b*b - c*c - d*d
        let yQ = a*a - b*b + c*c - d*d
        let zQ = a*a - b*b - c*c + d*d
        
        self.x = x+1/q*(xQ*m+2*(b*c-a*d)*n+2*(a*c+b*d)*o)
        self.y = y+1/q*(2*(a*d+b*c)*m+yQ*n+2*(c*d-a*b)*o)
        self.z = z+1/q*(2*(b*d-a*c)*m+2*(a*b+c*d)*n+zQ*o)
    }
    
    public mutating func rotateAround(point:Vector3, by change:Vector3) {
        rotateAround(point:point, by:Quaternion(change))
    }

    /// Calculates the square of the Euclidean distance between this vector3 and another.
    /// - Parameters:
    ///   - target: The target vector3 to which to calculate the distance
    /// - Returns: The square of the distance to a target vector3
    public func distanceSquared(to target:Vector3) -> Double {
        let xDistance = target.x - x
        let xDistanceSquared = xDistance * xDistance

        let yDistance = target.y - y
        let yDistanceSquared = yDistance * yDistance

        let zDistance = target.z - z
        let zDistanceSquared = zDistance * zDistance

        return xDistanceSquared + yDistanceSquared + zDistanceSquared
    }

    /// Calculates the Euclidean distance between this vector3 and another.
    /// - Parameters:
    ///   - target: The target point to which to calculate the distance
    /// - Returns: The distance to a target vector3
    public func distance(to target:Vector3) -> Double {
        return sqrt(Double(distanceSquared(to:target)))
    }

    public func local(to origin:Vector3) -> Vector3 {
        return self - origin
    }

    public func dot(with target:Vector3) -> Double {
        let multiplied = self * target
        return multiplied.x + multiplied.y + multiplied.z
    }
    
    public static func min(_ vector1:Vector3, _ vectors:Vector3...) -> Vector3 {
        var minVector = vector1

        for vector in vectors {
            if vector.x > minVector.x {
                minVector.x = vector.x
            }
            if vector.y > minVector.y {
                minVector.y = vector.y
            }
            if vector.z > minVector.z {
                minVector.z = vector.z
            }
        }

        return minVector
    }

    public static func max(_ vector1:Vector3, _ vectors:Vector3...) -> Vector3 {
        var maxVector = vector1

        for vector in vectors {
            if vector.x < maxVector.x {
                maxVector.x = vector.x
            }
            if vector.y < maxVector.y {
                maxVector.y = vector.y
            }
            if vector.z < maxVector.z {
                maxVector.z = vector.z
            }
        }

        return maxVector
    }

    /// Equivalence operator for two `Vector3`s.
    public static func == (left:Vector3, right:Vector3) -> Bool {
        return left.x == right.x && left.y == right.y && left.z == right.z
    }

    /// Addition operator for two `Vector3`s.
    public static func + (left:Vector3, right:Vector3) -> Vector3 {
        return Vector3(x:left.x + right.x, y:left.y + right.y, z:left.z + right.z)
    }

    /// Compound addition operator for two `Vector3`s.
    public static func += (left:inout Vector3, right:Vector3) {
        left = left + right
    }

    /// Negation operator for a `Vector3`.
    public static prefix func - (vector3:Vector3) -> Vector3 {
        return Vector3(x:-vector3.x, y:-vector3.y, z:-vector3.z)
    }

    /// Subtraction operator for two `Vector3`s.
    public static func - (left:Vector3, right:Vector3) -> Vector3 {
        return left + -right
    }

    /// Compound subtraction operator for two `Vector3`s.
    public static func -= (left:inout Vector3, right:Vector3) {
        left = left - right
    }

    /// Multiplication operator for two `Vector3`s.
    public static func * (left:Vector3, right:Vector3) -> Vector3 {
        return Vector3(x:left.x * right.x, y:left.y * right.y, z:left.z * right.z)
    }

    /// Compound multiplication operator for two `Vector3`s.
    public static func *= (left:inout Vector3, right:Vector3) {
        left = left * right
    }

    /// Division operator for two `Vector3`s.
    public static func / (left:Vector3, right:Vector3) -> Vector3 {
        return Vector3(x:left.x / right.x, y:left.y / right.y, z:left.z / right.z)
    }

    /// Compound division operator for two `Vector3`s.
    public static func /= (left:inout Vector3, right:Vector3) {
        left = left / right
    }
}
