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
    
    @State var canvas = PKCanvasView()
    
    @Bindable var card: Card
    
    
    @State private var frontImage: UIImage
    @State private var backImage: UIImage
    
    
    init(card: Card) {
        self.card = card
        frontImage = UIImage()
        backImage = UIImage()
        
        do {
            if let ddd = card.drawingFront {
                canvas.drawing = try PKDrawing.init(data: ddd)
                frontImage = canvas.drawing.image(from: canvas.drawing.bounds, scale: 1)
            } else {
                print("why is front nil????")
            }
            if let ddd = card.drawingBack {
                print(ddd)
                canvas.drawing = try PKDrawing(data: ddd)
                backImage = canvas.drawing.image(from: canvas.drawing.bounds, scale: 1)
            } else {
                print("why is back nil????")
            }
            
        }
        catch {
            print("Something went wrong")
            frontImage = UIImage()
            backImage = UIImage()
            
        }
        
    }
        
        //let card: Card
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
                    
                    Image(uiImage: isShowingBack ? backImage : frontImage)
                    
                    
                    //w.drawing = try PKDrawing(data:displayData)
                    
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


#Preview {
    WhiteCardView(card: Card(front: "Front", back: "Back"))
}
