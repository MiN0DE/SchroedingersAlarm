//
//  ContentView.swift
//  SchroedingerAlarm
//
//  Created by Monique Golnik on 07.01.22.
//

import SwiftUI
import MapKit
import ActivityIndicatorView


struct ContentView: View {
    @State var loading = true
    @State var showWebserver: Bool = false
    @State var showGPS: Bool = false
    
//hardcoded Koordinaten - TODO!
    @State var region = MKCoordinateRegion(
center: CLLocationCoordinate2D(
        latitude: 52.54050502510506, longitude: 13.605319312514066),
span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    
    var body: some View {
        TabView{

//Home Tab
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
                VStack{
                Text("Webserver Status")
                    ActivityIndicatorView(isVisible: $loading,
                                          type: .growingCircle)
                        .foregroundColor(.green)
                        .frame(width: 100, height: 100, alignment: .center)
                }
            }
        })
    .tabItem {
        Image(systemName: "house.fill")
    }
            
//GPS Tab
            NavigationView{
                VStack{
                    Map(coordinateRegion: $region)
                }
                //Hintergrund
                        .background(Image("city")
                        .resizable()
                        .scaledToFill()
                        .clipped()
                        .edgesIgnoringSafeArea([.top])
                        )
            }
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
