//
//  MapViewController.swift
//  CarCinema
//
//  Created by MacBook Pro on 17.12.2020.
//

import UIKit
import YandexMapsMobile

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: YMKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.mapWindow.map.move(
                with: YMKCameraPosition.init(target: YMKPoint(latitude: 44.976478, longitude: 34.149348), zoom: 15, azimuth: 0, tilt: 0),
                animationType: YMKAnimation(type: YMKAnimationType.smooth, duration: 5),
                cameraCallback: nil)    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
