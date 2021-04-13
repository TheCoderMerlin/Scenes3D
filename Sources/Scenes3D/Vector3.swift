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
        let x2 = quaternion.x + quaternion.x
        let y2 = quaternion.y + quaternion.y
        let z2 = quaternion.z + quaternion.z

        let xx = quaternion.x * x2
        let xy = quaternion.x * y2
        let xz = quaternion.x * z2
        let yy = quaternion.y * y2
        let yz = quaternion.y * z2
        let zz = quaternion.z * z2
        let wx = quaternion.w * x2
        let wy = quaternion.w * y2
        let wz = quaternion.w * z2

        let m11 = (1 - ( yy + zz ))
        let m12 = (xy - wz)
        let m13 = (xz + wy)
        let m22 = (1 - (xx + zz))
        let m23 = (yz - wx)
        let m32 = (yz + wx)
        let m33 = (1 - (xx + yy))

        y = asin(Swift.min(1.0, Swift.max(-1.0, m13)))

        if abs(m13) < 0.999999 {
            x = atan2(-m23, m33)
            z = atan2(-m12, m11)
        } else {
            x = atan2(m32, m22)
            z = 0
        }
    }

    /// Returns a new vector rotated around a target `Vector3`.
    /// - Parameter:
    ///   - point: The vector3 your rotating around.
    ///   - by: The value of the objects rotation as a `Quaternion`.
    public func rotatingAround(point:Vector3, by change:Quaternion) -> Vector3 {
        let quaternion = change.normalized()
        
        let a = quaternion.w
        let b = quaternion.x
        let c = quaternion.y
        let d = quaternion.z

        let m = self.x - point.x
        let n = self.y - point.y
        let o = self.z - point.z
        
        let q = a*a + b*b + c*c + d*d
        let xQ = a*a + b*b - c*c - d*d
        let yQ = a*a - b*b + c*c - d*d
        let zQ = a*a - b*b - c*c + d*d
        
        let x = point.x+1/q*(xQ*m+2*(b*c-a*d)*n+2*(a*c+b*d)*o)
        let y = point.y+1/q*(2*(a*d+b*c)*m+yQ*n+2*(c*d-a*b)*o)
        let z = point.z+1/q*(2*(b*d-a*c)*m+2*(a*b+c*d)*n+zQ*o)
        return Vector3(x:x, y:y, z:z)
    }

    /// Rotates this `Vector3` around a target `Vector3`.
    /// - Parameter:
    ///   - point: The vector3 your rotating around.
    ///   - by: The value of the objects rotation as a `Quaternion`.
    public mutating func rotateAround(point:Vector3, by change:Quaternion) {
        self = rotatingAround(point:point, by:change)
    }

    /// Returns a new vector rotated around a target `Vector3`.
    /// - Parameter:
    ///   - point: The vector3 your rotating around.
    ///   - by: The value of the objects rotation in euclidean form.
    public func rotatingAround(point:Vector3, by change:Vector3) -> Vector3 {
        let quaternion = Quaternion(change)
        return rotatingAround(point:point, by:quaternion)
    }
    
    /// Rotates this `Vector3` around a target `Vector3`.
    /// - Parameter:
    ///   - point: The vector3 your rotating around.
    ///   - by: The value of the objects rotation in euclidean form.
    public mutating func rotateAround(point:Vector3, by change:Vector3) {
        let quaternion = Quaternion(change)
        self = rotatingAround(point:point, by:quaternion)
    }

    public func applyingMatrix(matrix4:Matrix4) -> Vector3 {
        let w = 1 / (matrix4.value(0, 3)*x + matrix4.value(1, 3)*y + matrix4.value(2, 3)*z + matrix4.value(3, 3))

        let newX = (matrix4.value(0, 0)*x + matrix4.value(1, 0)*y + matrix4.value(2, 0)*z + matrix4.value(3, 0)) * w
        let newY = (matrix4.value(0, 1)*x + matrix4.value(1, 1)*y + matrix4.value(2, 1)*z + matrix4.value(3, 1)) * w
        let newZ = (matrix4.value(0, 2)*x + matrix4.value(1, 2)*y + matrix4.value(2, 2)*z + matrix4.value(3, 2)) * w
        
        return Vector3(x:newX, y:newY, z:newZ)
    }

    public mutating func applyMatrix(matrix4:Matrix4) {
        self = self.applyingMatrix(matrix4:matrix4)
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

    /// Returns the dot product between this `Vector3` and the specified target `Vector3`.
    /// - Returns: The dot product result.
    public func dotProduct(with target:Vector3) -> Double {
        let multipliedVector = self * target
        return multipliedVector.x + multipliedVector.y + multipliedVector.z
    }

    /// Transforms this `Vector3` to local space of origin `Vector3`.
    /// - Returns: A new `Vector3` which describes this `Vector3` in
    ///            local coordinate space.
    public func local(to origin:Vector3) -> Vector3 {
        return self - origin
    }

    /// Transforms this `Vector3` from local space of origin `Vector3`.
    /// - Returns: A new `Vector3` which describes this `Vector3` in
    ///            global coordinate space.
    public func global(from origin:Vector3) -> Vector3 {
        return self + origin
    }

    /// Returns a `Vector3` made from the smallest components of the given `Vector3`s.
    /// - Returns: The minimum vector.
    public static func min(_ u:Vector3, _ v:Vector3, _ rest:Vector3...) -> Vector3 {
        var vectors = rest
        vectors.append(u)
        vectors.append(v)

        let x = vectors.map {$0.x}.min() ?? 0.0
        let y = vectors.map {$0.y}.min() ?? 0.0
        let z = vectors.map {$0.z}.min() ?? 0.0

        return Vector3(x:x, y:y, z:z)
    }

    /// Returns a `Vector3` made from the largest components of the given `Vector3`s.
    /// - Returns: The maximum vector.
    public static func max(_ u:Vector3, _ v:Vector3, _ rest:Vector3...) -> Vector3 {
        var vectors = rest
        vectors.append(u)
        vectors.append(v)

        let x = vectors.map {$0.x}.max() ?? 0.0
        let y = vectors.map {$0.y}.max() ?? 0.0
        let z = vectors.map {$0.z}.max() ?? 0.0

        return Vector3(x:x, y:y, z:z)
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
