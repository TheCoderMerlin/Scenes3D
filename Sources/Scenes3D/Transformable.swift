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

/// A `Transformable` type contains a transform variable and is able
/// to be manipulated in 3D space.
public protocol Transformable {
    var transform : Transform3D { get set }
}

public extension Transformable {
    /// The center position of the transform3d in 3D space.
    /// This value is modifiable and will alter the position of the transform3d.
    var position : Vector3 {
        get {
            return transform.position
        }
        set {
            transform.position = newValue
        }
    }

    /// The orientation of the transform3d along all rotational axis.
    /// This value is modifiable and will alter the rotation of the transform3d.
    var quaternion : Quaternion {
        get {
            return transform.quaternion
        }
        set {
            transform.quaternion = newValue
        }
    }

    /// The orientation of the transform3d along all rotational axis.
    /// This value is modifiable and will alter the rotation of the transform3d.
    var rotation : Vector3 {
        get {
            return transform.rotation
        }
        set {
            transform.rotation = newValue
        }
    }

    /// The size of the transform3d along all spacial axis.
    /// This value is modifiable and will alter the size of the transform3d.
    var size : Vector3 {
        get {
            return transform.size
        }
        set {
            transform.size = newValue
        }
    }
}
