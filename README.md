# Scenes3D

**Note: still under development; not available for use.**

_Scenes3D_ provides a Swift object library with support for 3D renderable entities.  _Scenes3D_ runs on top of Scenes and IGIS.

## Setup
To use the _Scenes3D_ library in your existing Scenes project, add the following line to your `dylib.manifest` file:

```shell
Scenes3D          <version>
```

Then, run the following commands on the command line:

```shell
rm dir-locals.el
dylibEmacs
build
```

## Getting Started
This section provides a brief introduction to using _Scenes3D_.  Use the project _ScenesShell_ as a starting point.

### Creating a `Layer3D`
Before we can start rendering any 3D objects in Scenes, we need to set up two things: A `Layer3D` which will internally handle all of the 3D rendering, and a `Camera` that will define how we view into the 3D space.

```swift
class MyLayer : Layer3D {
	init() {
		super.init(name:"MyLayer")
		
		let camera = Camera(fieldOfView:75, nearClipPlane:1, farClipPlane1)
		self.setCamera(camera)
	}
}
```

Let's take a closer look at the camera.  The first attribute, **fieldOfView**, represents the extent of the layer that is seen at any given moment.  The value is in degrees.

The second attribute, not utilized in this example, is **viewportRect**, which defines where in 2D space the cameras rendering will appear on screen.  If left as nil, the camera will assume the full size of the canvas.

The final two attributes, **nearClipPlane** and **farClipPlane** dictate the range from the camera objects will render in.  Any object between the near and far clipping planes will be rendered, whereas those further away, past the **farClipPlane** will not be rendered.  If you are experiencing performance issues, try adjusting these two values to decrease the rendering area.

In order for a `Layer3D` to render its components, you first need to insert it into the current `Scene` using the **insert** method.  You will also need to assign it a `Camera` through the **setCamera** method as seen above.

### Setting up a `RenderableEntity3D`
lol

## Documentation

### Vector3

### Quaternion

### EulerAngle

### Matrix4

### Transform3D

### Plane

### Bounds

### Camera

### Layer3D

### RenderableEntity3D

### Object3D
