//
//  TrainingsViewModel.swift
//  TrainStronger
//
//  Created by Tamás Bohács on 2024. 12. 01..
//

import Foundation
import CoreLocation

class TrainingsViewModel:ObservableObject{
    @Published var date = Date.now
    var locationManager = LocationManager()
    var location : CLLocation?
    
    init(){
        locationManager.locationObserver = self
        locationManager.startLocationManager()
    }
    
    func addTraining(training : Training){
        locationManager.startLocationManager()
        training.latitude = location?.coordinate.latitude ?? 0.0
        training.longitude = location?.coordinate.longitude ?? 0.0
        Task{
            await TrainingManager.shared.storeTraining(training: training)
        }
    }
    
    func deleteTraining(_ training : Training){
        Task{
            await TrainingManager.shared.deleteTraining(training: training)
        }
    }
}

extension TrainingsViewModel : LocationObserver {
    func updateLocation(_ location: CLLocation) {
        self.location = location;
    }
}
