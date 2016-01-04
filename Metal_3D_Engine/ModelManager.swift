//
//  ModelManager.swift
//  Metal_3D_Engine
//
//  Created by Adrian Krupa on 26.12.2015.
//  Copyright © 2015 Adrian Krupa. All rights reserved.
//

import Foundation
import MetalKit

class ModelManager {
    
    static func LoadObject(path: String, parameters: Dictionary<String, AnyObject>? = nil) -> Mesh? {
        
        let mdlVertexDescriptor = MTKModelIOVertexDescriptorFromMetal(Vertex.vertexDescriptor)
        
        setName(mdlVertexDescriptor, attributeIndex: VertexAttributes.Position.rawValue, name: MDLVertexAttributePosition)
        setName(mdlVertexDescriptor, attributeIndex: VertexAttributes.Color.rawValue, name: MDLVertexAttributeColor)
        setName(mdlVertexDescriptor, attributeIndex: VertexAttributes.UV.rawValue, name: MDLVertexAttributeTextureCoordinate)
        setName(mdlVertexDescriptor, attributeIndex: VertexAttributes.Tangent.rawValue, name: MDLVertexAttributeTangent)
        setName(mdlVertexDescriptor, attributeIndex: VertexAttributes.Normal.rawValue, name: MDLVertexAttributeNormal)
        
        let bufferAllocator = MTKMeshBufferAllocator.init(device: EngineController.device)

        let assetURL = NSBundle.mainBundle().URLForResource(path, withExtension: nil)
        
        if assetURL == nil {
            return nil
        }
        
        let asset = MDLAsset.init(URL: assetURL!, vertexDescriptor: mdlVertexDescriptor, bufferAllocator: bufferAllocator)
        
        let mtkMeshes: NSArray?
        var mdlMeshes: NSArray?
        
        do {
            mtkMeshes = try MTKMesh.newMeshesFromAsset(asset, device: EngineController.device, sourceMeshes: &mdlMeshes)
        } catch {
            print("Failed to create mesh")
            return nil
        }
        
        let buf = mdlMeshes![0].vertexBuffers![0]
        let mapa = buf.map()
        
        let pointer = UnsafePointer<Vertex>(mapa.bytes)
        let buffer = UnsafeBufferPointer(start: pointer, count: mdlMeshes![0].vertexCount!)
        
        var vertices: [Vertex] = Array<Vertex>(buffer)
        
        let mm = mdlMeshes![0] as! MDLMesh
        //mm.makeVerticesUnique()
        let sm = mm.submeshes[0] as! MDLSubmesh
        
        let imapa = sm.indexBuffer.map()
        let ipointer = UnsafePointer<Triangle<UInt32>>(imapa.bytes)
        let ibuffer = UnsafeBufferPointer(start: ipointer, count: sm.indexCount/3)
        let indices: [Triangle<UInt32>] = Array(ibuffer)
        
        if let par = parameters {
            if let color = par["color"] as? Color {
                for i in 0..<vertices.count {
                    vertices[i].color = color.getRGBA()
                }
            }
            if let color = par["Color"] as? Color {
                for i in 0..<vertices.count {
                    vertices[i].color = color.getRGBA()
                }
            }
        }
        
        return TrianglesMesh(points: vertices, triangles: indices)
        return nil
    }
    
    private static func setName(mdlVertexDescriptor: MDLVertexDescriptor, attributeIndex: Int, name: String) {
        
        let vertAttribute = mdlVertexDescriptor.attributes[attributeIndex] as! MDLVertexAttribute
        vertAttribute.name = name
        mdlVertexDescriptor.attributes[attributeIndex] = vertAttribute
    }
    
}
