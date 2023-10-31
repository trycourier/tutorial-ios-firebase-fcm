//
//  ContentView.swift
//  Courier iOS Firebase
//
//  Created by Carter Rabasa on 10/23/23.
//

import SwiftUI
import Courier_iOS

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }.onAppear {
            
            Task {
                
                // Make sure your user is signed into Courier
                // This allows Courier to sync push notification tokens automatically
                try await Courier.shared.signIn(
                    accessToken: <COURIER_AUTH_TOKEN>,
                    userId: <COURIER_USER_ID>
                )

                // Shows a popup where your user can allow or deny push notifications
                // You should put this in a place that makes sense for your app
                // You cannot ask the user for push notification permissions again
                // If they deny, you will have to get them to open their device
                // settings to change this
                let status = try await Courier.requestNotificationPermission()
                print(status)
                
            }

        }
        .padding()
    }
}

#Preview {
    ContentView()
}
