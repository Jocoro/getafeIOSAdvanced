//
//  MapCell.swift
//  CursoIOSAdvanced
//
//  Created by Dev2 on 16/10/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import UIKit
import MapKit

class MapCell: UITableViewCell {

     static let cellIdentifier = String(describing: MapCell.self)
    
    @IBOutlet weak var mapInCell: MKMapView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(latitude: String? = nil, longitude: String? = nil){
        guard let latitudeCenter = latitude, let longitudeCenter = longitude, let doubleLatitude = Double(latitudeCenter),
        let doubleLongitude = Double(longitudeCenter) else {
            return
        }
        let location = CLLocationCoordinate2D(latitude: doubleLatitude,
                longitude: doubleLongitude)
            
            // 2
        let span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
            let region = MKCoordinateRegion(center: location, span: span)
                mapInCell.setRegion(region, animated: true)
         
         
          }
   
    
}
