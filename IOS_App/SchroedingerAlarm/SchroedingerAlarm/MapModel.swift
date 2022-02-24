//
//  MapModel.swift
//  SchroedingerAlarm
//
//  Created by Monique Golnik on 28.01.22.
//

//echte Daten:
//guard let url = URL(string: "http://retrorbit.spdns.de/provide_Data.php")


import Combine
import MapKit
var car: String = "VW T4"


//struct JSONData: Codable {
//    var locations: [Location]
//}

struct Location: Codable , Identifiable {
    var id = UUID()
    var longitude: Double
    var latitude: Double
    var time: String // Date bzw String
}

//Mockdaten
struct Place: Identifiable {
    let id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
}


class MapModel: ObservableObject {
    var locations: [Location] = []
    
    var region: MKCoordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 52.54050502510506, longitude: 13.605319312514066),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
         {
        willSet {
            self.objectWillChange.send()
        }
    }
    
    var currentLocation =
    Place(name: car, coordinate: CLLocationCoordinate2D(
        latitude: 52.54050502510506, longitude: 13.605319312514066))

 

    
    
    
    func loadData() {
        guard let url = URL(string: "http://retrorbit.spdns.de/provide_Data.php") else {fatalError("Invalid URL")}
        let urlRequest = URLRequest(url: url)
        let dataTask = URLSession.shared.dataTask(with: urlRequest) {
            (data, response, error) in
            if let error = error {
                print("Request fehlgeschlagen: ", error)
                return
            }
            guard let response = response as? HTTPURLResponse else {
                return
            }
            if response.statusCode == 200 {
                guard let data = data else {
                    return
                }
                DispatchQueue.main.async {
                    do {
                        let str = String(decoding: data, as: UTF8.self)
                        print(str)
                        let decodedLocations = try JSONDecoder().decode([Location].self, from: data)
                        self.locations = decodedLocations
                    } catch let error {
                        print("Error beim Decoding: ", error)
                    }
                }
            }

        }
        dataTask.resume()

//ende loadData()
        }
//ende MapModel
}
