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

/// A `Vector3` represents a point in 3D space, and is typically used to define the position and size of a three-dimensional object.
public struct Vector3 : Equatable, AdditiveArithmetic {
    /// The coordinate along the x-axis.
    public var x : Double
    /// The coordinate along the y-axis.
    public var y : Double
    /// The coordinate along the z-axis.
    public var z : Double

    /// The vector3 (x:0, y:0, z:0).
    static public let zero = Vector3(x:0, y:0, z:0)
    /// The vector3 (x:1, y:1, z:1).
    static public let one = Vector3(x:1, y:1, z:1)

    /// Creates a new `Vector3` with the properties (x:0, y:0, z:0)
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

    /// Rotates a vector3 around another vector3.
    /// - Parameter:
    ///   - point: The vector3 your rotating around.
    ///   - by: The value of the objects rotation.
    public mutating func rotateAround(point:Vector3, by change:Quaternion) {  
        /*
        let yzMatrix = transform(rotateRadians:change.x)
        z = z * yzMatrix.value[0] + point.z - y * yzMatrix.value[2] + point.y
        y = z * yzMatrix.value[1] + point.z + y * yzMatrix.value[3] + point.y
        
        let xzMatrix = transform(rotateRadians:change.y)
        x = x * xzMatrix.value[0] + point.x - z * xzMatrix.value[2] + point.z
        z = x * xzMatrix.value[1] + point.x + z * xzMatrix.value[3] + point.z

        let xyMatrix = transform(rotateRadians:change.z)
        x = x * xyMatrix.value[0] + point.x - y * xyMatrix.value[2] + point.y
        y = x * xyMatrix.value[1] + point.x + y * xyMatrix.value[3] + point.y
         */
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

    /// Equivalence operator for two `Vector3`s.
    static public func == (left:Vector3, right:Vector3) -> Bool {
        return left.x == right.x && left.y == right.y && left.z == right.z
    }

    /// Addition operator for two `Vector3`s.
    static public func + (left:Vector3, right:Vector3) -> Vector3 {
        return Vector3(x:left.x + right.x, y:left.y + right.y, z:left.z + right.z)
    }

    /// Negation operator for a `Vector3`.
    static public prefix func - (vector3:Vector3) -> Vector3 {
        return Vector3(x:-vector3.x, y:-vector3.y, z:-vector3.z)
    }

    /// Subtraction operator for two `Vector3`s.
    static public func - (left:Vector3, right:Vector3) -> Vector3 {
        return left + -right
    }

    internal static func fromQuaternion(_ quaternion:Quaternion) -> Vector3 {
        return Vector3.zero
    }
}
