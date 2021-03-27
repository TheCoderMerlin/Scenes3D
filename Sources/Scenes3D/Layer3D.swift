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

/// A 'Layer3D' is a layer object with support for rendering `Entity3D` objects.
public class Layer3D : Layer {
    public private(set) var camera : Camera?
    
    public override init(name:String?=nil) {
        super.init(name:name)
    }

    /// Inserts a new `Entity3D` into this layer to receive updates.
    /// This function should only be invoked during init(), setup(), or calculate().
    public func insert(entity3D:Entity3D) {
    }

    /// Removes an `Entity3D` from this layer.
    /// This function should only be invoked during init(), setup(), or calculate().
    public func remove(entity3D:Entity3D) {
    }

    /// Sets the current `Camera` to use for rendering this layer.
    /// This function should only be invoked during init(), setup(), or calculate().
    public func setCamera(camera:Camera?) {
        self.camera = camera
    }

    public override func preRender(canvas:Canvas) {
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

        // restore state if required
        if restoreStateRequired {
            let state = State(mode:.restore)
            canvas.render(state)
        }
    }
}
