
Hi! Here's my submission.

Though it's not pure SwiftUI and contains some Metal code, it is integrated into SwiftUI view and uses declarative approach for dispatching shaders.
I use my own open source package 'MetalBuilder' for this.
It's a wrapper that alllows to manage Metal objects in a functional manner mimicking SwiftUI. E.g., buffers and textures are created using property wrappers like this: 
```
@MetalBuffer<Particle>(count: particlesCount, metalName: "particles") var particlesBuffer
@MetalTexture(textureDescriptor
        .pixelFormat(.rgba16Float)) var texture
```
The Metal view is created just like any other SwiftUI view and takes a resultBuilder closure that describes shader dispatch like this:
```
Compute("integration")
                    .buffer(particlesBuffer, space: "device",
                            fitThreads: true)
Render(vertex: "vertexShader", fragment: "fragmentShader", 
       type: .point, count: particlesCount)
                    .vertexBuf(particlesBuffer)
                    .vertexBytes(context.$viewportSize)
                    .fragBytes($flameType, name: "type")
                    .toTexture(renderTexture)
```
As you can see, the wrapper can take Binding as a shader parameter. 
Along with it you can pass a name of the metal property that the binded Swift property would represent in shader code, allowing MetalBuilder to generate automatically most of the declarations of the shader function at the time the view loads. This considerably reduces the amount of Metal code that should be written and makes Metal much more simple to use with SwiftUI, making it approachable even for beginners.
