//
//  ContentView.swift
//  Bingo
//
//  Created by Johny on 15/08/23.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            Button {
                signOut()
            } label: {
                Text("Sign Out")
                    .foregroundColor(.yellow)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.black)
                    }
            }

        }
        .padding()
    }
    
    func signOut() {
        let auth = Auth.auth()
        do {
            try auth.signOut()
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
