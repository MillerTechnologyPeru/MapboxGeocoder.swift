import UIKit
import MapKit
import CoreLocation
import MBGeocoder

let MapboxAccessToken = "pk.eyJ1IjoianVzdGluIiwiYSI6ImFqZFg3Q0UifQ.C44vLEurzqpLtKJXT6c20g"

class ViewController: UIViewController, MKMapViewDelegate {
    
    // MARK: -
    // MARK: Variables

    var mapView: MKMapView?
    var resultsLabel: UILabel?
//    var geocoder: CLGeocoder?
    var geocoder: MBGeocoder?
    
    // MARK: -
    // MARK: Setup

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView = MKMapView(frame: view.bounds)
        mapView!.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        mapView!.delegate = self
        view.addSubview(mapView!)
        
        resultsLabel = UILabel(frame: CGRect(x: 20, y: 20, width: 500, height: 30))
        resultsLabel!.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        resultsLabel!.userInteractionEnabled = false
        view.addSubview(resultsLabel!)
        
//        geocoder = CLGeocoder()
        geocoder = MBGeocoder(accessToken: MapboxAccessToken)
    }

    // MARK: -
    // MARK: MKMapViewDelegate

    func mapView(mapView: MKMapView!, regionWillChangeAnimated animated: Bool) {
        geocoder?.cancelGeocode()
    }
    
    func mapView(mapView: MKMapView!, regionDidChangeAnimated animated: Bool) {
        geocoder?.cancelGeocode()
        geocoder!.reverseGeocodeLocation(CLLocation(latitude: mapView!.centerCoordinate.latitude, longitude: mapView!.centerCoordinate.longitude)) { (results, error) in
            if error {
                NSLog("%@", error)
            } else if results.count > 0 {
//                self.resultsLabel!.text = (results[0] as CLPlacemark).name
                self.resultsLabel!.text = (results[0] as MBPlacemark).name
            } else {
                self.resultsLabel!.text = "No results"
            }
        }
    }

}
