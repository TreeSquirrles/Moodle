//
//  StudyView.swift
//  ViewsAndModifiers
//
//  Created by Seungyoo Kim-Jung on 8/31/24.
//

import SwiftData
import SwiftUI

//extension View {
//    func stacked(at position: Int, in total: Int) -> some View {
//        let offset = Double(total - position)
//        return self.offset(x: offset * 1, y: offset * 1.5)
//    }
//}

struct StudyView: View {
//    @State private var cards = Array<CardTest>(repeating: .example, count: 10)
//    @State private var isActive = true
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color(red: 0.5, green: 0.7, blue: 0.9), Color(red: 0.4, green: 0.5, blue: 0.9)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
//            
//            ZStack {
//                ForEach(0..<cards.count, id: \.self) { index in
//                    WhiteCardView(card: cards[index]) {
//                        withAnimation {
//                            removeCard(at: index)
//                        }
//                    }
//                    .stacked(at: index, in: cards.count)
//                    .allowsHitTesting(index == cards.count - 1)
//                    .accessibilityHidden(index < cards.count - 1)
//                }
//            }
            
        }
    }
    
//    func removeCard(at index: Int) {
//        guard index >= 0 else { return }
//        
//        cards.remove(at: index)
//        
//        if cards.isEmpty {
//            isActive = false
//        }
//    }
}

#Preview {
    StudyView()
}
