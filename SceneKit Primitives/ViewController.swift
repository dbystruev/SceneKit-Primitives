//
//  ViewController.swift
//  SceneKit Primitives
//
//  Created by Denis Bystruev on 25/01/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Switch the light on
        sceneView.autoenablesDefaultLighting = true
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene()
        
        if let campus = loadCampus() {
            scene.rootNode.addChildNode(campus)
        }
        
        let programmaticCampus = loadProgrammaticCampus()
        scene.rootNode.addChildNode(programmaticCampus)
        
        // Set the scene to the view
        sceneView.scene = scene
    }
    
    func loadCampus() -> SCNNode? {
        guard let scene = SCNScene(named: "art.scnassets/Campus.scn") else { return nil }
        
        let node = scene.rootNode.clone()
        
        return node
    }
    
    func loadProgrammaticCampus() -> SCNNode {
        let campusNode = SCNNode()
        
        let buildingNode = loadBuilding()
        
        buildingNode.runAction(
            .repeatForever(
                .rotateBy(x: 0, y: -.pi, z: 0, duration: 1)
            )
        )
        
        buildingNode.position.z -= 3
        campusNode.addChildNode(buildingNode)
        
        return campusNode
    }
    
    func loadBuilding() -> SCNNode {
        let buildingNode = SCNNode()
        
        
        // Creation of brown box
        let boxNode = SCNNode()
        boxNode.position.y += 0.5
        
        // Geometry
        let building = SCNBox(width: 3, height: 1, length: 1, chamferRadius: 0)
        
        // Material
        var materials = [SCNMaterial]()
        
        [UIColor.red, .orange, .yellow, .green, .blue, .purple].forEach { color in
            let material = SCNMaterial()
            material.diffuse.contents = color
            materials.append(material)
        }
        
        building.materials = materials
        
        boxNode.geometry = building
        
        buildingNode.addChildNode(boxNode)
        
        
        // Creation of green grass
        let grassNode = SCNNode(geometry: SCNPlane(width: 6, height: 2))
        grassNode.eulerAngles.x -= .pi / 2
        grassNode.geometry?.firstMaterial?.diffuse.contents = UIColor.green
        buildingNode.addChildNode(grassNode)
        
        
        return buildingNode
    }
    
    func loadTree() -> SCNNode {
        let treeNode = SCNNode()
        
        return treeNode
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
