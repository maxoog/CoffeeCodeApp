//
//  AdaptiveSheet.swift
//  CoffeeCode
//
//  Created by Maksim Zenkov on 04.11.2023.
//

import Foundation
import SwiftUI

struct AdaptiveSheet<Content>: View where Content: View {
    @State private var presentationHeight: CGFloat = 0
    private let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .heightChanged { newHeight in
                presentationHeight = newHeight
            }
            .ignoresSafeArea()
            .presentationDetents([.height(presentationHeight)])
            .presentationDragIndicator(.visible)
    }
}

extension View {
    public func adaptiveSheet<Content>(isPresented: Binding<Bool>, onDismiss: (() -> Void)? = nil, @ViewBuilder content: @escaping () -> Content) -> some View where Content : View {
        return self.sheet(isPresented: isPresented, onDismiss: onDismiss) {
            AdaptiveSheet(content: content)
        }
    }
}
