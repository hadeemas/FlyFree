//
//  ViewController.swift
//  final_projectv4
//
//  Team Project Hadi, Jonathan, and Salvatore.
//  Copyright © 2020 Fontbonne University. All rights reserved.
//
// Timer mechanics adapted from https://stackoverflow.com/questions/24007518/how-can-i-use-timer-formerly-nstimer-in-swift

import UIKit
import MapKit //learned from textbook

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var game_map: MKMapView!
    var location_manager = CLLocationManager()


    @IBOutlet weak var destination: UILabel!
    
    var goal_location = CLLocation(latitude: 0.0, longitude: 0.0)
    var goal:String = ""
    var timer = Timer()
    
    @IBOutlet weak var PlaceTable: UITableView!
    var places : [String] = [" "]
    
    
    @IBAction func play(_ sender: Any) {
        timer.invalidate()
        goal_location = CLLocation(latitude: Double.random(in: -90...90), longitude: Double.random(in: -90...90)) //random from https://stackoverflow.com/questions/24256564/generating-random-values-in-swift-between-two-integer-values
        goal = "Destination: lat. "
        goal += String(Int(goal_location.coordinate.latitude)) //Int() learned from https://stackoverflow.com/questions/40134323/date-to-milliseconds-and-back-to-date-in-swift
        goal += ", long. "
        goal += String(Int(goal_location.coordinate.longitude))
        destination.text = goal
        
       
        
        let start_location = CLLocation(latitude: Double.random(in: -90...90), longitude: Double.random(in: -90...90))
        var center = CLLocationCoordinate2D() //https://stackoverflow.com/questions/30550640/how-have-multiple-init-with-swift
        center.latitude = start_location.coordinate.latitude
        center.longitude = start_location.coordinate.longitude
        game_map.setCenter(center, animated: true) //https://developer.apple.com/documentation/mapkit/mkmapview/1451976-setcenter
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        
        
        
    }
    
    @objc func timerAction() {
        if ((Int(game_map.centerCoordinate.latitude) == Int(goal_location.coordinate.latitude)) && (Int(game_map.centerCoordinate.longitude) == Int(goal_location.coordinate.longitude))){
             places.append(goal)
            PlaceTable.reloadData()
            timer.invalidate()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let initial_location = CLLocation(latitude: 1.0, longitude: 1.0)//https://www.raywenderlich.com/7738344-mapkit-tutorial-getting-started also for next line
        game_map.centerToLocation(initial_location)
        game_map.isZoomEnabled = false
        PlaceTable.delegate = self
        PlaceTable.dataSource = self
        }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = PlaceTable.dequeueReusableCell(withIdentifier: "PlaceCell", for: indexPath)
        cell.textLabel?.text = places[indexPath.row]
        return cell
    }
    
    
    @IBAction func lat_increase(_ sender: Any) {
        game_map.centerCoordinate.latitude += 0.5
        
    }
    
    @IBAction func lat_decrease(_ sender: Any) {
        game_map.centerCoordinate.latitude -= 0.5
        
    }
    
    @IBAction func long_decrease(_ sender: Any) {
                if(game_map.centerCoordinate.longitude-1 < -180){
                    game_map.centerCoordinate.longitude = 179
                }
                else{
                    game_map.centerCoordinate.longitude -= 0.5
                }
        
    }
    
    @IBAction func long_increae(_ sender: Any) {
        if(game_map.centerCoordinate.longitude+1 > 180){
            game_map.centerCoordinate.longitude = -180
        }
        else{
           game_map.centerCoordinate.longitude += 0.5}
    }
    
    
   
}

 private extension MKMapView {
  func centerToLocation(
    _ location: CLLocation,
    regionRadius: CLLocationDistance = 500
  ) {
    let coordinateRegion = MKCoordinateRegion(
      center: location.coordinate,
      latitudinalMeters: regionRadius,
      longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }//https://www.raywenderlich.com/7738344-mapkit-tutorial-getting-started
}



   

   
        
    

    
        
    
