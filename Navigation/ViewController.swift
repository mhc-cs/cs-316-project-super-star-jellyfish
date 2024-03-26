import UIKit
import MapboxNavigation
import MapboxMaps
import MapboxDirections
import MapboxCoreNavigation
 
class ViewController: UIViewController {
    var mapView: NavigationMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView = NavigationMapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(mapView)
        
        let origin = Waypoint(coordinate: LocationCoordinate2D(latitude: 37.33317700998446, longitude: -122.0086669921875), name: "Cupertino")
        let destination = Waypoint(coordinate: LocationCoordinate2D(latitude: 37.929575667562325, longitude: -122.57858276367186), name: "Mt. Tom")
        let routeOptions = NavigationRouteOptions(waypoints: [origin, destination])
        
        Directions.shared.calculate(routeOptions) { session, result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let response):
                self.mapView.showcase(response.routes ?? [])
                
                let navigationViewController = NavigationViewController(for: response, routeIndex: 0, routeOptions: routeOptions)
                self.present(navigationViewController, animated: true)
            }
        }
    }
}
