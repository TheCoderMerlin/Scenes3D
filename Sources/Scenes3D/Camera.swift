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

/// A `Camera` represents a viewport into 3D space.
public class Camera {
    internal private(set) var clipPath : ClipPath?
    
    /// The field of view of the camera in degrees.
    public var fieldOfView : Double
    /// Where on the screen the camera is rendered.
    /// If set to nil, camera will assume canvasSize.
    public var viewportRect : Rect? {
        didSet {
            clipPath = Camera.calculateClipPath(viewportRect:viewportRect)
        }
    }
    
    /// The distance of the near clipping plane from the Camera.
    public var nearClipPlane : Int
    /// The distance of the far clipping plane from the Camera.
    public var farClipPlane : Int

    /// Creates a new `Camera` from the specified values.
    /// - Parameters:
    ///   - fieldOfView: The camera's vertical vield of view.
    ///   - viewportRect: Where the camera is rendered on the screen. Default is nil.
    ///   - nearClipPlane: The distance to the near clipping plane from the camera.
    ///   - farClipPlane: The distance to the far clipping plane from the camera.
    public init(fieldOfView:Double, viewportRect:Rect? = nil, nearClipPlane:Int, farClipPlane:Int) {
        self.fieldOfView = fieldOfView
        self.viewportRect = viewportRect
        self.nearClipPlane = nearClipPlane
        self.farClipPlane = farClipPlane

        clipPath = Camera.calculateClipPath(viewportRect:viewportRect)
    }

    private static func calculateClipPath(viewportRect:Rect?) -> ClipPath? {
        guard let viewportRect = viewportRect else {
            return nil
        }

        let viewportPath = Path(rect:viewportRect)
        let clipPath = ClipPath(path:viewportPath)
        return clipPath
    }
}
