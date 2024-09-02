//
//  StudyView.swift
//  ViewsAndModifiers
//
//  Created by Seungyoo Kim-Jung on 8/31/24.
//

import SwiftData
import SwiftUI

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(x: offset * 1, y: offset * 1.5)
    }
}

struct StudyView: View {
    //@State private var cards = Array<CardTest>(repeating: .example, count: 10)
    @State private var isActive = true
    
    @State private var numCards = 10
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color(red: 0.5, green: 0.7, blue: 0.9), Color(red: 0.4, green: 0.5, blue: 0.9)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            //WhiteCardView()
            ForEach(0..<numCards, id: \.self) { index in
                WhiteCardView() {
                    withAnimation {
                        removeCard(at: index)
                    }
                }
                .stacked(at: index, in: numCards)
                .allowsHitTesting(index == numCards - 1)
                .accessibilityHidden(index < numCards - 1)
            }
            
        }
    }
    
    func removeCard(at index: Int) {
        guard index >= 0 else { return }
        
        numCards -= 1
        
        if numCards == 0 {
            isActive = false
        }
    }
}

#Preview {
    StudyView()
}
