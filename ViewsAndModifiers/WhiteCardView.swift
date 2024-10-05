//
//  WhiteCardView.swift
//  ViewsAndModifiers
//
//  Created by Seungyoo Kim-Jung on 8/31/24.
//

import SwiftData
import SwiftUI
import PencilKit

struct WhiteCardView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var accessibilityDifferentiateWithoutColor
    
    @State private var offset = CGSize.zero
    @State private var isShowingBack = false
    
    //let card: Card
    @Bindable var card: Card
    //let card = CardTest(front: "Front", back: "Back")
    var removal: (() -> Void)? = nil
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(
                    accessibilityDifferentiateWithoutColor
                    ? .white
                    : .white
                        .opacity(1 - Double(abs(offset.width / 50)))
                )
                .background(
                    accessibilityDifferentiateWithoutColor
                    ? nil
                    : RoundedRectangle(cornerRadius: 25)
                        .fill(offset.width > 0 ? .green : .red)
                )
                .shadow(radius: 10)
            
            VStack {
                if isShowingBack {
                    Text(card.back)
                        .font(.largeTitle)
                        .padding()
                    
                    if card.drawingBack != nil {
                        CardDrawingView(card: card, isFront: false)
                            .padding()
                    }
                } else {
                    Text(card.front)
                        .font(.largeTitle)
                        .padding()
                    
                    if card.drawingFront != nil {
                        CardDrawingView(card: card, isFront: true)
                            .padding()
                    }
                }
            }
        }
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(offset.width / 5.0))
        .offset(x: offset.width * 5)
        .opacity(2 - Double(abs(offset.width / 50)))
        .accessibilityAddTraits(.isButton)
        .gesture(
        DragGesture()
            .onChanged { gesture in
                offset = gesture.translation
            }
            .onEnded { _ in
                if abs(offset.width) > 100 {
                    removal?()
                } else {
                    offset = .zero
                }
            }
        )
        .onTapGesture {
            isShowingBack.toggle()
        }
    }
}

struct CardDrawingView: View {
    @State private var canvas = PKCanvasView()
    @State private var isDrawing = true
    @State private var color: Color = .black
    @State private var pencilType: PKInkingTool.InkType = .pen
    @State private var colorPicker = false
    @Environment(\.undoManager) private var undoManager
    
    @State private var clearCanvas = false
    
    @Bindable var card: Card
    
    @State private var isFront: Bool
    
    
    
    var body: some View {
        ShowDrawingView(canvas: $canvas, isDrawing: $isDrawing, pencilType: $pencilType, color: $color)
    }
    
    
    init(card: Card, isFront: Bool) {
        self.card = card
        self.isFront = isFront

        do {
            if self.isFront {
                if let ddd = card.drawingFront {
                    print("before try front")
                    print(ddd)
                    canvas.drawing = try PKDrawing.init(data: ddd)
                    print("after try front")
                } else {
                    print("why is front nil????")
                }
            } else {
                if let ddd = card.drawingBack {
                    print("before try back")
                    print(ddd)
                    canvas.drawing = try PKDrawing(data: ddd)
                    print("after try back")
                } else {
                    print("why is back nil????")
                }
            }
        }
        catch {
            print("Something went wrong")
            print(self.isFront)
            print(card.drawingFront)
            print(card.drawingBack)

        }
        
    }
    
    
    func newCanvas() {
        canvas.drawing = PKDrawing()
        clearCanvas = false
    }
    
    func saveDrawing() {
        //let drawingImage = canvas.drawing.image(from: canvas.drawing.bounds, scale: 1.0)
        let drawingImage = canvas.drawing.dataRepresentation()

        if isFront {
            //card.drawingFront = drawingImage.pngData()
            card.drawingFront = drawingImage
        } else {
            card.drawingBack = drawingImage
        }
    }
}

struct ShowDrawingView: UIViewRepresentable {
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
    WhiteCardView(card: Card(front: "Front", back: "Back"))
}
