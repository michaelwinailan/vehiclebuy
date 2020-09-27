//
//  MenuViewController.swift
//  GetCar
//
//  Created by Michael Nathaniel on 9/26/20.
//  Copyright © 2020 Binary Origin. All rights reserved.
//

import UIKit
import MapKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

  @IBOutlet weak var carTableView: UITableView!
  @IBOutlet weak var orderConfirmedView: UIView!
  @IBOutlet weak var orderConfirmedImageView: UIImageView!
  
  var locationManager = CLLocationManager()
  var localAppDatabase:AppDatabase?
  var selectedCar:Car?
  var isLocationEnabled:Bool = false
  var isPurchased:Bool = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.localAppDatabase = AppDatabase()
    self.localAppDatabase!.cars = AssistantManager.createCars()
    self.localAppDatabase!.stores = AssistantManager.createStores()
    
    self.carTableView.delegate = self
    self.carTableView.dataSource = self
    
    self.locationManager.requestWhenInUseAuthorization()
    
    if CLLocationManager.locationServicesEnabled() {
      locationManager.startUpdatingLocation()
    }
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
      self.isLocationEnabled = true
      self.carTableView.reloadData()
    }
    
    
    self.orderConfirmedView.layer.cornerRadius = 15
    self.orderConfirmedView.dropShadow(color: UIColor.lightGray, opacity: 0.9, offSet: CGSize(width: 0.8, height: 0.8), radius: 8, scale: true)
    self.orderConfirmedImageView.layer.cornerRadius = 8
    self.orderConfirmedView.alpha = 1
  }
  
  override func viewDidAppear(_ animated: Bool) {
    if isPurchased {
      UIView.animate(withDuration: 1.0, animations: {
        self.orderConfirmedView.alpha = 1
      })
    
      let alert3 = UIAlertController(title: "Great!", message: "Your order for \(self.selectedCar!.name) has been successfully placed! We will contact you shortly for further details.", preferredStyle: .alert)
      let okAction2 = UIAlertAction(title: "Cool!", style: .default) { (action) in}
      alert3.addAction(okAction2)
      self.present(alert3, animated: true, completion: nil)
    
    }
  }
    
  @IBAction func sortButtonTapped(_ sender: Any) {
    let alert = UIAlertController(title: "Sort", message: "Sort the following collection based on:", preferredStyle: .alert)
    
    let transferHiLoAction = UIAlertAction(title: "Transfer Fee: High to Low", style: .default) { (action) in
      var carsDatabase = self.localAppDatabase!.cars
      self.localAppDatabase!.cars = carsDatabase.sorted(by: {$0.storeDistance > $1.storeDistance})
      self.carTableView.reloadData()
    }
       
    let transferLoHiAction = UIAlertAction(title: "Transfer Fee: Low to High", style: .default) { (action) in
      var carsDatabase = self.localAppDatabase!.cars
      self.localAppDatabase!.cars = carsDatabase.sorted(by: {$0.storeDistance < $1.storeDistance})
      self.carTableView.reloadData()
    }
    
    let priceHiLoAction = UIAlertAction(title: "Price: High to Low", style: .default) { (action) in
    }
    
    let priceLoHiAction = UIAlertAction(title: "Price: Low to High", style: .default) { (action) in
    }
    
    let transferHiLoAction2 = UIAlertAction(title: "Mileage: High to Low", style: .default) { (action) in
    }
    
    let transferHiLoAction3 = UIAlertAction(title: "Mileage: Low to High", style: .default) { (action) in
    }
    
    alert.addAction(transferHiLoAction)
    alert.addAction(transferLoHiAction)
    alert.addAction(priceHiLoAction)
    alert.addAction(priceLoHiAction)
    alert.addAction(transferHiLoAction2)
    alert.addAction(transferHiLoAction3)
    
    self.present(alert, animated: true, completion: nil)
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return localAppDatabase!.cars.count
   }
   
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = carTableView.dequeueReusableCell(withIdentifier: "carReusableCell")!
      cell.selectionStyle = .none
      
      let currentCar = self.localAppDatabase!.cars[indexPath.row]
      
      let carImageView = cell.viewWithTag(1) as! UIImageView
      carImageView.image = UIImage(named: currentCar.image)
      carImageView.layer.cornerRadius = 7
      
      let carNameLabel = cell.viewWithTag(2) as! UILabel
      carNameLabel.text = currentCar.name
      
      let storeNameLabel = cell.viewWithTag(3) as! UILabel
      //TODO: change the miles based on location
      storeNameLabel.text = "\(currentCar.store) (--.-mi)"
          
      if self.isLocationEnabled {
        storeNameLabel.text = "\(currentCar.store) (\(currentCar.storeDistance)mi)"
      } else {
         storeNameLabel.text = "\(currentCar.store) (--.-mi)"
      }
      
      let milesLabel = cell.viewWithTag(4) as! UILabel
      milesLabel.text = "\(AssistantManager.convertIntToString(int: currentCar.miles)) miles"
    
      let transferLabel = cell.viewWithTag(5) as! UILabel
  
  
      if self.isLocationEnabled {
        transferLabel.text = "$\(AssistantManager.convertIntToString(int:Int(currentCar.storeDistance)*18)) transfer fee"
      } else {
        transferLabel.text = "$-- transfer fee"
      }
    
      let priceLabel = cell.viewWithTag(6) as! UILabel
      priceLabel.text = "$\(AssistantManager.convertIntToString(int:currentCar.finalPrice))"
      
      let view = cell.viewWithTag(7)!
      view.layer.cornerRadius = 14
      view.dropShadow(color: UIColor.lightGray, opacity: 0.9, offSet: CGSize(width: 0.8, height: 0.8), radius: 8, scale: true)
      
      let headerLabel = cell.viewWithTag(8) as! UILabel
      headerLabel.text = currentCar.headline
      if currentCar.headline == "POPULAR MODEL" {
          headerLabel.textColor = UIColor(red: 0, green: 0, blue: 0.5, alpha: 1)
      } else if currentCar.headline == "NEWLY AVAILABLE" {
        headerLabel.textColor = UIColor(red: 0.6, green: 0.2, blue: 0.2, alpha: 1)
      } else if currentCar.headline == "GREAT DEAL" {
        headerLabel.textColor = UIColor(red: 0, green: 0.5, blue: 0, alpha: 1)
      }
      
      return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      self.selectedCar = self.localAppDatabase!.cars[indexPath.row]
      self.performSegue(withIdentifier: "fromMenuToDetail", sender: self)
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return 154
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "fromMenuToDetail" {
      let detailVC = segue.destination as! DetailViewController
      detailVC.selectedCar = self.selectedCar!
      detailVC.menuVC = self
    }
  }
  @IBAction func orderedButton(_ sender: Any) {
    viewDidAppear(true)
  }
  
}

extension UIView {
  func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
    layer.masksToBounds = false
    layer.shadowColor = color.cgColor
    layer.shadowOpacity = opacity
    layer.shadowOffset = offSet
    layer.shadowRadius = radius

    layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    layer.shouldRasterize = true
    layer.rasterizationScale = scale ? UIScreen.main.scale : 1
  }
}
