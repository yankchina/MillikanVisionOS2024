import SwiftUI
import RealityKit


struct ARViewContainer: UIViewRepresentable {
    
    var modelName: String?
    @Binding var scale: SIMD3<Float>
    @Binding var rotation: Float
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        // Create horizontal plane anchor for the content
        let anchor = AnchorEntity(.plane(.horizontal, classification: .any, minimumBounds: SIMD2<Float>(0.5, 0.5)))
        
        guard let modelName = modelName,
              let theURL = Bundle.main.url(forResource: modelName, withExtension: "usdz"),
              let loadedModel = try? Entity.loadModel(contentsOf: theURL) else {
            // Create a black box as a fallback
            let box = MeshResource.generateBox(size: 0.1)
            let blackMaterial = SimpleMaterial(color: .black, isMetallic: false)
            let blackBox = ModelEntity(mesh: box, materials: [blackMaterial])
            // Add the black box to the anchor
            anchor.addChild(blackBox)
            // Place anchor in the ARView scene
            arView.scene.addAnchor(anchor)
            return arView
        }
        
        // Scaling the model with each axis by 0.05
        loadedModel.scale = scale
        
        // Add the loaded model to the anchor
        anchor.addChild(loadedModel)
        
        // Place anchor in the ARView scene
        arView.scene.addAnchor(anchor)
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        // Update the model's scale when the scale state changes
        if let modelEntity = uiView.scene.anchors.first?.children.first as? ModelEntity {
            modelEntity.scale = scale
            // Apply both initial X rotation and dynamic Y rotation
            modelEntity.transform.rotation = simd_quatf(angle: -.pi / 2, axis: SIMD3<Float>(1, 0, 0)) * simd_quatf(angle: rotation, axis: SIMD3<Float>(0, 0, 1))
            
        }
        
    }
    
}

struct SingleARView: View {
    @State private var modelScale: SIMD3<Float> = SIMD3<Float>(0.05, 0.05, 0.05)
    @State private var modelRotation: Float = 0.0
    var modelName: String?
    
    var body: some View {
        VStack {
            ARViewContainer(modelName: modelName, scale: $modelScale, rotation: $modelRotation)
                .edgesIgnoringSafeArea(.all)
            
            HStack {
                Button(action: {
                    modelScale *= 1.1
                }) {
                    Text(NSLocalizedString("Zoom In",comment: "Zoom in AR Model"))
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    modelScale /= 1.1
                }) {
                    Text(NSLocalizedString("Zoom Out",comment:"Zoom out AR Model"))
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
            
            
            HStack {
                Button(action: {
                    modelRotation += .pi / 2
                }) {
                    Text(NSLocalizedString("Rotate1",comment:"Rotation model clockwise 90 degree"))
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    modelRotation -= .pi / 2
                }) {
                    Text(NSLocalizedString("Rotate2",comment:"Rotation model counterclockwise 90 degree"))
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
    }
}

