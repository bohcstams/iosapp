//
//  MapTabView.swift
//  TrainStronger
//
//  Created by Tamás Bohács on 2024. 12. 01..
//

import SwiftUI
import MapKit
import SwiftData

struct MapTabView: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 47.47329135396875, longitude: 19.05967702578184), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    @EnvironmentObject var viewModel : TrainingsViewModel
    @Query private var trainings: [Training]
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        ClusteredMapView(region: $region, trainings: trainings)
        .onAppear {
                    // Initialize the region when the view appears
                    let initialRegion = MKCoordinateRegion(
                        center: CLLocationCoordinate2D(latitude: viewModel.location?.coordinate.latitude ?? 47.47329135396875, longitude: viewModel.location?.coordinate.longitude ?? 19.05967702578184),
                        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
                    )
                    region = initialRegion
                }
    }
}

#Preview {
    MapTabView()
}
