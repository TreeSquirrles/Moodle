//
//  CardDrawingView.swift
//  ViewsAndModifiers
//
//  Created by Seungyoo Kim-Jung on 7/13/24.
//

import PencilKit
import SwiftUI

struct CardDrawingView: View {
    var body: some View {
        NavigationSplitView {
            Text("Sidebar")
        } content: {
            FreeFormDrawingView() // 1
        } detail: {
            FreeFormDrawingView() // 2
        }
    }
}

struct FreeFormDrawingView: View {
    @State private var canvas = PKCanvasView()
    @State private var isDrawing = true
    @State private var color: Color = .black
    @State private var pencilType: PKInkingTool.InkType = .pen
    @State private var colorPicker = false
    @Environment(\.undoManager) private var undoManager
    
    
    var body: some View {
        NavigationStack{
            DrawingView(canvas: $canvas, isDrawing: $isDrawing, pencilType: $pencilType, color: $color)
                .toolbar{
                    ToolbarItemGroup(placement: .bottomBar){
                        Button {
                            canvas.drawing = PKDrawing()
                        } label: {
                            Image(systemName: "scissors")
                        }
                        
                        Button {
                            isDrawing = true
                            pencilType = .pen
                        } label: {
                            Image(systemName: "pencil")
                        }
                        
                        Button {
                            undoManager?.undo()
                        } label: {
                            Image(systemName: "arrow.uturn.backward")
                        }
                        
                        Button {
                            undoManager?.redo()
                        } label: {
                            Image(systemName: "arrow.uturn.forward")
                        }
                        
                        Button {
                            isDrawing = false
                        } label: {
                            Image(systemName: "eraser.line.dashed")
                        }
                        
                        Divider()
                            .rotationEffect(.degrees(90))
                        
                        Button {
                            saveDrawing()
                        } label: {
                            Image(systemName: "square.and.arrow.down.on.square")
                        }
                        
                    }
                }
        }
    }
    
    func saveDrawing() {
        let drawingImage = canvas.drawing.image(from: canvas.drawing.bounds, scale: 1.0)
        
        UIImageWriteToSavedPhotosAlbum(drawingImage, nil, nil, nil)
    }
}

struct DrawingView: UIViewRepresentable {
    @Binding var canvas: PKCanvasView
    @Binding var isDrawing: Bool
    @Binding var pencilType: PKInkingTool.InkType
    @Binding var color: Color
    
    var ink: PKInkingTool {
        PKInkingTool(pencilType, color: UIColor(color))
    }
    
    let eraser = PKEraserTool(.bitmap)
    
    
    
    func makeUIView(context: Context) -> PKCanvasView {
        canvas.drawingPolicy = .anyInput
        canvas.tool = isDrawing ? ink: eraser
        canvas.alwaysBounceVertical = true
        
        let toolPicker = PKToolPicker.init()
        toolPicker.setVisible(true, forFirstResponder: canvas)
        toolPicker.addObserver(canvas)
        canvas.becomeFirstResponder()
        return canvas
        
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        uiView.tool = isDrawing ? ink : eraser
    }
}

#Preview {
    CardDrawingView()
}
