//
//  MapViewController.swift
//  asbappios
//
//  Created by David McAllister on 3/19/19.
//  Copyright © 2019 Programming Club. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var schoolMapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        schoolMapView.delegate = self
        
        let location = CLLocation.init(latitude: 37.3364, longitude: -122.0490)
        
        let regionRadius: CLLocationDistance = 150
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius * 2.0, longitudinalMeters: regionRadius * 2.0)
        schoolMapView.setRegion(coordinateRegion, animated: true)
        
        
        let anno = MKPointAnnotation();
        anno.coordinate = location.coordinate;
        anno.title = "Homestead High 🔥"
        let pinView = MKAnnotationView.init(annotation: anno, reuseIdentifier: "NewPin")
        
        //                    self.mapView.addAnnotation(pinView)
        self.schoolMapView.addAnnotation(anno);
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    

}


extension MapViewController: MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let pin = view.annotation as? MKPointAnnotation
        
        
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "MyPin"
        
        
        if annotation is MKUserLocation {
            return nil
        }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            let annoView = MKMarkerAnnotationView.init(annotation: annotation, reuseIdentifier: "annoView")
          
            annoView.glyphImage = #imageLiteral(resourceName: "stand")
            let fromServerTitle = "JV Boys Basketball"
            
            annoView.titleVisibility = .adaptive
            return annoView
            
        } else
        {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
    
    
    
}
