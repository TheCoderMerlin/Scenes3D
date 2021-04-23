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

/// A `Transform3D` stores and controls an objects spacial information.
public class Transform3D : Equatable {
    /// The center position of the transform3d in 3D space.
    /// This value is modifiable and will alter the position of the transform3d.
    public var position : Vector3
    
    /// The orientation of the transform3d along all rotational axis.
    /// This value is modifiable and will alter the rotation of the transform3d.
    public var quaternion : Quaternion

    /// The orientation of the transform3d along all rotational axis.
    /// This value is modifiable and will alter the rotation of the transform3d.
    public var rotation : Vector3 {
        get {
            return quaternion.euler
        }
        set (rotation) {
            quaternion.euler = rotation
        }
    }
    
    /// The size of the transform3d along all spacial axis.
    /// This value is modifiable and will alter the size of the transform3d.
    public var size : Vector3
    
    /// List of child transform3d's in order of reference priority.
    private var children : [Transform3D]

    /// Creates a new transform3d from the specified values.
    /// - Parameters:
    ///   - position : The transform3d's position. Default value is Vector3.zero
    ///   - orientation : The transform3d's rotational orientation. Default value is Quaternion.identity
    ///   - size : The transform3d's size. Default value is Vector3.one
    public init(position:Vector3 = Vector3.zero, quaternion:Quaternion = Quaternion.identity, size:Vector3 = Vector3.one) {
        self.position = position
        self.quaternion = quaternion
        self.size = size
        self.children = []
    }

    /// Creates a new transform3d from the specified values.
    /// - Parameters:
    ///   - position : The transform3d's position. Default value is Vector3.zero
    ///   - orientation : The transform3d's rotational orientation.
    ///   - size : The transform3d's size. Default value is Vector3.one
    public init(position:Vector3 = Vector3.zero, rotation:Vector3, size:Vector3 = Vector3.one) {
        self.position = position
        self.quaternion = Quaternion(rotation)
        self.size = size
        self.children = []
    }

    /// Changes the transform3d's position by a specified amount.
    /// - Parameters:
    ///    - by: The change value.
    public func translate(by change:Vector3) {
        self.position += change
        for child in children {
            child.translate(by:change)
        }
    }

    /// Changes the transform3d's orientation by a specified amount.
    /// - Parameters:
    ///    - by: The change value.
    public func rotate(by change:Quaternion) {
        self.quaternion = quaternion + change
        for child in children {
            child.rotateAround(point:self, by:change)
        }
    }

    public func rotate(by change:Vector3) {
        rotate(by:Quaternion(change))
    }

    /// Rotates an transform3d around another transform3d
    /// - Parameters:
    ///    - point: The transform3d your rotating around.
    ///    - by: The value of the objects rotation.  
    public func rotateAround(point:Transform3D, by change:Quaternion) {
        self.position.rotateAround(point:point.position, by:change)

        // TODO: Call an object 3D method to call all of the objects vertices rotateAround function.
    }

    public func rotateAround(point:Transform3D, by change:Vector3) {
        rotateAround(point:point, by:Quaternion(change))
    }

    /// Sets a target transform3d as a child of this transform3d.
    /// - Parameter:
    ///    - child: The target transform3d.
    public func addChild(child:Transform3D) {
        children.append(child)
    }
    
    /// Removes target transform3d from the list of children.
    /// - Parameter:
    ///    - child: The target transform3d.
    public func removeChild(child:Transform3D) {
        children.removeAll {$0 == child}
    }
    
    /// Equivalence operator for two transform3d's.
    public static func == (left:Transform3D, right:Transform3D) -> Bool {
        return left.position == right.position && left.rotation == right.rotation && left.size == right.size
    }
}
