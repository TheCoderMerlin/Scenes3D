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

/// Stores position, orientation, and size of a 3d rectangular prism. (similar to rect)
public struct Region3 : Equatable {
    /// The center of the region that defines its point in 3D space.
    public var position : Vector3
    /// The value of the region's orientation along all rotational axis.
    public var orientation : Quaternion
    /// The value of a region's size along all spacial axis.
    public var size : Vector3

    /// Creates a new 'Region3' with default values.
    public init() {
        self.position = Vector3()
        self.orientation = Quaternion(w:0, x:0, y:0, z:0)
        self.size = Vector3(x:1, y:1, z:1)
    }

    /// Creates a new 'Region3' with specified values.
    /// - Parameters:
    ///   - position : The region's position.
    ///   - orientation : The region's rotational orientation.
    ///   - size : The region's size.
    public init(position:Vector3, orientation:Quaternion, size:Vector3) {
        self.position = position
        self.orientation = orientation
        self.size = size
    }

    /// Equivalence operator for two 'Region3's.
    static public func == (left:Region3, right:Region3) -> Bool {
        return left.position == right.position && left.orientation == right.orientation && left.size == right.size
    }
}
