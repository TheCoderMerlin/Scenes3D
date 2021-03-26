# Scenes3D

_Scenes3D_ provides a Swift object library with support for 3D renderable entities.  _Scenes3D_ runs on top of Scenes and IGIS.

## Proposal
_Scenes3D_ will act fairly dependent of _Scenes_ objects in order to maintain internal control of rendering components. Unlike standard Igis components, these objects will not be directly rendered to the canvas by users, but rather assigned to an object which will handle the rendering (similar to ScenesControls). Methods will be provided to add and remove components, as well as hide their visibility (should be used if object isn't being removed, only temporarily hidden).

### Proposed Objects
- Layer3D: a layer object with support for 3D objects (standard 2D objects must be assigned to a 3D plane before being inserted to a Layer3D for rendering?)
- Model: (similar to a Scenes RenderableEntity) groups 3D components together to make manipulation of complex objects easier.
- Object3D: a 3D object renderable to the screen.  Must be assigned to a Layer3D or a Model (which is in turn assigned to a Layer3D) to be rendered.
- Camera: conforms to Scenes `Layer` object. Stores position, rotation, and viewport information pertinent to rendering 3D components.  `Layer3D` objects will be assigned to a camera, which will in turn be assigned to a Scenes `Scene`, for rendering.
- Light: An object that defines the position and direction of a light source in 3D space, along with its brightness and radius.  Lights will likely conform to `Object3D` (similar to `FillStyle` and `StrokStyle` being "rendered" to the canvas).

### Changes to Functionality
Rather than utilizing the `Layer3D` for rendering, the camera will conform to Scenes `Layer` type thus providing all rendering functionality. `Layer3D`s will not conform to any default Scenes types, but instead will act as their own unique type insertable to `Camera` objects so we can centralize the rendering capabilities to the camera while also maintaining more control over the internal methods for preparing, rendering, and terminating `Layer3D` objects (this is impossible with the current Scenes `Layer` objects as methods are marked as internal to the library).
