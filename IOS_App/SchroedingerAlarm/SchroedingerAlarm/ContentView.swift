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
    
    @State var addDevice: Bool = false
    @State var car: String = ""
    @State var deviceID: String = ""
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
        //.navigationTitle("")
            .navigationBarItems(trailing:
                HStack{Button(action:{addDevice.toggle()}){
                            Image(systemName: "plus")
                            .foregroundColor(.white)}
                       Button(action: {showWebserver.toggle()},
                                label: {Image(systemName: "network.badge.shield.half.filled")
                                    .foregroundColor(.green)})})
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
                Color.black
                VStack{
                Spacer()
                Image("car2")
                    Text("Webserver Status")
                        .foregroundColor(.white)
                    ActivityIndicatorView(isVisible: $loading,
                                          type: .growingCircle)
                                            .foregroundColor(.green)
                                            .frame(width: 100, height: 100, alignment: .center)
                }
            }
        })
        .sheet(isPresented: $addDevice, content: {
            ZStack{
                Color.black
                
            VStack {
                Spacer()
                Image("car2")
                Text("Konfigurier mich!")
                    .foregroundColor(.white)
                TextField("Fahrezugname", text: $car)
                    .frame(width:300, height:45)
                    .background(Color(.white))
                    .font(Font.system(size: 16))
                    .multilineTextAlignment(.center)
                    .cornerRadius(22)
                TextField("GeräteID", text: $deviceID)
                    .frame(width:300, height:45)
                    .background(Color(.white))
                    .font(Font.system(size: 16))
                    .multilineTextAlignment(.center)
                    .cornerRadius(22)
                Button(action: {
                    addDevice.toggle()
                }) {
                    Text("Los geht´s!")
                        .padding(13)
                        .frame(width: 150, height: 45, alignment: .center)
                        .foregroundColor(.white)
                        .background(.secondary)
                        .cornerRadius(22)
                        
                }
                }
            }
        })
        
    .tabItem {
        Image(systemName: "house.fill")
    }
            
//GPS Tab
            NavigationView{
                VStack{
                    GeometryReader { proxy in
                    Map(coordinateRegion: $region)
                            .frame(width: proxy.size.width,
                                   height: proxy.size.height,
                                   alignment: .center)
                    }
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
            Text("Schrödingers Alarm©")
            .font(.system(size: 18, weight: .light, design: .default))
             .foregroundColor(Color(red: 100/255, green: 255/255, blue: 255/255))
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
