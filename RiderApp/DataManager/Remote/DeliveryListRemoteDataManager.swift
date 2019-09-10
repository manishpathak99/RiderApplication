//
//  DeliveryListRemoteDataManager.swift
//  RiderApp
//
//  Created by MANISH PATHAK on 9/9/19.
//

import Alamofire
import AlamofireObjectMapper

class DeliveryListRemoteDataManager: DeliveryListRemoteDataManagerInputProtocol {
    var remoteRequestHandler: DeliveryListRemoteDataManagerOutputProtocol?
    var isAPICallInProgress: Bool?
    
    func retrieveDeliveryList(offset: Int, limit: Int) {
        isAPICallInProgress = true
        let endpointWithParam = getURL(offset, limit)
        print(endpointWithParam)
        AF.request(endpointWithParam, method: .get)
            .validate()
            .responseArray(completionHandler: { (response: DataResponse<[DeliveryModel]>) in
                self.isAPICallInProgress = false
                switch response.result {
                case .success(let deliveries):
                    self.remoteRequestHandler?.onRetrieved(deliveries: deliveries)
                    
                case .failure:
                    self.remoteRequestHandler?.onError()
                }
            })
    }
    
    private func getURL(_ offset: Int, _ limit: Int) -> String {
        return Endpoints.Deliveries.fetch.url.appendingFormat("?offset=%02d&limit=%02d", offset, limit)
    }
}
