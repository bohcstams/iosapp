//
//  LocationObserver.swift
//  TrainStronger
//
//  Created by Tamás Bohács on 2024. 12. 01..
//

import Foundation
import MapKit

protocol LocationObserver : AnyObject {
    func updateLocation(_ location: CLLocation)
}
