# Scenes3D

_Scenes3D_ provides a Swift object library with support for 3D components.  _Scenes3D_ runs on top of Scenes and IGIS.

## Proposed Properties
- Vector3: stores coordinates in 3d space for size, scale, position, etc.
- Orientation: stores coordinates in 3d space for rotation (accessible in degrees and radians)
- Region3: (similar to rect) stores, size, position, and orientation of a 3d rectangular prism

## Proposed Objects
- Layer3D: a Scenes layer with support for 3D objects (preferably not able to render 2D components)
- Model: (similar to RenderableEntity) groups 3D components together to make manipulation complex objects easier (also allows for prerendering object interactions?)
- Part: (name change possible - similar to CanvasObject) a 3D object actually renderable on the screen.
- Camera: stores position, rotation, and viewport, one can be assigned to Layer3D, and is in charge of determining how to render in 3d space.
- Light: An object that defines where light sources from, along with its reach and brightness.  Initial lighting will be done on a face-to-face surface without gradients (entire faces will be the same color).
