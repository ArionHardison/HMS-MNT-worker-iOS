//
//  Router.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 07/03/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import Foundation
import UIKit

var presenterObject :PresenterInputProtocol?

class Router: PresenterToRouterProtocol {
    static let main = UIStoryboard(name: "Main", bundle: Bundle.main)

    
    static func createModule()->(UIViewController){
        
        let mainPresenter : PresenterInputProtocol & InterectorToPresenterProtocol = Presenter()
        let mainInteractor : PresenterToInterectorProtocol & WebServiceToInteractor = Interactor()
        let mainRouter : PresenterToRouterProtocol = Router()
        let mainWebservice : WebServiceProtocol = Webservice()

        
        if let view : (PresenterOutputProtocol & UIViewController) = main.instantiateViewController(withIdentifier: Storyboard.Ids.HomeViewController) as? HomeViewController {
            
            mainPresenter.view = view
            view.presenter = mainPresenter
            presenterObject = view.presenter
            
        }
        
       
        mainPresenter.interactor = mainInteractor
        mainPresenter.router = mainRouter
        mainInteractor.presenter = mainPresenter
        mainInteractor.webService = mainWebservice
        mainWebservice.interactor = mainInteractor
        
        return retrieveUserData() ? {
            {
                let nav = UINavigationController(rootViewController: main.instantiateViewController(withIdentifier:  Storyboard.Ids.TabbarController))
                nav.isNavigationBarHidden = false
                return nav
                
            }()
            }() : {
                let nav = UINavigationController(rootViewController: main.instantiateViewController(withIdentifier:  Storyboard.Ids.LoginViewController))
                nav.isNavigationBarHidden = true
                return nav
            }()
    }
    
}
