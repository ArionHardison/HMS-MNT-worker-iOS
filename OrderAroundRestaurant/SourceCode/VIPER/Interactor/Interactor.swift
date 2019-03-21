import Foundation
import ObjectMapper

class Interactor {
    var presenter: InterectorToPresenterProtocol?
    var webService: WebServiceProtocol?
    
}

extension Interactor : PresenterToInterectorProtocol{
    func FetchingData<T: Mappable>(api: String, params: [String : Any], methodType: HttpType, modelClass: T.Type, token: Bool) {
        webService?.retrieve(api: api, params: params, imageData: nil, type:methodType , modelClass: modelClass, token: token, completion: nil)
    }
    func IMAGEPOSTfetchData<T: Mappable>(api: String, params: [String : Any],methodType: HttpType, imgData: [String : Data]?, imgName: String, modelClass: T.Type, token: Bool) {
        webService?.retrieve(api: api, params: params, imageData: imgData, type:methodType , modelClass: modelClass, token: token, completion: nil)
    }
    
}


extension Interactor : WebServiceToInteractor {
    func responseError(error: CustomError) {
        self.presenter?.dataError(error: error)
    }
    func responseSuccess<T: Mappable>(className:T.Type, responseDict:[String: Any], responseArray: [[String: Any]]){
        if(responseDict.isEmpty){  //Array
            let details = Mapper<T>().mapArray(JSONArray: responseArray)
            /* self.presenter?.DataFetchedArray(data: details, modelClass: className)*/
            self.presenter?.dataSuccess(dataArray: details, dataDict: nil, modelClass: className)
        }else{ //Dictionary:
            let details = Mapper<T>().map(JSONObject: responseDict)
            /* self.presenter?.DataFetchedArray(data: details, modelClass: className)*/
            self.presenter?.dataSuccess(dataArray: nil, dataDict: details, modelClass: className)
        }
        
    }
}
