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

internal struct Frustum {
    private var planes : [Plane]

    internal init(planes:Plane...) {
        precondition(planes.count == 6, "Frustum must have 6 planes")
        self.planes = planes
    }

    internal func contains(target:Vector3) -> Bool {
        for plane in planes {
            if plane.distanceToPoint(target) < 0 {
                return false
            }
        }

        return true
    }
    
    internal func contains(bounds:Bounds) -> Bool {
        for plane in planes {
            let x = (plane.normal.x > 0) ? bounds.max.x : bounds.min.x
            let y = (plane.normal.y > 0) ? bounds.max.y : bounds.min.y
            let z = (plane.normal.z > 0) ? bounds.max.z : bounds.min.z
            let target = Vector3(x:x, y:y, z:z)
            
            if plane.distanceToPoint(target) < 0 {
                return false
            }
        }
        
        return true
    }
}
