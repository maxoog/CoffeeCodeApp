import SwiftUI
import Core

struct LoginView: View {
    @StateObject var viewModel: LoginViewModel
    @State var isSmall = UIScreen.main.bounds.height < 750
    
    var body: some View {
        
        NavigationView {
            ZStack {
                VStack {
                    VStack {
                        Text("Войдите, чтобы продолжить")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding()
                        
                        Image("logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding()
                        
                        Text("На ваш телефон в\(String.nbsp)течение нескольких секунд придёт 6-значный\(String.nbsp)код")
                            .font(isSmall ? .none : .title2)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding()
                        
                        // Mobile Number Field
                        HStack {
                            VStack(alignment: .leading, spacing: 6) {
                                Text("Номер телефона")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                
                                Text("+ \(viewModel.getCountryCode()) \(viewModel.phNo)")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                            }
                            
                            Spacer(minLength: 0)
                            
                            NavigationLink(destination: Verification(loginData: viewModel), isActive: $viewModel.gotoVerify) {
                                
                                Text("")
                                    .hidden()
                            }
                            
                            Button(action: viewModel.sendCode, label: {
                                Text("Далее")
                                    .foregroundColor(.black)
                                    .padding(.vertical, 18)
                                    .padding(.horizontal, 38)
                                    .background(Color("yellow"))
                                    .cornerRadius(15)
                            })
                            .disabled(viewModel.phNo == "")
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(20)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: -5)
                    }
                    .frame(height: UIScreen.main.bounds.height / 1.8)
                    .background(Color.white)
                    .cornerRadius(20)
                    
                    // Custom Number Pad
                    CustomNumberPad(value: $viewModel.phNo, ifVerify: false)
                }
                .background(Color("bg").ignoresSafeArea(.all, edges: .bottom))
                
                if viewModel.error {
                    AlertView(msg: viewModel.errorMsg, show: $viewModel.error)
                }
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

