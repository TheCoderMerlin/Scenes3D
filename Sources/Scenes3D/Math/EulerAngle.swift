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

/// An `EulerAngle` represents a rotational transform in a more readable x-y-z format.
public struct EulerAngle : Equatable {
    /// The x-coordinate
    public var x : Double
    /// The y-coordinate
    public var y : Double
    /// The z-coordinate
    public var z : Double

    /// Creates a new `EulerAngle` with the values (x:0, y:0, z:0)
    public init() {
        self.x = 0
        self.y = 0
        self.z = 0
    }

    /// Creates a new `EulerAngle` from the given parameters.
    /// - Parameters:
    ///   - x: The x-coordinate of the angle.
    ///   - y: The y-coordinate of the angle.
    ///   - z: The z-coordinate of the angle.
    public init(x:Double, y:Double, z:Double) {
        self.x = x
        self.y = y
        self.z = z
    }

    /// Creates a new `EulerAngle` from the specified `Quaternion`.
    /// - Parameters:
    ///   - quaternion: The `Quaternion` to use.
    public init(_ quaternion:Quaternion) {
        self.x = 0
        self.y = 0
        self.z = 0
    }

    /// Equivalence operator for two `EulerAngle`s.
    static public func == (left:EulerAngle, right:EulerAngle) -> Bool {
        return left.x == right.x && left.y == right.y && left.z == right.z
    }
}
