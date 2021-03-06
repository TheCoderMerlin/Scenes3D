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

import Igis

// This object is currently used for experimentation only (actual object will be rectangular prism)
public class Cube : Object3D {
    public init(position:Vector3, rotation:Vector3, size:Vector3) {
        let transform = Transform3D(position:position, rotation:rotation, size:size)
        
        super.init(transform:transform)
        
        inCameraView = true

        vertices = [Vector3(x:position.x - size.x, y:position.y - size.y, z:position.z - size.z),
                    Vector3(x:position.x + size.x, y:position.y - size.y, z:position.z - size.z),
                    Vector3(x:position.x - size.x, y:position.y + size.y, z:position.z - size.z),
                    Vector3(x:position.x - size.x, y:position.y - size.y, z:position.z + size.z),
                    Vector3(x:position.x + size.x, y:position.y + size.y, z:position.z - size.z),
                    Vector3(x:position.x - size.x, y:position.y + size.y, z:position.z + size.z),
                    Vector3(x:position.x + size.x, y:position.y - size.y, z:position.z + size.z),
                    Vector3(x:position.x + size.x, y:position.y + size.y, z:position.z + size.z)]
        
        triangles = [(0, 1, 4), (0, 4, 2),
                     (0, 1, 6), (1, 6, 7),
                     (0, 2, 5), (5, 0, 3),
                     (0, 6, 3), (7, 1, 4),
                     (7, 5, 2), (7, 5, 3),
                     (7, 2, 4), (7, 3, 6)]

        strokeStyle = StrokeStyle(color:Color(.white))

        renderMode = .verticies
    }
}
