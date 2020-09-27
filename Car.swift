//
//  Car.swift
//  GetCar
//
//  Created by Michael Nathaniel on 9/26/20.
//  Copyright © 2020 Binary Origin. All rights reserved.
//

import UIKit

class Car: NSObject {
  var name:String = "Toyota Fortuner"
  var store:String = "123 Penn Street"
  var image:String = ""
  
  var headline:String = "NEWLY AVAILABLE"
  var miles:Int = 0
  var transferFee:Int = 0
  var finalPrice:Int = 0
  var storeDistance:Double = 0.0
  
  init(name: String, store: String, image: String, headline: String, miles: Int, storeDistance: Double, transferFee: Int, finalPrice: Int) {
    self.name = name
    self.store = store
    self.image = image
    self.headline = headline
    self.miles = miles
    self.storeDistance = storeDistance
    //self.transferFee = transferFee
    self.finalPrice = finalPrice
  }
}
