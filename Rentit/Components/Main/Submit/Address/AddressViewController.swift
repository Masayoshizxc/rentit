//
//  AddressViewController.swift
//  Rentit
//
//  Created Eldiiar on 29/11/22.
//

import UIKit
import GoogleMaps
import CoreLocation

struct ProductAddress {
    let country: String
    let city: String
    let street: String
}

protocol AddressProtocol {
    func sendData(_ address: ProductAddress)
}

class AddressViewController: BaseViewController {
    
    var coordinates =  CLLocationCoordinate2D(latitude: 42.866192, longitude: 74.626900)
    let place = GooglePlacesManager.shared
    var places = [Place]()
    var delegate: AddressProtocol? = nil
    let manager = CLLocationManager()
    var mapView = GMSMapView()
    var address = (ProductAddress(country: "", city: "", street: ""))
    
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.text = "Выберите расположение"
        label.font = R.font.commissionerMedium(size: 20)
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "magnifyingglass")
        imageView.tintColor = .black
        return imageView
    }()
    
    private lazy var searchBar: UITextField = {
        let search = UITextField()
        search.placeholder = "Найти район"
        search.backgroundColor = .white
        search.layer.borderWidth = 0.1
        search.layer.cornerRadius = 20
        search.layer.borderColor = R.color.grayish()?.cgColor
        search.autocorrectionType = .no
        search.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 54, height: 0))
        search.leftViewMode = .always
        search.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        search.rightViewMode = .always
        search.delegate = self
        return search
    }()
    
    private lazy var findButton: UIButton = {
        let button = UIButton()
        button.setTitle("Найти адрес на карте", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = R.font.commissionerMedium(size: 13)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(didTapFind), for: .touchUpInside)
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private var ui = AddressView()
    private let viewModel:AddressViewModelProtocol
    
    init(viewModel: AddressViewModelProtocol = AddressViewModel()) {
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
//        view = ui
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapDone))
        mapView.layer.cornerRadius = 10
        mapView.isMyLocationEnabled = true
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        setupSubviews()
        setupConstraints()
    }
    
    @objc func didTapDone() {
        if delegate != nil {
            delegate?.sendData(address)
            navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func didTapFind() {
        let vc = MapViewController()
        vc.delegate = self
        vc.coordinates = coordinates
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension AddressViewController: MapCoordinateProtocol {
    func sendCoordinates(_ coordinates: CLLocationCoordinate2D, address: ProductAddress) {
        mapView.clear()
        mapView.camera = GMSCameraPosition(latitude: coordinates.latitude, longitude: coordinates.longitude, zoom: 15)
        addPin(mapView, coordinates, "Product", "Product location", nil)
        self.address = address
    }
}

extension AddressViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            manager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            
            let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lon, zoom: 10)
            mapView.camera = camera
            
//            let marker = GMSMarker()
//            marker.position = CLLocationCoordinate2D(latitude: lat, longitude: lon)
//            marker.title = "Your current location"
//            marker.map = mapView
        }
        
    }
    
    func addPin(_ mapView: GMSMapView, _ position: CLLocationCoordinate2D, _ title: String, _ snippet: String, _ icon: UIImage?) {
        let marker = GMSMarker()
        marker.position = position
        marker.title = title
        marker.snippet = snippet
        marker.icon = icon
        marker.map = mapView
    }
    
//    private func reverseGeocodeCoordinate(_ coordinate: CLLocationCoordinate2D) {
//
//        // 1
//        let geocoder = GMSGeocoder()
//
//        // 2
//        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
//            guard let address = response?.firstResult(), let lines = address.lines else {
//                return
//            }
//
//            print(address)
//            // 3
//            print(lines.joined(separator: "\n"))
//            // 4
//            UIView.animate(withDuration: 0.25) {
//                self.view.layoutIfNeeded()
//            }
//        }
//    }

}

extension AddressViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = places[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        searchBar.text = places[indexPath.row].name
        place.resolveLocation(for: places[indexPath.row]) { result in
            switch result {
            case .success(let data):
                self.coordinates = data
                self.mapView.camera = GMSCameraPosition(latitude: data.latitude, longitude: data.longitude, zoom: 15)
                self.addPin(self.mapView, CLLocationCoordinate2D(latitude: data.latitude, longitude: data.longitude), self.places[indexPath.row].name, "Bla bla", nil)
            case .failure(let failure):
                print(failure)
            }
        }
    }
}

extension AddressViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        place.findPlaces(query: textField.text ?? "") { result in
            print(result)
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.places = data
                    self.tableView.reloadData()
                }
            case .failure(let failure):
                print(failure)
            }
            
        }
    }
}

extension AddressViewController {
    
    private func setupSubviews() {
        view.addSubviews(
            titleLabel,
            mapView,
            findButton,
            searchBar,
            tableView
        )
        searchBar.addSubview(imageView)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(108)
            make.left.right.equalToSuperview().inset(16)
        }
        
        mapView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(28)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(171)
        }
        
        findButton.snp.makeConstraints { make in
            make.bottom.equalTo(mapView).inset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(162)
            make.height.equalTo(35)
        }
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(mapView.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
        
        imageView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(18)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(20)
            make.left.right.bottom.equalToSuperview()
        }
    }
}
