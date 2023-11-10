//
//  SheetWithScroll.swift
//  CoffeeCode
//
//  Created by Maksim Zenkov on 04.11.2023.
//

import Foundation
import SwiftUI
import CoreUI

struct CoffeePointCard: View {
    let color = AnyView(Color.random.frame(height: 200))
    let backColor = AnyView(Color.random)
    
    @State var innerHeight: CGFloat = 0
    
    var body: some View {
//        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    Image("skuratov")
                        .resizable()
                        .scaledToFill()
                        .frame(height: 200)
                        .clipped()
                    
                    VStack(alignment: .leading) {
                        Text("Скуратов кофе").bold()
                        
                        Text("Обжарщики кофе и сеть брю-баров")
                        
                        Text(description)
                    }
                    .padding(.horizontal, 16)
                }
                .heightChanged { newHeight in
                    innerHeight = newHeight
                }
            }
            .frame(maxHeight: innerHeight)
//            .presentationBackground(.thinMaterial)
//            .presentationContentInteraction(.scrolls)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image("logoutIcon").resizable().frame(width: 24, height: 24)
                }
            }
//        }
    }
    
    private var description: String {
        """
        51 кофейня в 7 городах России
        Омск, Москва, Петербург, Казань, Н.Новгород, Новосибирск, Самара

        2 собственных обжарочных цеха в Омске и Москве.

        Фанаты колд брю. Привезли в Россию эйр латте и нитро кофе.

        In Omsk We Trust
        """
    }
}

extension Color {
    fileprivate static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}
