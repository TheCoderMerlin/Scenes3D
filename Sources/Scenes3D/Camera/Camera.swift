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

import Foundation
import Igis

/// A `Camera` represents a viewport into 3D space.
public class Camera {
    internal private(set) var clipPath : ClipPath?
    internal private(set) var projectionMatrix : Matrix4
    
    private var needNewClipPath : Bool
    private var needNewProjectionMatrix : Bool
    
    /// The field of view of the camera in degrees.
    public var fieldOfView : Double {
        didSet {
            precondition(fieldOfView > 0, "Camera fieldOfView must be greater than 0.")
            needNewProjectionMatrix = true
        }
    }
    
    /// Where on the screen the camera is rendered.
    /// If set to nil, camera will assume canvasSize.
    public var viewportRect : Rect? {
        didSet {
            needNewClipPath = true
        }
    }
    
    /// The distance of the near clipping plane from the Camera.
    public var nearClipPlane : Int {
        didSet {
            precondition(farClipPlane > nearClipPlane, "Camera nearClipPlane must be smaller than farClipPlane.")
            precondition(nearClipPlane > 0, "Camera nearClipPlane must be greater than 0.")
            needNewProjectionMatrix = true
        }
    }
    
    /// The distance of the far clipping plane from the Camera.
    public var farClipPlane : Int {
        didSet {
            precondition(farClipPlane > nearClipPlane, "Camera farClipPlane must be larger than nearClipPlane.")
            precondition(farClipPlane > 0, "Camera farClipPlane must be greater than 0.")
            needNewProjectionMatrix = true
        }
    }

    /// Creates a new `Camera` from the specified values.
    /// - Parameters:
    ///   - fieldOfView: The camera's horizontal vield of view (in degrees).
    ///   - viewportRect: Where the camera is rendered on the screen. Default is nil.
    ///   - nearClipPlane: The distance to the near clipping plane from the camera.
    ///   - farClipPlane: The distance to the far clipping plane from the camera.
    public init(fieldOfView:Double = 75.0, viewportRect:Rect? = nil, nearClipPlane:Int = 1, farClipPlane:Int = 1000) {
        precondition(fieldOfView > 0, "Camera fieldOfView must be greater than 0.")
        precondition(farClipPlane > nearClipPlane, "Camera nearClipPlane must be smaller than farClipPlane.")
        precondition(nearClipPlane > 0, "Camera nearClipPlane must be greater than 0.")
        precondition(farClipPlane > nearClipPlane, "Camera farClipPlane must be larger than nearClipPlane.")
        precondition(farClipPlane > 0, "Camera farClipPlane must be greater than 0.")
        
        self.fieldOfView = fieldOfView
        self.viewportRect = viewportRect
        self.nearClipPlane = nearClipPlane
        self.farClipPlane = farClipPlane

        clipPath = nil
        projectionMatrix = Matrix4.identity

        needNewClipPath = true
        needNewProjectionMatrix = true
    }

    internal func preCalculate() {
        // calculate a new clip path if needed
        if needNewClipPath {
            if let viewportRect = viewportRect {
                let viewportPath = Path(rect:viewportRect)
                clipPath = ClipPath(path:viewportPath)
            }

            needNewClipPath = false
        }

        // calculates a new projection matrix if needed
        // TODO: redo algorithm (this is most certainly incorrect)
        if needNewProjectionMatrix {
            // TODO: test algorithm (derived from https://github.com/mrdoob/three.js/blob/master/src/cameras/PerspectiveCamera.js)
            let scale = 1 / tan(fieldOfView.inRadians * 0.5)
            let a = -Double(farClipPlane) / Double(farClipPlane - nearClipPlane)
            let b = a * Double(nearClipPlane)
            projectionMatrix = Matrix4(values:[[scale, 0.0,   0.0,   0.0],
                                               [0.0,   scale, 0.0,   0.0],
                                               [0.0,   0.0,   a,     -1.0],
                                               [0.0,   0.0,   b,     0.0]])
            
            needNewProjectionMatrix = false
        }
    }
}
