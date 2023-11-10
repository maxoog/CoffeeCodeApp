//
//  HeightObserver.swift
//  CoffeeCode
//
//  Created by Maksim Zenkov on 04.11.2023.
//

import Foundation
import SwiftUI

extension View {
    public func heightChanged(_ heightCallback: @escaping (CGFloat) -> Void) -> some View {
        modifier(HeightUpdater(heightCallback: heightCallback))
    }
}

private struct HeightUpdater: ViewModifier {
    let heightCallback: (CGFloat) -> Void

    func body(content: Content) -> some View {
        content
            .overlay {
                GeometryReader { proxy in
                    Color.clear.preference(key: HeightPreference.self, value: proxy.size.height)
                }
                .onPreferenceChange(HeightPreference.self, perform: heightCallback)
            }
    }
}

private struct HeightPreference: PreferenceKey {
    static var defaultValue: CGFloat { 0 }
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {}
}
