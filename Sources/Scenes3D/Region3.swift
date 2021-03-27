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

/// A `Region3` represents a rectangular prism in 3D space.
public struct Region3 : Equatable {
    /// The center position of the region3 in 3D space.
    /// This value is modifiable and will alter the position of the region3.
    public var position : Vector3
    /// The orientation of the region3 along all rotational axis.
    /// This value is modifiable and will alter the rotation of the region3.
    public var orientation : Quaternion
    /// The size of the region3 along all spacial axis.
    /// This value is modifiable and will alter the size of the region3.
    public var size : Vector3

    /// Creates a new `Region3` from the specified values.
    /// - Parameters:
    ///   - position : The region's position. Default value is Vector3.zero
    ///   - orientation : The region's rotational orientation. Default value is Quaternion.identity
    ///   - size : The region's size. Default value is Vector3.one
    public init(position:Vector3 = Vector3.zero, orientation:Quaternion = Quaternion.identity, size:Vector3 = Vector3.one) {
        self.position = position
        self.orientation = orientation
        self.size = size
    }

    /// Equivalence operator for two `Region3`s.
    static public func == (left:Region3, right:Region3) -> Bool {
        return left.position == right.position && left.orientation == right.orientation && left.size == right.size
    }
}
