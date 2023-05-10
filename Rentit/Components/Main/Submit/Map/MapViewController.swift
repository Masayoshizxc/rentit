//
//  MapViewController.swift
//  Rentit
//
//  Created Eldiiar on 29/11/22.
//

import UIKit
import GoogleMaps
import CoreLocation

protocol MapCoordinateProtocol {
    func sendCoordinates(_ coordinates: CLLocationCoordinate2D, address: ProductAddress)
}

class MapViewController: BaseViewController {
    
    var mapView = GMSMapView()
    var coordinates =  CLLocationCoordinate2D(latitude: 42.866192, longitude: 74.626900)
    var address = (ProductAddress(country: "", city: "", street: ""))
    let manager = CLLocationManager()
    var delegate: MapCoordinateProtocol? = nil
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "mappin")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var label : UILabel = {
        let label = UILabel()
        label.backgroundColor = .gray
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var ui = MapView()
    private let viewModel:MapViewModelProtocol
    
    init(viewModel: MapViewModelProtocol = MapViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Новое объявление"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapDone))
//        view = ui
        manager.delegate = self
        setUpCoordinates()
//        manager.requestWhenInUseAuthorization()
//        manager.startUpdatingLocation()
        
        setupSubviews()
        setupConstraints()
    }
    
    func setUpCoordinates() {
        let lat = coordinates.latitude
        let lon = coordinates.longitude
        
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lon, zoom: 15)
        let size = view.frame.size
        mapView = GMSMapView.map(withFrame: CGRect(x: 0, y: topBarHeight, width: size.width, height: size.height - topBarHeight), camera: camera)
        mapView.delegate = self
        view.addSubview(mapView)
        
        mapView.addSubview(imageView)
        mapView.addSubview(label)

        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 108)
        ])
    }
    
    @objc func didTapDone() {
        if delegate != nil {
            delegate?.sendCoordinates(coordinates, address: address)
            navigationController?.popViewController(animated: true)
        }
    }
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            manager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude

            let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lon, zoom: 12.0)
            mapView.camera = camera
        }
        
    }
    
    private func reverseGeocodeCoordinate(_ coordinate: CLLocationCoordinate2D) {
        
        // 1
        let geocoder = GMSGeocoder()
        
        // 2
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            guard let address = response?.firstResult(), let lines = address.lines else {
                return
            }
            
            self.coordinates = CLLocationCoordinate2D(latitude: address.coordinate.latitude, longitude: address.coordinate.longitude)
            self.address = ProductAddress(country: address.country ?? "", city: address.locality ?? "", street: address.thoroughfare ?? "")
            print(address)
            // 3
            print(lines.joined(separator: "\n"))
            self.label.text = lines.joined(separator: "\n")
            // 4
            UIView.animate(withDuration: 0.25) {
                self.view.layoutIfNeeded()
            }
        }
    }

}

// MARK: - GMSMapViewDelegate
extension MapViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
      reverseGeocodeCoordinate(position.target)
    }
}


extension MapViewController {
    
    private func setupSubviews() {
        
    }
    
    private func setupConstraints() {
        
    }
}
