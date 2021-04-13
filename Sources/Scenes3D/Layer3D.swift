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

/// A 'Layer3D' is a layer object with support for rendering `RenderableEntity3D` objects.
open class Layer3D : Layer {
    public private(set) var children : [RenderableEntity3D]
    public private(set) var camera : Camera?
    
    public override init(name:String?=nil) {
        children = []
        
        super.init(name:name)
    }

    /// If a `Camera` was added before `Setup` was invoked, we need to
    /// set it up now.
    public override final func preSetup(canvasSize:Size, canvas:Canvas) {
        for child in children {
            child.internalSetup(canvas:canvas, layer3D:self)
        }
    }

    /// All `Layer3D` calculations occur in the `postCalculate()` method so changes
    /// made during the calculate phase will be applied to all 3D objects.
    public override final func postCalculate(canvas:Canvas) {
        // we can only calculate/render if a camera is set
        guard let camera = camera else {
            return
        }

        // have camera calculate necessary matrices
        camera.calculate(canvasSize:canvas.canvasSize!)

        // calculate each child based on the cameras properties
        for child in children {
            child.internalCalculate(canvas:canvas)
        }
    }

    /// All `Layer3D` rendering occurs in the `preRender()` method so that all
    /// 2D objects rendered to the layer will be applied on top of 3D objects.
    public override final func preRender(canvas:Canvas) {
        // we can only calculate/render if a camera is set
        guard let camera = camera else {
            return
        }

        // Apply camera clipPath if specified
        let restoreStateRequired = (camera.clipPath != nil)
        if restoreStateRequired {
            let state = State(mode:.save)
            canvas.render(state)

            if let clipPath = camera.clipPath {
                canvas.render(clipPath)
            }
        }

        // Render all 3D entities
        for child in children {
            child.internalRender(canvas:canvas)
        }

        // restore state if required
        if restoreStateRequired {
            let state = State(mode:.restore)
            canvas.render(state)
        }
    }

    public override final func preTeardown() {
        for child in children {
            child.internalTeardown()
        }
    }

    /// Inserts a new `Entity3D` into this layer to receive updates.
    /// This function should only be invoked during init(), setup(), or calculate().
    public func insert(entity3D:RenderableEntity3D) {
        precondition(!children.contains(entity3D), "Cannot insert specified RenderableEntity3D '\(entity3D.name)' because it is already inserted.")
        children.append(entity3D)
    }

    /// Removes an `Entity3D` from this layer.
    /// This function should only be invoked during init(), setup(), or calculate().
    public func remove(entity3D:RenderableEntity3D) {
        precondition(!children.contains(entity3D), "Cannot remove specified RenderableEntity3D '\(entity3D.name)' because it isn't inserted.")
        children.removeAll {$0 == entity3D}
    }

    /// Sets the current `Camera` to use for rendering this layer.
    /// This function should only be invoked during init(), setup(), or calculate().
    public func setCamera(camera:Camera?) {
        guard camera != self.camera else {
            return
        }
        
        self.camera = camera
    }
}
