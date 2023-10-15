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
    
    var body: some View {
        NavigationView {
            if (!loginSuccess) {
                VStack {
                    TextField("Enter email", text: $email)
                    SecureField("Enter password", text: $password)
                    Button(action: {
                        login()
                    }, label: {
                        Text("Sign in")
                            .padding()
                    })
                    if loginFailed {
                        Text("Login attempt failed")
                            .foregroundColor(.red)
                    }
                    
                }
                .padding()
                .padding(.horizontal, 20)
                .navigationTitle("Demo")
            }
            else {
                HomeView()
            }
        }
    }
    
    func login() {
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
    @Environment(\.colorScheme) var colorScheme

    
    
    var body : some View {
        NavigationStack {
            VStack {
                if let asset = NSDataAsset(name: content) {
                  let data = asset.data
                    if (isGIF(data: data)) {
                        AnimatedImageView(data: data)
                            .scaledToFit()
                    }
                    else {
                        Image(uiImage: UIImage(data: data)!)
                            .scaledToFit()
                    }
                }
            }.navigationTitle($title)
        }
    }
}


struct HomeView: View {
    var body: some View {
        TabView {
            CustomNavigationView(title: "Home", content: "festive_twerk")
                    .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            CustomNavigationView(title: "Tab 1", content: "gif_1")
                .tabItem {
                    Label("Tab 1", systemImage: "star.fill")
                }
            
            CustomNavigationView(title: "Tab 2", content: "gif_2")
                .tabItem {
                    Label("Tab 2", systemImage: "bell.fill")
                }
            
            CustomNavigationView(title: "Tab 3", content: "gif_3")
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
     
            
        }.accentColor(.red)
    }
}





#Preview {
    ContentView()
}
