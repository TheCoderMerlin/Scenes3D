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

// This is a crude mock-up (most properties are likely to change)
public class Object3D : Transformable {
    internal var inCameraView : Bool
    internal var calculated2DVertices : [Point] // represent vertices transposed from local camera space to 2D screen space
    internal var calculatedVertices : [Vector3] // represent vertices in local camera space (saved to improve performance)

    public var transform : Transform3D // represents the object in global space
    public var vertices : [Vector3] // represent verticies in global space

    public typealias Triangle = (point1:Int, point2:Int, point3:Int)
    public var triangles : [Triangle]
    public var fillStyle : FillStyle = FillStyle(color:Color(.black))
    public var strokeStyle : StrokeStyle = StrokeStyle(color:Color(.black))

    public var renderMode : RenderMode = .default

    public init(transform:Transform3D) {
        inCameraView = false
        calculated2DVertices = []
        calculatedVertices = []
        self.transform = transform
        vertices = []
        triangles = []
    }

    internal func calculate(camera:Camera) {
        calculatedVertices = []
        for vertice in vertices {
            calculatedVertices.append(vertice.rotatingAround(point:transform.position, by:transform.rotation))
        }

        calculated2DVertices = []
        for vertice in calculatedVertices {
            let perspective = camera.fieldOfView / (camera.fieldOfView + vertice.z)
            let point = Point(x:Int(vertice.x * perspective) + camera._viewportRect.width/2,
                              y:Int(vertice.y * perspective) + camera._viewportRect.height/2)
            calculated2DVertices.append(point)
        }
    }
    
    internal func renderComponents(fillMode:FillMode) -> [CanvasObject] {
        guard inCameraView && !triangles.isEmpty && !calculated2DVertices.isEmpty else {
            return []
        }

        switch renderMode {
        case .default:
            var canvasObjectArray : [CanvasObject] = [fillStyle, strokeStyle]
            
            for triangle in triangles {
                if fillMode == .fill || fillMode == .fillAndStroke {
                    let trianglePath = Path(fillMode:.fill)
                    trianglePath.moveTo(calculated2DVertices[triangle.point1])
                    trianglePath.lineTo(calculated2DVertices[triangle.point2])
                    trianglePath.lineTo(calculated2DVertices[triangle.point3])
                    trianglePath.close()
                    
                    canvasObjectArray.append(trianglePath)
                }
                
                if fillMode == .stroke || fillMode == .fillAndStroke {
                    
                }
            }
            return canvasObjectArray
        case .wireframe:
            var canvasObjectArray : [CanvasObject] = [strokeStyle]

            return canvasObjectArray
        case .verticies:
            var canvasObjectArray : [CanvasObject] = [strokeStyle]

            for verticie in calculated2DVertices {
                let rect = Rect(topLeft:verticie, size:Size(width:1, height:1))
                let rectangle = Rectangle(rect:rect, fillMode:.stroke)
                canvasObjectArray.append(rectangle)
            }

            return canvasObjectArray
        }
    }
}
