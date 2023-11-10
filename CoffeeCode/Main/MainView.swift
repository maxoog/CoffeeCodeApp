//
//  ContentView.swift
//  CoffeeCode
//
//  Created by Maksim Zenkov on 27.10.2023.
//

import SwiftUI
import CodeScanner
import AlertToast

struct MainView: View {
    @ObservedObject var authService: AuthService
    
    @State private var isShowingScanner = false
    
    @State private var showToast = false
    
    var body: some View {
        ScrollView {
            CoffeeBonusesView()
            
            Spacer()
        }
        .overlay(alignment: .bottomTrailing) {
            Image(systemName: "qrcode")
                .renderingMode(.template)
                .resizable()
                .frame(width: 28, height: 28)
                .padding(16)
                .foregroundStyle(Color.black)
                .background(Color.gray.opacity(0.7), in: RoundedRectangle(cornerRadius: 8))
                .padding(.trailing, 16)
                .onTapGesture {
                    isShowingScanner = true
                }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Image("logoutIcon")
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 28, height: 28)
                    .foregroundStyle(Color.black)
                    .onTapGesture {
                        authService.logout()
                    }
            }
        }
        .fullScreenCover(isPresented: $isShowingScanner, onDismiss: {
            showToast = true
        }) {
            screenFactory.scannerView()
                .background(Color.clear)
        }
        .toast(isPresenting: $showToast, duration: 1.3){

            // `.alert` is the default displayMode
            AlertToast(type: .complete(.green), title: "Бонусы начислены на ваш счёт")
            
            //Choose .hud to toast alert from the top of the screen
            //AlertToast(displayMode: .hud, type: .regular, title: "Message Sent!")
        }
        .hostingControllerSetup { viewController in }
    }
    
    
}
