//
//  MapCell.swift
//  CursoIOSAdvanced
//
//  Created by Dev2 on 16/10/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import UIKit
import MapKit

class MapCell: UITableViewCell, MKMapViewDelegate {

     static let cellIdentifier = String(describing: MapCell.self)
    static let cellHeight: CGFloat = 200
    
    @IBOutlet weak var viewInCell: UIView!
    @IBOutlet weak var mapInCell: MKMapView!
   
    var madrid: MKPointAnnotation{
        let madrid = MKPointAnnotation()
        madrid.coordinate = CLLocationCoordinate2D(latitude: 40.416775, longitude: -3.703790)
        madrid.title = "Madrid"
        return madrid
    }
    var newYork: MKPointAnnotation {
         let newYork = MKPointAnnotation()
                  newYork.coordinate = CLLocationCoordinate2D(latitude: 40.730610, longitude: -73.935242)
                  newYork.title = "New York"
                  return newYork
    }
    var moscow: MKPointAnnotation{
        let moscow = MKPointAnnotation()
        moscow.coordinate = CLLocationCoordinate2D(latitude: 55.751244, longitude: 37.618423)
        moscow.title = "Moscow"
        return moscow
    }
    var toronto: MKPointAnnotation{
        let toronto = MKPointAnnotation()
        toronto.coordinate = CLLocationCoordinate2D(latitude: 43.7001100, longitude: -79.4163000)
        toronto.title = "Toronto"
        return toronto
    }
    var juneau: MKPointAnnotation{
         let juneau = MKPointAnnotation()
               juneau.coordinate = CLLocationCoordinate2D(latitude: 58.305801, longitude: -134.433304)
               juneau.title = "Juneau"
               return juneau
    }
    var sidney: MKPointAnnotation{
         let sidney = MKPointAnnotation()
               sidney.coordinate = CLLocationCoordinate2D(latitude: -33.865143, longitude: 151.209900)
               sidney.title = "Sidney"
               return sidney
    }
    var capeTown: MKPointAnnotation{
         let capeTown = MKPointAnnotation()
               capeTown.coordinate = CLLocationCoordinate2D(latitude: -33.9258400, longitude: 18.4232200)
               capeTown.title = "Cape Town"
               return capeTown
    }
    var antarctica: MKPointAnnotation{
        let antarctica = MKPointAnnotation()
        antarctica.coordinate = CLLocationCoordinate2D(latitude: -75.2509766, longitude: -0.071389)
        antarctica.title = "Antartica"
        return antarctica
    }
    var mexicoCity: MKPointAnnotation{
           let mexicoCity = MKPointAnnotation()
           mexicoCity.coordinate = CLLocationCoordinate2D(latitude: 19.432608, longitude: -99.133209)
           mexicoCity.title = "Mexico City"
           return mexicoCity
       }
    var auckland: MKPointAnnotation{
        let auckland = MKPointAnnotation()
        auckland.coordinate = CLLocationCoordinate2D(latitude: -36.848461, longitude: 174.763336)
        auckland.title = "Auckland"
        return auckland
    }
    var jayapura: MKPointAnnotation{
        let jayapura = MKPointAnnotation()
        jayapura.coordinate = CLLocationCoordinate2D(latitude: -2.53371, longitude: 140.71813)
        jayapura.title = "Jayapura"
        return jayapura
    }
    var locations: [MKPointAnnotation]{
        return [madrid, newYork, moscow, toronto, juneau, sidney, capeTown, antarctica, mexicoCity, auckland, jayapura]
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        mapInCell.delegate = self
        viewInCell.configureShadows()
        viewInCell.layer.cornerRadius = 8.0
    }
    override func prepareForReuse() {

        self.mapInCell.removeAnnotations(mapInCell.annotations)
        self.mapInCell.removeOverlays(mapInCell.overlays)
       
          }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(latitude: String? = nil, longitude: String? = nil){
        
        guard let latitude = latitude, let longitude = longitude, let latitudeCenter = Double(latitude),
        let longitudeCenter = Double(longitude) else {
            return
        }
        let location = CLLocationCoordinate2D(latitude: latitudeCenter,
                longitude: longitudeCenter)
            
            // Cuanto más alto, menos zoom
        let span = MKCoordinateSpan(latitudeDelta: 100, longitudeDelta: 100)
            let region = MKCoordinateRegion(center: location, span: span)
                mapInCell.setRegion(region, animated: true)
        let position = MKPointAnnotation()
        position.coordinate = CLLocationCoordinate2D(latitude: latitudeCenter, longitude: longitudeCenter)
        position.title = "Position"
       
       
        // Add marker `hello` to the map.
        
        let referencePoint = closestPoint(to: position.coordinate)
        mapInCell.showAnnotations([ referencePoint, position], animated: true)
        let toClosestPoint = [referencePoint.coordinate, position.coordinate]
        mapInCell.addOverlay(MKPolyline(coordinates: toClosestPoint, count: toClosestPoint.count))
        mapInCell.isZoomEnabled = false
        mapInCell.isScrollEnabled = false
  
         
          }
    func closestPoint(to point: CLLocationCoordinate2D) -> MKPointAnnotation{
        return locations.sorted{MKMapPoint($0.coordinate).distance(to: MKMapPoint(point)) < MKMapPoint($1.coordinate).distance(to: MKMapPoint(point))}[0]
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

