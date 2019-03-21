//
//  Presenter.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 07/03/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import Foundation
import ObjectMapper


class Presenter {
    var view: PresenterOutputProtocol?
    var interactor: PresenterToInterectorProtocol?
    var router: PresenterToRouterProtocol?
}

extension Presenter: PresenterInputProtocol {
    func GETPOST<T: Mappable>(api: String, params: [String : Any], methodType: HttpType, modelClass: T.Type, token: Bool){
        interactor?.FetchingData(api: api, params: params, methodType: methodType, modelClass: modelClass, token: token)
    }
    func IMAGEPOST<T: Mappable>(api: String, params: [String : Any], methodType: HttpType, imgData: [String : Data]?, imgName: String, modelClass: T.Type, token: Bool) {
        interactor?.IMAGEPOSTfetchData(api: api, params: params, methodType: methodType, imgData: imgData, imgName: imgName, modelClass: modelClass, token: token)
    }
}

extension Presenter: InterectorToPresenterProtocol{
    func dataError(error: CustomError) {
        view?.showError(error: error)
    }
    func dataSuccess(dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
        view?.showSuccess(dataArray: dataArray, dataDict: dataDict, modelClass: modelClass)
    }
    
    /* func DataFetchedArray(data: [Mappable], modelClass: Any) {
     view?.showArrayData(data: data, modelClass: modelClass)
     }
     func DataFetched(data: Mappable, modelClass: Any) {
     view?.showData(data: data, modelClass: modelClass)
     }*/
}

