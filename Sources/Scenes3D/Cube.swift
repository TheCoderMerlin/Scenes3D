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

import Igis

// This object is currently used for experimentation only (actual object will be rectangular prism)
public class Cube : Object3D {
    public var transform : Transform3D
    
    public init(position:Vector3, rotation:Vector3, size:Vector3) {
        self.transform = Transform3D(position:position, orientation:rotation, size:size)
        
        super.init()
        
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
    }

    internal override func calculate(camera:Camera) {
        calculatedVertices = []
        for vertice in vertices {
            calculatedVertices.append(vertice.rotatingAround(point:transform.position, by:transform.orientation))
        }

        calculated2DVertices = []
        for vertice in calculatedVertices {
            let point = Point(x:Int(vertice.x / vertice.z) + camera._viewportRect.width/2,
                              y:Int(vertice.y / vertice.z) + camera._viewportRect.height/2)
            calculated2DVertices.append(point)
        }
    }
}
