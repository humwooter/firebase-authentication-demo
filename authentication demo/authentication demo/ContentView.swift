//
//  ContentView.swift
//  authentication demo
//
//  Created by Katyayani G. Raman on 10/15/23.
//
import SwiftUI
import FirebaseAuth
import FLAnimatedImage


func isGIF(data: Data) -> Bool {
    return data.prefix(6) == Data([0x47, 0x49, 0x46, 0x38, 0x37, 0x61]) || data.prefix(6) == Data([0x47, 0x49, 0x46, 0x38, 0x39, 0x61])
}

struct ContentView: View {
    
    @State var email = ""
    @State var password = ""
    @State var loginSuccess = false
    @State var loginFailed = false
    @State var isLoading = false

    
    var body: some View {
        NavigationView {
            if (!loginSuccess) {
                VStack(spacing: 25) {
                    Spacer()
                    TextField("Enter email", text: $email)
                    SecureField("Enter password", text: $password)
                    ZStack {
                           Button(action: {
                               login()
                           }, label: {
                               Text("Sign in")
                                   .padding(10)
                                   .foregroundColor(.white)
                                   .background(Color.cyan)
                                   .cornerRadius(30)
                           })
                           if isLoading {
                               ProgressView()
                           }
                       }
                    if loginFailed {
                        Text("Login attempt failed")
                            .foregroundColor(.red)
                    }
                    Spacer()
                    Spacer()
                    
                }
                .padding()
                .padding(.horizontal, 20)
                .navigationTitle("Demo")
            }
            else {
                HomeView(email: $email)
            }
        }
    }
    
    func login() {
        isLoading = true
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let _ = error {
                self.loginFailed = true
            } else {
                self.loginSuccess = true
            }
        }
    }
}

struct CustomNavigationView: View {
    @State var title: String
    @State var content: String
    @Binding var email: String
    @Environment(\.colorScheme) var colorScheme

    
    
    var body : some View {
        NavigationStack {
            Form {
                if (title == "Settings") {
                    Section(header: Text("Email")) {
                        Text("\(email)")
                    }
                }
                if let asset = NSDataAsset(name: content) {
                  let data = asset.data
                    Section {
                        if (isGIF(data: data)) {
                            AnimatedImageView(data: data)
                                .scaledToFit()
                        }
                        else {
                            Image(uiImage: UIImage(data: data)!)
                                .scaledToFit()
                        }
                    }
                }
            }.navigationTitle($title)
        }
    }
}


struct HomeView: View {
    @Binding var email: String
    var body: some View {
        TabView {
            CustomNavigationView(title: "Home", content: "festive_twerk", email: $email)
                    .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            CustomNavigationView(title: "Tab 1", content: "gif_1", email: $email)
                .tabItem {
                    Label("Tab 1", systemImage: "star.fill")
                }
            
            CustomNavigationView(title: "Tab 2", content: "gif_2", email: $email)
                .tabItem {
                    Label("Tab 2", systemImage: "bell.fill")
                }
            
            CustomNavigationView(title: "Settings", content: "gif_3", email: $email)
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
     
            
        }.accentColor(.cyan)
    }
}





#Preview {
    ContentView()
}
