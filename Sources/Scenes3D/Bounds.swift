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

/// A `Bounds` object represents an axis-aligned bounding box in 3D space.
public struct Bounds : Equatable {
    /// The center of the bounding box.
    public var center : Vector3
    /// The total size of the bounding box.
    public var size : Vector3

      /// The extents of the bounding box. This is always half of the bounds size.
    public var extents : Vector3 {
        return Vector3(x:abs(size.x)/2, y:abs(size.y)/2, z:abs(size.z)/2)
    }

    /// The minimal point of the box.
    public var min : Vector3 {
        return center - extents
    }

    /// The maximal point of the box.
    public var max : Vector3 {
        return center + extents
    }

    /// The bounds (position:Vector3.zero, size:Vector3.one)
    static public var zero = Bounds()

    /// Creates a new `Bounds` object from the specified attributes.
    /// - Parameters:
    ///   - center: The center of the bounding box.
    ///   - size: The total size of the bounding box.
    public init(center:Vector3 = Vector3.zero, size:Vector3 = Vector3.one) {
        self.center = center
        self.size = size
    }

    /// Equivalence operator for two `Bounds`.
    public static func == (left:Bounds, right:Bounds) -> Bool {
        return left.center == right.center && left.size == right.size
    }
}
