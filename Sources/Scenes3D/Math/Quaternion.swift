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

    public var euler : Vector3 {
        get {
            return Vector3.fromQuaternion(self)
        }
        set (euler) {
            self = Quaternion.fromEuler(euler)
        }
    }

    /// The quaternion (x:0, y:0, z:0, w:1)
    static public var identity = Quaternion(x:0, y:0, z:0, w:1)

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
        self = Quaternion.fromEuler(euler)
    }

    /// Returns a new quaternion with a magnitude of 1.
    /// The normalized quaternion keeps the same orientation, but its magnitude is changed to 1.0.
    /// - Returns: The normalized quaternion
    public func normalized() -> Quaternion {
        let normal = sqrt(x*x + y*y + z*z + w*w)
        let quaternion = Quaternion(x:x / normal, y:y / normal,
                                    z:z / normal, w:w / normal)
        return quaternion
    }

    /// Normalizes the quaternion to a magnitude of 1.
    /// When normalized, a quaternion keeps the same orientation, but its magnuture is changed to 1.0.
    public mutating func normalize() {
        let normalizedQuaternion = normalized()
        x = normalizedQuaternion.x
        y = normalizedQuaternion.y
        z = normalizedQuaternion.z
        w = normalizedQuaternion.w
    }

    public func inversed() -> Quaternion {
        return Quaternion(x:-x, y:-y, z:-z, w:w)
    }

    /// Equivalence operator for two `Quaternion`s.
    static public func == (left:Quaternion, right:Quaternion) -> Bool {
        return left.w == right.w && left.x == right.x && left.y == right.y && left.z == right.z
    }

    /// Addition opperator for two `Quaternion`s.
    static public func + (left:Quaternion, right:Quaternion) -> Quaternion {
        return Quaternion(x:left.x + right.x, y:left.y + right.y, z:left.z + right.x, w:left.w + right.w)
    }

    

    internal static func fromEuler(_ euler:Vector3) -> Quaternion {
        let c1 = cos(euler.x / 2)
        let c2 = cos(euler.y / 2)
        let c3 = cos(euler.z / 2)
        let s1 = sin(euler.x / 2)
        let s2 = sin(euler.y / 2)
        let s3 = sin(euler.z / 2)
        
        // NOTE: euler angles are applied in xyz order.
        let x = (s1 * c2 * c3) + (c1 * s2 * s3)
        let y = (c1 * s2 * c3) - (s1 * c2 * s3)
        let z = (c1 * c2 * s3) + (s1 * s2 * c3)
        let w = (c1 * c2 * c3) - (s1 * s2 * s3)
        return Quaternion(x:x, y:y, z:z, w:w)
    }
}
