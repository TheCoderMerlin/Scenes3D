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
    public var center : Vector3
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
    public static var zero = Bounds()

    /// Creates a new `Bounds` object from the specified attributes.
    /// - Parameters:
    ///   - center: The center of the bounding box.
    ///   - size: The total size of the bounding box.
    public init(center:Vector3 = Vector3.zero, size:Vector3 = Vector3.one) {
        self.center = center
        self.size = size
    }

    /// Creates a new `Bounds` object between the specified points.
    /// - Parameters:
    ///   - from: The starting point.
    ///   - to: The ending point.
    public init(from:Vector3, to:Vector3) {
        self.center = to - from / Vector3(x:2, y:2, z:2)
        self.size = to - center
    }

    /// Checks if the specified vector is contained within the `Bounds`.
    /// - Returns: A boolean value indicitive of whether the target
    ///            vector is contained or not.
    public func contains(target:Vector3) -> Bool {
        let x = max.x >= target.x && min.x <= target.x
        let y = max.y >= target.y && min.y <= target.y
        let z = max.z >= target.z && min.z <= target.z
        return x && y && z
    }

    /// Union of this `Bounds` with the specified target `Bounds`.
    /// - Returns: A new `Bounds` exactly large enough to contain
    ///            both bounds.
    public func unioned(with other:Bounds) -> Bounds {
        let minVector = Vector3.min(self.min, other.min)
        let maxVector = Vector3.max(self.max, other.max)

        return Bounds(from:minVector, to:maxVector)
    }

    /// Equivalence operator for two `Bounds`.
    public static func == (left:Bounds, right:Bounds) -> Bool {
        return left.center == right.center && left.size == right.size
    }
}
