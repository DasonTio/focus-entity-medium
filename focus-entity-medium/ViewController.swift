//
//  ViewController.swift
//  focus-entity-medium
//
//  Created by Dason Tiovino on 31/05/24.
//

import Foundation
import UIKit
import ARKit
import RealityKit
import FocusEntity

class ViewController: UIViewController,ARSessionDelegate{
    private var focusEntity: FocusEntity!
    private var arView: ARView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arView = ARView(frame: view.bounds)
        arView.session.delegate = self
        view.addSubview(arView)
        
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical]
        arView.session.run(config)
        
        focusEntity = FocusEntity(on: arView, style: .classic(color: .white))
        
        NotificationCenter.default.addObserver(forName: .placeModel, object: nil, queue: .main) { _ in
            self.placeModel(in: self.arView, focusEntity: self.focusEntity)
        }
    }
    
    func placeModel(in arView: ARView, focusEntity: FocusEntity?) {
        guard let focusEntity = focusEntity else { return }
        
        do {
            let modelEntity = try ModelEntity.loadModel(named: "Clipboard")
            
            let focusTransform = focusEntity.transformMatrix(relativeTo: nil)
            let correctedTransform = focusTransform * float4x4(simd_quatf(angle: .pi / 2 * -1, axis: [1, 0, 0]))
            let anchorEntity = AnchorEntity(world: correctedTransform)
            anchorEntity.addChild(modelEntity)
            arView.scene.addAnchor(anchorEntity)
        } catch {
            print("Failed to load model: \(error)")
        }
    }
}


