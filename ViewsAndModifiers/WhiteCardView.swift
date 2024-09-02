//
//  WhiteCardView.swift
//  ViewsAndModifiers
//
//  Created by Seungyoo Kim-Jung on 8/31/24.
//

import SwiftData
import SwiftUI

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
                } else {
                    Text(card.front)
                        .font(.largeTitle)
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

#Preview {
    WhiteCardView(card: Card(front: "Front", back: "Back"))
}
