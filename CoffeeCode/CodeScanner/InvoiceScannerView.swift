//
//  InvoiceScanner.swift
//  CoffeeCode
//
//  Created by Maksim Zenkov on 05.11.2023.
//

import Foundation
import SwiftUI
import CodeScanner
import UIKit
import CoreUI

struct InvoiceScannerView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var offset: CGSize = .zero
    @State private var presentationCornerRadius: CGFloat = 0
    
    var body: some View {
        CodeScannerView(codeTypes: [.qr]) { result in
            handleResult(result: result)
        }
        .overlay(alignment: .topTrailing) {
            Image(systemName: "xmark")
                .resizable()
                .renderingMode(.template)
                .foregroundStyle(Color.white.opacity(0.7))
                .frame(width: 24, height: 24)
                .padding(20)
                .contentShape(Rectangle())
                .onTapGesture {
                    dismiss()
                    
                    print("dismissed")
                }
            
        }
        .overlay {
            Image("qrCodeScannerFrame")
                .resizable()
                .frame(width: 300, height: 300, alignment: .center)
                .aspectRatio(1, contentMode: .fill)
        }
        .clipShape(
            RoundedRectangle(
                cornerRadius: presentationCornerRadius,
                style: .circular
            )
        )
        .hostingControllerSetup { viewController in
            viewController.view.backgroundColor = .clear
            
            // Настраиваем углы скругления вьюхи как у айфона
            if presentationCornerRadius == 0 {
                Task { @MainActor in
                    (viewController.view.window?.screen.displayCornerRadius).map {
                        presentationCornerRadius = $0
                    }
                }
            }
        }
        .offset(x: offset.width, y: offset.height)
        .animation(.interactiveSpring(duration: 0.3), value: offset)
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                }
                .onEnded { _ in
                    if hypot(offset.width, offset.height) > 90 {
                        dismiss()
                        offset = .init(width: offset.width, height: 0)
                    } else {
                        offset = .zero
                    }
                }
        )
        .ignoresSafeArea()
    }
    
    private func handleResult(result: Result<ScanResult, ScanError>) {
        
    }
    
    
}
