//
//  ContentView.swift
//  SchroedingerAlarm
//
//  Created by Monique Golnik on 07.01.22.
//

import SwiftUI
import MapKit
import ActivityIndicatorView
import CoreLocationUI



struct ContentView: View {
    //WebserverContent
    @State var loading = true
    @State var showWebserver: Bool = false
    //Add Device Content
    @State var addDevice: Bool = false
    @State var car: String = ""
    @State var deviceID: String = ""
    //Home Content
    @State var lockBtn: Bool = false
    //GPS Content
    @State var showGPS: Bool = false
    @ObservedObject private var mapModel = MapModel() //wird immer neu erzeugt beim Aufruf, vielleicht besser State-Object

    
    var body: some View {
        TabView{

//Home Tab
NavigationView {
    VStack{
        Spacer()
        //Save-Btn
        Button(action: {self.lockBtn.toggle()
            //Server abfragen
            mapModel.loadData()
            }, label: {
                LockBtn(active: lockBtn)
                })
                .padding(.bottom)
                
        //Projektname
        CopyrightView()
        HStack{
            Spacer()
            }
        }
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
                    Text("Server Status")
                        .font(.system(size: 18, weight: .light, design: .default))
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
                //TODO eingegebener Text soll gespeichert werden und im GPS-Tab übernommen werden
                TextField("Fahrzeugname", text: $car)
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
        Text("letzter Abruf:")
                .font(.system(size: 18, weight: .light, design: .default))
                .foregroundColor(Color(red: 100/255, green: 255/255, blue: 255/255))
        Text("09.02.2022 20:01:55")
            .font(.system(size: 18, weight: .light, design: .default))
            .foregroundColor(Color(red: 100/255, green: 255/255, blue: 255/255))
//Test ob ich an JSON Time komme
        ForEach(mapModel.locations, id: \.id) {location in
            Text(location.time)
                            .font(.system(size: 18, weight: .light, design: .default))
                            .foregroundColor(Color(red: 100/255, green: 255/255, blue: 255/255))
                            .padding(.bottom)
        }
        
        GeometryReader { proxy in
            Map(coordinateRegion: $mapModel.region,
                annotationItems: [mapModel.currentLocation])
            { place in
                MapAnnotation(coordinate: place.coordinate) {
                    VStack(spacing: 0) {
                      Text("VW T4")
                            .font(.system(size: 10, weight: .light, design: .default))
                      Image(systemName: "location.circle")
                        .font(.title)
                        .foregroundColor(.green)
                      Image(systemName: "arrowtriangle.down.fill")
                                .font(.caption)
                                .foregroundColor(.green)
                                .offset(x: 0, y: -5)
                    }
                }
                }
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
    .edgesIgnoringSafeArea([.top]))
    }
    .tabItem{
        Image(systemName: "location.fill")}
    }
}




struct CopyrightView: View {
    var body: some View {
            //Copyright
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


