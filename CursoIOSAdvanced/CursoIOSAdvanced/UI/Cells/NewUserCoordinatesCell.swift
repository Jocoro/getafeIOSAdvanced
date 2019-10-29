//
//  NewUserCoordinatesCell.swift
//  CursoIOSAdvanced
//
//  Created by Dev2 on 24/10/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import UIKit
import MapKit

class NewUserCoordinatesCell: UITableViewCell, MKMapViewDelegate {
    
    @IBOutlet weak var latitudeLabel : UILabel!
    @IBOutlet weak var longitudeLabel : UILabel!
    @IBOutlet weak var latitude : UITextField!
    @IBOutlet weak var longitude : UITextField!
    @IBOutlet weak var map : MKMapView!
    
    
    
    static let cellIdentifier = String(describing: NewUserCoordinatesCell.self)
    static let cellHeight: CGFloat = 300
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        map.delegate = self
        map.configureShadows()
        map.layer.cornerRadius = 8.0
        map.isScrollEnabled = false
        latitude.delegate = self
        longitude.delegate = self
        
    }
    override func prepareForReuse() {
        
        self.map.removeAnnotations(map.annotations)
        self.map.removeOverlays(map.overlays)
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func configureMap(latitude: Double, longitude: Double){
        
        
        let location = CLLocationCoordinate2D(latitude: latitude,
                                              longitude: longitude)
        
        // Cuanto más alto, menos zoom
        let span = MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        let region = MKCoordinateRegion(center: location, span: span)
        map.setRegion(region, animated: true)
        
        
        
        
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        // Make sure we are rendering a polyline.
        guard let polyline = overlay as? MKPolyline else {
            return MKOverlayRenderer()
        }
        
        // Create a specialized polyline renderer and set the polyline properties.
        let polylineRenderer = MKPolylineRenderer(overlay: polyline)
        polylineRenderer.strokeColor = .black
        polylineRenderer.lineWidth = 2
        return polylineRenderer
    }
}
extension NewUserCoordinatesCell : UITextFieldDelegate {
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let latString = latitude.text, let lat = Double(latString) else{
            latitude.text = "0"
            
            return
        }
        guard let longString = longitude.text, let long = Double(longString) else {
            longitude.text = "0"
            return
        }
        switch (lat, long){
        case (-90...90, -180...180):
            configureMap(latitude: lat, longitude: long)
        case (_, -180...180):
            latitude.text = "0"
            latitudeLabel.text = "Valid range: -90...90"
        case (-90...90, _):
            longitude.text = "0"
             longitudeLabel.text = "Valid range: -180...180"
        default:
            latitude.text = "0"
            latitudeLabel.text = "Valid range: -90...90"
            longitude.text = "0"
             longitudeLabel.text = "Valid range: -180...180"
        }
        
    }
    
    
}
