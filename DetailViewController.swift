//
//  DetailViewController.swift
//  GetCar
//
//  Created by Michael Nathaniel on 9/26/20.
//  Copyright © 2020 Binary Origin. All rights reserved.
//

import UIKit
import VisionKit

class DetailViewController: UIViewController {

  @IBOutlet weak var carImageView: UIImageView!
  @IBOutlet weak var headlineLabel: UILabel!
  @IBOutlet weak var carNameLabel: UILabel!
  @IBOutlet weak var carMilesLabel: UILabel!
  @IBOutlet weak var locationLabel: UILabel!
  @IBOutlet weak var notesLabel: UILabel!
  @IBOutlet weak var carInitialPriceLabel: UILabel!
  @IBOutlet weak var transferFeeLabel: UILabel!
  @IBOutlet weak var carFinalPriceTopView: UIView!
  @IBOutlet weak var carFinalPriceLabel: UILabel!
  @IBOutlet weak var carFinalPriceLabelTop: UILabel!
  @IBOutlet weak var pricingView: UIView!
  @IBOutlet weak var bookNowButton: UIButton!
  @IBOutlet weak var transferFeeDescLabel: UILabel!
  
  var menuVC:MenuViewController?
  var selectedCar:Car?
  var isSecondScan = false
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
        
    carImageView.image = UIImage(named: selectedCar!.image)
    carNameLabel.text = selectedCar!.name
    headlineLabel.text = selectedCar!.headline
    carMilesLabel.text = "\(selectedCar!.miles) miles driven"
    carInitialPriceLabel.text = "$\(AssistantManager.convertIntToString(int: selectedCar!.finalPrice))"
    carFinalPriceLabelTop.text = "$\(AssistantManager.convertIntToString(int:selectedCar!.finalPrice))"
    transferFeeLabel.text = "$\(AssistantManager.convertIntToString(int:Int(selectedCar!.storeDistance)*18))"
    transferFeeDescLabel.text = "Transfer Fee (\(selectedCar!.storeDistance)mi x $18)"
    carFinalPriceLabel.text = "$\(AssistantManager.convertIntToString(int: selectedCar!.finalPrice+Int(selectedCar!.storeDistance)*18))"
    self.locationLabel.text = "Located at \(selectedCar!.store) (\(selectedCar!.storeDistance)mi)"
    
    if selectedCar!.name == "2019 Mercedes C-Class" {
      self.notesLabel.text = "Rear-Wheel Drive, 4 owners, 7-speed automatic, 21 MPG, V8, Gasoline, Silver"
    } else if selectedCar!.name == "2020 Tesla Model S" {
      self.notesLabel.text = "All-Wheel Drive, Electric, Full Self Driving, Electric, Midnight Silver Metallic"
    } else {
      self.notesLabel.text = "All-Wheel Drive, 2 Owners, 3-speed automatic, 18 MPG, Gasoline, Pearl Off-White"
    }
    
    pricingView.backgroundColor = UIColor.white
    pricingView.dropShadow(color: UIColor.lightGray, opacity: 0.9, offSet: CGSize(width: 0.8, height: 0.8), radius: 8, scale: true)
    pricingView.layer.cornerRadius = 15
    
    carFinalPriceTopView.backgroundColor = UIColor.white
    carFinalPriceTopView.dropShadow(color: UIColor.lightGray, opacity: 0.9, offSet: CGSize(width: 0.8, height: 0.8), radius: 8, scale: true)
    carFinalPriceTopView.layer.cornerRadius = 19
    
    bookNowButton.dropShadow(color: UIColor.lightGray, opacity: 0.9, offSet: CGSize(width: 0.8, height: 0.8), radius: 8, scale: true)
    bookNowButton.layer.cornerRadius = 15
    
  }
  @IBAction func shareTapped(_ sender: Any) {
    let activityVC = UIActivityViewController(activityItems: ["www.carmax.com/car/19322306"], applicationActivities: nil)
           activityVC.popoverPresentationController?.sourceView = self.view
           self.present(activityVC, animated: true, completion: nil)
  
  }
  @IBAction func bookNow(_ sender: Any) {

    let alert = UIAlertController(title: "Verification Required", message: "Verify your drivers license to proceed with the purchase", preferredStyle: .alert)
       
       let okAction = UIAlertAction(title: "Scan now", style: .default) { (action) in
         //TODO: Do this
        self.configureDocumentView()
       }
          
       let laterAction = UIAlertAction(title: "Verify in-store", style: .default) { (action) in
       }
      
       alert.addAction(okAction)
       alert.addAction(laterAction)
       
       self.present(alert, animated: true, completion: nil)
  }
  
  func configureDocumentView() {
    let scanningDocumentVC = VNDocumentCameraViewController()
    scanningDocumentVC.delegate = self
    self.present(scanningDocumentVC, animated: true, completion: nil)
  }
}

extension DetailViewController:VNDocumentCameraViewControllerDelegate {
  func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
    var fieldName = "NAME"
    for pageNumber in 0..<scan.pageCount {
      let image = scan.imageOfPage(at: pageNumber)
      print(image)
    }
    
    if self.isSecondScan == false {
      let alert1 = UIAlertController(title: "Oops", message: "Unable to read \(fieldName). Please retry.", preferredStyle: .alert)
      let laterAction = UIAlertAction(title: "Retry", style: .default) { (action) in
      }
      alert1.addAction(laterAction)
      controller.present(alert1, animated: true, completion: nil)
      self.isSecondScan = true
    } else {
      let alert2 = UIAlertController(title: "Confirm", message: "Confirm the following details: Name: Michael Winailan, Age: 19, ID: #19202", preferredStyle: .alert)
      let laterAction = UIAlertAction(title: "Retry", style: .default) { (action) in
      }
      
      let okAction = UIAlertAction(title: "Send & Verify", style: .default) { (action) in
        controller.dismiss(animated: true, completion: nil)
        self.menuVC!.isPurchased = true
        self.bookNowButton.setTitle("Ordered", for: .normal)
        self.bookNowButton.isEnabled = false
        self.bookNowButton.backgroundColor = .lightGray
      }
           
      alert2.addAction(laterAction)
      alert2.addAction(okAction)
      controller.present(alert2, animated: true, completion: nil)
    }
  }
}
