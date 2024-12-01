//
//  ClusteredMapView.swift
//  TrainStronger
//
//  Created by Tamás Bohács on 2024. 12. 01..
//

import SwiftUI
import MapKit

// Custom UIViewRepresentable to integrate MKMapView with clustering
struct ClusteredMapView: UIViewRepresentable {
    @Binding var region: MKCoordinateRegion
    var trainings: [Training]

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
        // Enable clustering by setting a reuse identifier with a clustering identifier
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)

        mapView.region = region
        updateAnnotations(mapView)

        return mapView
    }

    func updateUIView(_ mapView: MKMapView, context: Context) {
        mapView.setRegion(region, animated: true)
        updateAnnotations(mapView)
    }

    // Convert Training objects to annotations
    private func updateAnnotations(_ mapView: MKMapView) {
        mapView.removeAnnotations(mapView.annotations)  // Remove existing annotations

        let annotations = trainings.map { training -> MKPointAnnotation in
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: training.latitude, longitude: training.longitude)
            annotation.title = training.name
            return annotation
        }

        mapView.addAnnotations(annotations)  // Add new annotations
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: ClusteredMapView

        init(_ parent: ClusteredMapView) {
            self.parent = parent
        }

        // Handle annotation view rendering with clustering
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            guard !(annotation is MKUserLocation) else { return nil }

            // Dequeue the marker annotation view
            let marker = mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier, for: annotation) as! MKMarkerAnnotationView
            
            // Enable clustering for this marker by assigning a clustering identifier
            marker.clusteringIdentifier = "trainingCluster"
            
            return marker
        }
    }
}
