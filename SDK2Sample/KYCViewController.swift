//
//  KYCViewController.swift
//  SDK2Sample
//
//  Created by Amol Deshmukh on 29/04/22.
//

import UIKit
import IDentitySDK_Swift
import SelfieCapture_Swift
import IDCapture_Swift

class KYCViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //Initialize SDK
    @IBAction func CompleteKYC(_ sender:Any) {
        
        // Start Enroll Customer with personalData & the default options, presenting it from view controller(self)
        let personalData = PersonalCustomerCommonRequestEnrollDataV3(uniqueNumber: "12345")
        let options = AdditionalCustomerWFlagCommonDataV3()
        IDentitySDK.idValidationAndCustomerEnroll(from: self, personalData: personalData, options: options) { result in
            switch result {
            case .success(let customerEnrollResult):
                
                //1. Show Client Side Extracted Data on View
                let resultForIdVerificationCustomView = ResultScreenFor50(frame: self.view.bounds, customerEnroll_Result: customerEnrollResult)
                resultForIdVerificationCustomView.delegate = self
                resultForIdVerificationCustomView.tag = 1
                self.view.addSubview(resultForIdVerificationCustomView)

                
            case .failure(let error):
                //5. Handle SDK Side Local API Error
                self.displayAlert(title: "Error", Message: error.localizedDescription)
            }
        }
        
    }
    
}

//MARK: - Done Button Delegate
extension KYCViewController : ResultScreenFor50Delegate {
    
    func doneButtonPressed() {
        if let viewWithTag = self.view.viewWithTag(1){
            viewWithTag.removeFromSuperview()
        }
    }
    
    func displayAlert(title : String, Message:String){
        let alert = UIAlertController(title: title, message: Message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }

}
