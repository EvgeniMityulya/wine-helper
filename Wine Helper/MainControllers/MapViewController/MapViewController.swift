//
//  MapViewController.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 3/23/24.
//

import UIKit
import MapKit
import CoreLocation

protocol MapViewInput: AnyObject {
}

class MapViewController: UIViewController {
    
    var output: MapViewOutput?
    
    let locationManager = CLLocationManager()
    
    private var places: [PlaceAnnotation] = []
    
    var currentLocation = CLLocationCoordinate2D()
    let regionRadius: CLLocationDistance = 1000
    var markAnnotations = [MarkAnnotation]()
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.showsCompass = false
        return mapView
    }()
    
    private lazy var compass: MKCompassButton = {
        let compass = MKCompassButton(mapView: self.mapView)
        compass.translatesAutoresizingMaskIntoConstraints = false
        return compass
    }()
    
    private lazy var searchTextField: UISearchTextField = {
        let searchTextField = UISearchTextField()
        
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.delegate = self
        searchTextField.layer.cornerRadius = 10
        searchTextField.clipsToBounds = true
        searchTextField.backgroundColor = UIColor.white
        searchTextField.placeholder = "Search"
        searchTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        searchTextField.leftViewMode = .always
        searchTextField.returnKeyType = .go
        searchTextField.textColor = .black
        
        if let placeholder = searchTextField.placeholder {
                let attributes: [NSAttributedString.Key: Any] = [
                    .foregroundColor: UIColor.gray,
                    .font: UIFont.systemFont(ofSize: 16)
                ]
                searchTextField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: attributes)
            }
        return searchTextField
    }()
    
    
    private lazy var userLocationButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.image = SystemImage.compass.image?.applyingSymbolConfiguration(
                .init(pointSize: 30))
        configuration.cornerStyle = .medium
        configuration.baseForegroundColor = .locate
        configuration.baseBackgroundColor = .locate
        configuration.contentInsets = .zero
        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(locateButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc private func locateButtonTapped() {
        if let currentLocation = locationManager.location {
            let region = MKCoordinateRegion(center: currentLocation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
            self.mapView.setRegion(region, animated: true)
        }
    }
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupLocationManager()
    }
    
    private func setupLocationManager() {
        self.locationManager.delegate = self
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    private func initAnnotations() {
        let range: ClosedRange<Double> = 0...0.05
        for i in 1...5 {
            let randomLatitude = self.currentLocation.latitude + Double.random(in: range)
            let randomLongitude = self.currentLocation.longitude + Double.random(in: range)
            let annotation = MarkAnnotation(
                coordinate: CLLocationCoordinate2D(
                    latitude: randomLatitude,
                    longitude: randomLongitude
                ),
                title: "Винодельня \(i)")
            self.markAnnotations.append(annotation)
        }
    }
    
    private func addAnnotations() {
        self.markAnnotations.forEach { data in
            let markAnnotation = MKPointAnnotation()
            markAnnotation.coordinate = data.coordinate
            markAnnotation.title = data.title
            self.mapView.addAnnotation(markAnnotation)
        }
    }
}



extension MapViewController: MapViewInput {
    
}

extension MapViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let text = textField.text ?? ""
        
        if !text.isEmpty {
            textField.resignFirstResponder()
            self.findNearbyPlaces(by: text)
        }
        return true
    }
}

// MARK: - Map
extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation else { return }
        self.clearAllSelections()
        
        guard let selectionAnnotation = annotation as? PlaceAnnotation else { return }
        let placeAnnotation = self.places.first { $0.id == selectionAnnotation.id }
        placeAnnotation?.isSelected = true
        self.presentPlacesSheet(places: self.places)
        
    }
    
    //    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    //        return nil
    //    }
    //
    
    private func clearAllSelections() {
        self.places = self.places.map { place in
            place.isSelected = false
            return place
        }
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.initAnnotations()
        self.addAnnotations()
        self.locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.checkLocationAuthorization()
    }
    
    private func checkLocationAuthorization() {
        guard let location = self.locationManager.location else { return }
        
        switch self.locationManager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            let coordinateRegion = MKCoordinateRegion(
                center: location.coordinate,
                latitudinalMeters: regionRadius,
                longitudinalMeters: regionRadius
            )
            self.mapView.setRegion(coordinateRegion, animated: true)
            self.currentLocation = location.coordinate
        case .notDetermined, .restricted:
            print("Not determined or restricted")
        case .denied:
            print("Location Services has been denied")
        @unknown default:
            print("Unknown error.")
        }
    }
    
    private func presentPlacesSheet(places: [PlaceAnnotation]) {
        
        guard let userLocation = locationManager.location else { return }
        let placesTableViewController = PlacesTableViewController(userLocation: userLocation, places: places)
        placesTableViewController.modalPresentationStyle = .pageSheet
        
        if let sheet = placesTableViewController.sheetPresentationController {
            sheet.prefersGrabberVisible = true
            sheet.detents = [.medium(), .large()]
            present(placesTableViewController, animated: true)
        }
    }
    
    private func findNearbyPlaces(by query: String) {
        self.mapView.removeAnnotations(mapView.annotations)
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.region = mapView.region
        
        let search = MKLocalSearch(request: request)
        search.start { [weak self] response, error in
            guard let response = response, error == nil else { return }
            
            self?.places = response.mapItems.map(PlaceAnnotation.init)
            self?.places.forEach { place in
                self?.mapView.addAnnotation(place)
            }
            
            if let places = self?.places {
                self?.presentPlacesSheet(places: places)
            }
        }
    }
    
}

private extension MapViewController {
    func setupUI() {
        self.view.addSubview(
            self.mapView,
            self.searchTextField,
            self.userLocationButton,
            self.compass
        )
        
        NSLayoutConstraint.activate([
            self.mapView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            self.searchTextField.heightAnchor.constraint(equalToConstant: 44),
            self.searchTextField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.searchTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            self.searchTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15),
            
            self.userLocationButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            self.userLocationButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            self.userLocationButton.widthAnchor.constraint(equalToConstant: 50),
            self.userLocationButton.heightAnchor.constraint(equalToConstant: 50),
            
            self.compass.centerXAnchor.constraint(equalTo: self.userLocationButton.centerXAnchor),
            self.compass.bottomAnchor.constraint(equalTo: self.userLocationButton.topAnchor, constant: -5),
            //            self.compass.widthAnchor.constraint(equalToConstant: 50),
            //            self.compass.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}
