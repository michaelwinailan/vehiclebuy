//
//  AssistantManager.swift
//  GetCar
//
//  Created by Michael Nathaniel on 9/26/20.
//  Copyright © 2020 Binary Origin. All rights reserved.
//

import UIKit

class AssistantManager: NSObject {
  static func createCars() -> [Car] {
    var cars:[Car] = [Car]()
        
    var car2:Car = Car(name: "2018 Tesla Model 3", store: "CarMax Pleasanton, CA", image: "model3.jpg", headline: "POPULAR MODEL", miles: 19238, storeDistance: 39.0, transferFee: 350, finalPrice: 33940)
    cars.append(car2)
    
    var car3:Car = Car(name: "2019 BMW 3 Series", store: "CarMax Colma, CA", image: "3series.jpg", headline: "NEWLY AVAILABLE", miles: 62938, storeDistance: 13.0, transferFee: 120, finalPrice: 41327)
    cars.append(car3)
    
    var car4:Car = Car(name: "2019 Cadillac Escalade", store: "CarMax Colma, CA", image: "escalade.jpg", headline: "GREAT DEAL", miles: 16039, storeDistance: 13.0, transferFee: 120, finalPrice: 73190)
    cars.append(car4)
    
    var car5:Car = Car(name: "2017 Porsche Panamera", store: "CarMax Pleasanton, CA", image: "panamera.jpg", headline: "NEWLY AVAILABLE", miles: 20301, storeDistance: 39.0, transferFee: 350, finalPrice: 57390)
    cars.append(car5)
    
    var car6:Car = Car(name: "2018 Mercedes E-Class", store: "CarMax Fairfield, CA", image: "eclass.jpg", headline: "GREAT DEAL", miles: 48304, storeDistance: 44.0, transferFee: 850, finalPrice: 49940)
    cars.append(car6)
    
    var car7:Car = Car(name: "2020 Tesla Model S", store: "CarMax San Jose, CA", image: "models.jpg", headline: "NEWLY AVAILABLE", miles: 72239, storeDistance: 54.0, transferFee: 550, finalPrice: 69990)
    cars.append(car7)
    
    var car8:Car = Car(name: "2017 Honda Accord", store: "CarMax San Jose, CA", image: "accord.jpg", headline: "POPULAR MODEL", miles: 62938, storeDistance: 54.0, transferFee: 550, finalPrice: 21940)
    cars.append(car8)
  
    var car1:Car = Car(name: "2019 Mercedes C-Class", store: "CarMax Colma, CA", image: "cclass.jpg", headline: "NEWLY AVAILABLE", miles: 62938, storeDistance: 13.0, transferFee: 120, finalPrice: 49940)
    cars.append(car1)
  
    return cars
  }
  
  static func createStores() -> [Store] {
    var stores:[Store] = [Store]()
    return stores
  }
  
  static func convertIntToString(int: Int) -> String {
      
      let convertedInt = NSNumber(value: int)
      
      let formatter = NumberFormatter()
      formatter.numberStyle = .currency
      formatter.currencySymbol = ""
      formatter.maximumFractionDigits = 0
      formatter.minimumFractionDigits = 0
    
      let formattedStr = formatter.string(from: convertedInt)!
      return formattedStr
  }
}
