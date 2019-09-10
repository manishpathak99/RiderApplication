//
//  DeliveryDetailViewController.swift
//  RiderApp
//
//  Created by MANISH PATHAK on 9/6/19.
//

import UIKit
import MapKit

class DeliveryDetailViewController: UIViewController {
    var mapView: MKMapView!
    var destinationImageView: UIImageView!
    var destinationLabel: UILabel!
    var model: DeliveryModel!
    
    var presenter: DeliveryDetailPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoad()
        presenter?.setLocationDetail(model)
    }
    
    private func setupUI() {
        title = Localization.deliveryDetails
        view.backgroundColor = .white
        mapView = MKMapView(frame: .zero)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.delegate = self
        mapView.showsUserLocation = true
        view.addSubview(mapView)
        
        destinationImageView = UIImageView(frame: .zero)
        destinationImageView.translatesAutoresizingMaskIntoConstraints = false
        destinationImageView.contentMode = .scaleAspectFill
        destinationImageView.clipsToBounds = true
        view.addSubview(destinationImageView)
        
        destinationLabel = UILabel(frame: .zero)
        destinationLabel.numberOfLines = 0
        destinationLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(destinationLabel)
        
        addConstraints()
    }
    
    private func addConstraints() {
        guard let mapView = mapView, let destinationImageView = destinationImageView, let destinationLabel = destinationLabel else {
            return
        }
        
        mapView.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(100)
        }
        
        destinationImageView.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(view.snp.leading).offset(10)
            make.height.equalTo(80)
            make.width.equalTo(80)
            make.top.equalTo(mapView.snp.bottom).offset(10)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(10)
        }
        
        destinationLabel.snp.makeConstraints { (make) -> Void in
            make.trailing.equalTo(view.snp.trailing).inset(10)
            make.leading.equalTo(destinationImageView.snp.trailing).offset(10)
            make.top.equalTo(mapView.snp.bottom).offset(5)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(10)
        }
    }
}

extension DeliveryDetailViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let polineLineRenderer = MKPolylineRenderer(overlay: overlay)
        polineLineRenderer.strokeColor = Constants.AppUI.MapView.routeColor
        polineLineRenderer.lineWidth = Constants.AppUI.MapView.routeLineWidth
        return polineLineRenderer
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? CustomAnnotation else { return nil }
        var view: MKMarkerAnnotationView

        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: Constants.AppUI.MapView.markerIdentifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: Constants.AppUI.MapView.markerIdentifier)
            view.canShowCallout = true
            view.detailCalloutAccessoryView = UIView()
        }
        return view
    }

}

extension DeliveryDetailViewController: DeliveryDetailViewProtocol {
    
    func setLocationDetail(text: String, imageURL: URL?) {
        destinationLabel.text = text
        destinationImageView.kf.setImage(with: imageURL)
    }
    
    func placeDestinationPin() {
        let lat = model.location?.latitude ?? 0.0
        let long = model.location?.longitude ?? 0.0
        let destinationLocation = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let destinationPin = CustomAnnotation(title: model.location!.address, location: destinationLocation)
        mapView.addAnnotation(destinationPin)
        let viewRegion = MKCoordinateRegion(center: destinationLocation, latitudinalMeters: Constants.AppUI.MapView.routeVisibilityArea, longitudinalMeters: Constants.AppUI.MapView.routeVisibilityArea)
        mapView.setRegion(viewRegion, animated: true)
    }
}
