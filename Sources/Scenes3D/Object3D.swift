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

// This is a crude mock-up (most properties are likely to change)
public class Object3D {
    internal var inCameraView : Bool
    internal var calculated2DVertices : [Point] // represent vertices transposed from local camera space to 2D screen space
    internal var calculatedVertices : [Vector3] // represent vertices in local camera space (saved to improve performance)

    public var vertices : [Vector3] // represent verticies in global space

    public typealias Triangle = (point1:Int, point2:Int, point3:Int)
    public var triangles : [Triangle]

    public init() {
        inCameraView = false
        calculated2DVertices = []
        calculatedVertices = []
        vertices = []
        triangles = []
    }

    internal func calculate(camera:Camera) {
    }
    
    internal func renderComponents(fillMode:FillMode) -> [CanvasObject] {
        guard inCameraView && !triangles.isEmpty else {
            return []
        }

        var trianglePaths : [CanvasObject] = []
        print(vertices[0])
        print(calculatedVertices[0])
        for triangle in triangles {
            let trianglePath = Path(fillMode:fillMode)
            trianglePath.moveTo(calculated2DVertices[triangle.point1])
            trianglePath.lineTo(calculated2DVertices[triangle.point2])
            trianglePath.lineTo(calculated2DVertices[triangle.point3])
            trianglePath.close()

            trianglePaths.append(trianglePath)
        }
        
        return trianglePaths
    }
}
