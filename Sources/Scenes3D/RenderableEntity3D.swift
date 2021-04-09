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
import Scenes

/// A `RenderableEntity3D` object contains 3D objects that can be manipulated as a group.
public class RenderableEntity3D : IdentifiableObject {
    public private(set) weak var owningLayer3D : Layer3D?
    private var objects : [Object3D]

    public override init(name:String?=nil) {
        owningLayer3D = nil
        objects = []

        super.init(name:name)
    }

    internal func internalSetup(canvas:Canvas, layer3D:Layer3D) {
        owningLayer3D = layer3D
        setup(canvasSize:canvas.canvasSize!, canvas:canvas)
    }

    internal func internalTeardown() {
        teardown()
    }

    internal func internalCalculate(canvas:Canvas) {
        calculate(canvasSize:canvas.canvasSize!)
        if let owningLayer3D = owningLayer3D,
           let camera = owningLayer3D.camera {
            for object in objects {
                object.calculate(camera:camera)
            }
        }
    }

    internal func internalRender(canvas:Canvas) {
        var renderComponents : [CanvasObject] = []
        
        for object in objects {
            let objectRenderComponents = object.renderComponents(fillMode:.fillAndStroke)
            for component in objectRenderComponents {
                renderComponents.append(component)
            }
        }

        canvas.render(renderComponents)
    }

    public func insert(object3D:Object3D) {
        objects.append(object3D)
    }

    public var layer3D : Layer3D {
        guard let owningLayer3D = owningLayer3D else {
            fatalError("owningLayer required")
        }
        return owningLayer3D
    }

    public var scene : Scene {
        return layer3D.scene
    }

    public var director : Director {
        return scene.director
    }

    public var dispatcher : Dispatcher {
        return director.dispatcher
    }

    open func setup(canvasSize:Size, canvas:Canvas) {
    }

    open func teardown() {
    }

    open func calculate(canvasSize:Size) {
    }
}
