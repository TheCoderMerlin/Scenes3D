/*
Scenes3D provides a Swift object library with support for 3D renderable entities.
Scenes3D runs on top of Scenes and IGIS.
Copyright (C) 2021 William Jackson, William Paroff, Camden Thomson,
                   CoderMerlin.com
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

// Reference: https://scriptinghelpers.org/blog/how-to-think-about-quaternions
import Foundation

/// `Quaternion`s are used to represent rotations in 3D space.
public struct Quaternion : Equatable {
    /// The x-coordinate.
    public var x : Double
    /// The y-coordinate.
    public var y : Double
    /// The z-coordinate.
    public var z : Double
    /// The w-coordinate.
    public var w : Double

    /// A `Vector3` describing this angle in euler coordinates.
    public var euler : Vector3 {
        get {
            return Vector3(self)
        }
        set (vector3) {
            self = Quaternion(vector3)
        }
    }

    /// The quaternion (x:0, y:0, z:0, w:1)
    public static var identity = Quaternion(x:0, y:0, z:0, w:1)

    /// Creates a new `Quaternion` with its identity properties.
    public init() {
        self = Self.identity
    }

    /// Creates a new `Quaternion` from the specified properties.
    /// - Parameters:
    ///   - x: The x-coordinate
    ///   - y: The y-coordinate
    ///   - z: The z-coordinate
    ///   - w: The w-coordinate
    public init(x:Double, y:Double, z:Double, w:Double) {
        self.x = x
        self.y = y
        self.z = z
        self.w = w
    }

    /// Creates a new `Quaternion` from the given `Vector3` in euclidean form.
    /// - Parameters:
    ///   - euler: The `Vector3` representing euclidean rotation.
    public init(_ euler:Vector3) {
        let c1 = cos(euler.x / 2)
        let c2 = cos(euler.y / 2)
        let c3 = cos(euler.z / 2)
        let s1 = sin(euler.x / 2)
        let s2 = sin(euler.y / 2)
        let s3 = sin(euler.z / 2)
        
        // NOTE: euler angles are applied in xyz order.
        x = (s1 * c2 * c3) + (c1 * s2 * s3)
        y = (c1 * s2 * c3) - (s1 * c2 * s3)
        z = (c1 * c2 * s3) + (s1 * s2 * c3)
        w = (c1 * c2 * c3) - (s1 * s2 * s3)
    }

    /// Calculates the square of the length of this quaternion.
    /// - Returns: The square of the length of this quaternion.
    public func lengthSquared() -> Double {
        return (x * x) + (y * y) + (z * z) + (w * w)
    }

    /// Calculates the length of this quaternion.
    /// - Returns: The length of this quaternion.
    public func length() -> Double {
        return sqrt(lengthSquared())
    }

    /// Returns a new quaternion with a magnitude of 1.
    /// The normalized quaternion keeps the same orientation, but its magnitude is changed to 1.0.
    /// - Returns: The normalized quaternion
    public func normalized() -> Quaternion {
        var length = self.length()

        guard length != 0 else {
            return Quaternion.identity
        }

        length = 1 / length

        let newX = x * length
        let newY = y * length
        let newZ = z * length
        let newW = w * length

        return Quaternion(x:newX, y:newY, z:newZ, w:newW)
    }

    /// Normalizes the quaternion to a magnitude of 1.
    /// When normalized, a quaternion keeps the same orientation, but its magnuture is changed to 1.0.
    public mutating func normalize() {
        self = self.normalized()
    }

    /// Equivalence operator for two `Quaternion`s.
    public static func == (left:Quaternion, right:Quaternion) -> Bool {
        return left.w == right.w && left.x == right.x &&
          left.y == right.y && left.z == right.z
    }

    /// Addition opperator for two `Quaternion`s.
    public static func + (left:Quaternion, right:Quaternion) -> Quaternion {
        return Quaternion(x:left.x + right.x, y:left.y + right.y,
                          z:left.z + right.x, w:left.w + right.w)
    }
}
