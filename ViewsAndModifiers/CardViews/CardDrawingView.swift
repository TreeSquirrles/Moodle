//
//  CardDrawingView.swift
//  ViewsAndModifiers
//
//  Created by Seungyoo Kim-Jung on 7/13/24.
//

import PencilKit
import SwiftUI

struct CardDrawingView: View {
    @State private var columnVisibility = NavigationSplitViewVisibility.doubleColumn
    
    var body: some View {
        HStack{
            FreeFormDrawingView()
            Image("Divider")
            FreeFormDrawingView()
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
    
    @State private var clearCanvas = false
    
    
    var body: some View {
        NavigationStack{
            DrawingView(canvas: $canvas, isDrawing: $isDrawing, pencilType: $pencilType, color: $color)
                .toolbar{
                    ToolbarItemGroup(placement: .automatic){
                        
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
                        
                        Button (role: .destructive) {
                            clearCanvas = true
                        } label: {
                            Image(systemName: "trash")
                        }
                        .foregroundStyle(.red)
                        
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
        .alert("WARNING", isPresented: $clearCanvas) {
            Button("Delete", role: .destructive, action: newCanvas)
                .fontWeight(.bold)
        } message: {
            Text("Are you sure you want to clear canvas?")
        }
    }
    
    func newCanvas() {
        canvas.drawing = PKDrawing()
        clearCanvas = false
    }
    
    func saveDrawing() {
        let drawingImage = canvas.drawing.image(from: canvas.drawing.bounds, scale: 1.0)
        
        // Does not work. Needs to be stored using the SwiftData
        // // UIImageWriteToSavedPhotosAlbum(drawingImage, nil, nil, nil)
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
