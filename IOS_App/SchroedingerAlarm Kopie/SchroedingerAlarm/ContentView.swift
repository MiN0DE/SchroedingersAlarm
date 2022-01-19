//
//  ContentView.swift
//  SchroedingerAlarm
//
//  Created by Monique Golnik on 07.01.22.
//

import SwiftUI

struct ContentView: View {
    
    @State var showWebserver: Bool = false
    @State var showGPS: Bool = false
    
    var body: some View {
        TabView{
//Erster Tab
        NavigationView {
        
            VStack{
                Spacer()
                HelloView()
            
                HStack{
                    Spacer()
                }
            }
        .navigationTitle("")
        .navigationBarItems(trailing:
                                Button(action: { showWebserver.toggle()},
                                       label: {Image(systemName: "network.badge.shield.half.filled")
                                       .foregroundColor(.green)
                                       }))
//Hintergrund
        .background(Image("city")
        .resizable()
        .scaledToFill()
        .clipped()
        .edgesIgnoringSafeArea([.top])
        )
                
        }
        .sheet(isPresented: $showWebserver, content: {
            ZStack{
                Color.secondary
                Text("Webserver Status")
            }
        })
    .tabItem {
        Image(systemName: "house.fill")
    }
            
//GPS Tab
            Text("Platzhalter für GPS Daten / Karte")
                .tabItem{
                    Image(systemName: "location.fill")
                }
    }
}




struct HelloView: View {
    var body: some View {
            Text("Willkommen")
             .font(Font.headline)
             .foregroundColor(.init(red: 0, green: 255, blue: 255))
             .padding()
    }
}


//Vorschau Funktion
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
}
