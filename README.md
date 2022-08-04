#  IDentity SDK
  
<br />

## Introduction
  

This guide introduces the IDentity iOS SDK within the IDmission product suite. Developers, project managers and QA testers should reference this guide for information on configuration and use of the IDentity SDK on the iOS platform. We recommend reviewing the entire implementation guide to fully understand the IDentity SDK functionality and its respective capabilities.
  
This guide details processes and procedures for embedding the IDentity SDK into your host application and utilizing its current features. For additional IDentity SDK support, please contact our Customer Support team at support@idmission.com.

<br />
  
## Overview and Key Features

The IDmission IDentity SDK is a comprehensive toolkit that enables the use of any combination of factors of identity to complete digital transformation goals. The goal of the IDentity SDK is to offer seamless integration into an existing digital paradigm where the end-to-end customer experience is still owned and managed in-house.

<br />

## Quick Links to get started with IDentity SDK for iOS

<br />

**SDK Flavours Download Links -** As per your requirement you can  downloads the below `IDentitySDK` / `IDentityMediumSDK` / `IDentityLiteSDK`.
- [Download IDentitySDK](https://drive.google.com/file/d/1pnIMJT8TeCoiQJjkwmztoUroVM8cHPUn/view?usp=sharing)
- [Download IDentityMediumSDK](https://drive.google.com/file/d/1iBY2AKyIWTsVLv2-Q1TaZ1LsjvTT0Wh5/view?usp=sharing)
- [Download IDentityLiteSDK](https://drive.google.com/file/d/1ns5Vjr7jSLs30s2lXXwdruNpM8xpegIU/view?usp=sharing)

<br />

**SDK Flavours Supported Features -**  



| Feature/Flavours |  **Identity SDK**  |  **IdentityMedium SDK**  |  **IdentityLite SDK**  |
|:------|:------:|:------:|:------:|
|**1. Document Detect**|On Device|On Device|On Device|
|**2. Rotate, crop etc.**|On Device|On Server|On Server|
|**3. Document Realness**|On Device|On Server|On Server|
|**4. Document Classification**|On Device|On Server|On Server|
|**5. MRZ/Barcode reading**|On Device|On Device|On Server|
|**6. OCR from front**|On Server|On Server|On Server|
|**7. Face detect**|On Device|On Device|On Device|
|**8. Liveness detect**|On Device|On Device|On Device|
|**9. Detect hats and glasses**|On Device|On Server|On Server|
  
<br />

**SDK Documentation -** Here is the link to the Identity Proofing SDK Documentation.
- [SDK Documentation](http://54.254.213.10:4567/iOS-IDentity-SDK/Classes/IDentitySDK.html) 
  
<br />

**Sample Apps -** Here are the links to the Sample apps on IDmission GitHub Repository
- [IDentitySDK Sample App](https://github.com/Idmission-LLC/SDK2Sample)
- [IDentityMediumSDK Sample App](https://github.com/Idmission-LLC/MediumSDK2Sample)
- [IDentityLiteSDK Sample App](https://github.com/Idmission-LLC/LiteSDK2Sample)

<br />

**Main Features -** Following are the main features supported in SDKs are:

- [Live face Check](#1-live-face-check)
- [ID Validation](#2-id-validation)
- [ID Validation and face match](#3-id-validation-and-face-match)
- [Enroll Biometric](#4-enroll-biometric)
- [Enroll Customer with ID validation](#5-enroll-customer-with-id-validation)
- [Customer Verification](#6-customer-verification)
- [Customer Biometric Verification](#7-customer-biometric-verification)
- [Autofill](#8-autofill)  
  

Additional functions are also detailed in the [SDK Documentation](http://54.254.213.10:4567/iOS-IDentity-SDK/Classes/IDentitySDK.html)

  

Note: When using the IDentity SDK, you do not need to create a request for XML; it is automatically generated by the SDK based on the function that you are calling

<br />

## Getting Started

1) Please contact to sales@idmission.com for Login Credentials, which you will later pass to the SDK.  

2) Add [CocoaPods](https://cocoapods.org/) pod file to your project using `pod init` command.  

3) As per SDK flavour which you choose to integrate, add the following dependencies to your Pod file:  

- **IDentitySDK**  *dependencies*.  
    
```swift
pod 'IDentitySDK2.0'
pod 'TensorFlowLiteSwift'
pod 'GoogleMLKit/TextRecognition'
pod 'GoogleMLKit/FaceDetection'
pod 'GoogleMLKit/ImageLabeling'
pod 'ZXingObjC'
pod 'GZIP'
pod 'SSZipArchive'
```
    
- **IDentityMediumSDK**  *dependencies*.  
    
```swift
pod 'IDentityMediumSDK2.0'
pod 'TensorFlowLiteSwift'
pod 'GoogleMLKit/TextRecognition'
pod 'GoogleMLKit/FaceDetection'
pod 'ZXingObjC'
pod 'GZIP'
pod 'SSZipArchive'
```

- **IDentityLiteSDK**  *dependencies*. 

```swift
pod 'IDentityLiteSDK2.0'
pod 'TensorFlowLiteSwift'
pod 'GoogleMLKit/FaceDetection'
pod 'ZXingObjC'
pod 'GZIP'
pod 'SSZipArchive'
```

4) Optionally add the following `post_install` script (replacing `APP_TARGET` with the name of your app target) to the end of your `Podfile` to prevent [CocoaPods](https://cocoapods.org/) from statically-linking the above dependencies to your app binary, unnecessarily increasing the size of your app bundle:  

```swift
post_install do |installer|
    applicationTargets = [
    'Pods-APP_TARGET',
    ] 
    
    host_targets = installer.aggregate_targets.select { |aggregate_target|
    applicationTargets.include? aggregate_target.name
    }

    # We only want to remove pods from Application targets, not libraries
    host_targets.each do |host_target|
        host_target.xcconfigs.each do |config_name, config_file|
            puts "> Removing #{config_name} #{host_target.name} OTHER_LDFLAGS ..."
            pods = ['MLImage', 'MLKitCommon', 'MLKitFaceDetection', 'MLKitImageLabeling', 'MLKitImageLabelingCommon', 'MLKitObjectDetectionCommon','MLKitVision','MLKitVisionKit', 'TensorFlowLiteC', 'TensorFlowLiteTaskTextC']

            pods.each do |pod|
                 puts "- #{pod}"
                 config_file.frameworks.delete(pod)
            end
            xcconfig_path = host_target.xcconfig_path(config_name)
            config_file.save_as(xcconfig_path)
        end
    end
end
```  

5) Run `pod install` to install the dependencies.  

6) Add an [`NSCameraUsageDescription`](https://developer.apple.com/documentation/bundleresources/information_property_list/nscamerausagedescription) key to the app's `Info.plist` to allow camera access.  

<br />

## Usage


1) Initialize the SDK with your `LOGIN_ID`, `PASSWORD`, `MERCHANT_ID`, `TemplateModelBaseURL` & `APIBaseURL`:

- To integrate **IDentitySDK** import Following frameworks.  

```swift
//For IdentitySDK flavours import Following
import IDentitySDK_Swift
import IDCapture_Swift
import SelfieCapture_Swift
```
    
- To integrate **IDentityMediumSDK** import Following frameworks.  

```swift
//For `IdentityMediumSDK` flavours import Following Medium SDKs
import IDentityMediumSDK
import IDCaptureMedium
import SelfieCaptureMedium
```
    
- To integrate **IDentityLiteSDK** import Following frameworks.  

```swift
//For IdentityLiteSDK flavours import Following Lite SDKs
import IDentityLiteSDK
import IDCaptureLite
import SelfieCaptureLite
```
    
As per requirement once you importing above frameworks, you need to Call the following method.  

```swift
//Start SDK Initialization using following method.
let loginId = ""  // LOGIN_ID provided by IDmission
let password = "" // PASSWORD provided by IDmission
let merchantId = "" // MERCHANT_ID provided by IDmission

//Before Initialization of SDK pass the url values to following `IDentitySDK` static properties.
IDentitySDK.templateModelBaseURL = "https://" // URL provided by IDmission
IDentitySDK.apiBaseURL = "https://" // URL provided by IDmission

IDentitySDK.initializeSDK(loginId: loginId, password: password, merchantId: merchantId) { error in
    if let error = error {
        // Handle Error
    } else {
        // Success!
    }
}
```

Once the SDK has been initialized, the application can start capturing data using the various following static `IDentitySDK` methods.

<br />

## SDK Features

<br />

### 1) Live face Check.  

You can do Live face check using following method from a `UIViewController`. If successful, call `submit` to send the result to the server.

  -   <u>**IDentitySDK  /  IDentityMediumSDK  /  IDentityLiteSDK**</u> : For all flavours user need to use below API call for `Live Face Check`

```swift
// Start live face capture, presenting it from view controller

IDentitySDK.liveFaceCheck(from: self) { result in
    switch result {
        case .success(let liveFaceCheckResult):

            // submit the successful result to the server
            liveFaceCheckResult.submit { result in
                switch result {
                    case .success(let response):
                        // Review successful response from the server
                        print(response)
                    
                    case .failure(let error):
                        // Handle error
                        print(error.localizedDescription)
                }
            }

        case .failure(let error):
            // Handle error
            print(error.localizedDescription)
    }
}
```  
<br />

### 2) ID Validation.  

For `ID Validation` you need to use below respective methods of SDK Flavours with the default options from a  `UIViewController`. If successful, call  `submit`  to send the result to the server.

-   <u>**IDentitySDK**</u> : For `IdentitySDK` flavour user needs to use below API call for `ID Validation`.  

```swift
// For IDentitySDK : Start ID Validation with the default options, presenting it from view controller(self)

let options =  AdditionalCustomerWFlagCommonData()
IDentitySDK.idValidation(from: self, options: options) { result in
    switch result {
        case .success(let validateIdResult):

            // submit the successful result to the server 
            validateIdResult.submit { result, hostData in
                switch result {  
                    case .success(let response):  
                        // Review successful response from the server  
                        print(response)  
                        
                    case .failure(let error):  
                        // Handle error  
                        print(error.localizedDescription)  
                }  
            }
            
        case .failure(let error): 
            print(error.localizedDescription)
    }    
}
```  

  
-   <u>**IDentityMediumSDK  /  IDentityLiteSDK**</u> : For `IDentityMediumSDK  /  IDentityLiteSDK` flavours user can user either anyone below API call for `ID Validation`.  

```swift
// For IDentityMediumSDK / IDentityLiteSDK :  Start ID Validation using captureBack(true/false) values with the default options, presenting it from view controller(self)

let options = AdditionalCustomerWFlagCommonData()
IDentitySDK.idValidation(from: self, options: options, captureBack: captureBack) { result in
    switch result {
        case .success(let validateIdResult):

            // submit the successful result to the server
            validateIdResult.submit { result, hostData in
                switch result {
                    case .success(let response):
                        // Review successful response from the server
                        print(response)

                    case .failure(let error):
                        // Handle error
                        print(error.localizedDescription)
                }
            }

        case .failure(let error):
            // Handle error
            print(error.localizedDescription)
    }
}
```
  
OR
  
```swift
// For IDentityMediumSDK / IDentityLiteSDK : Start ID Validation using idType, idCountry, idState with the default options, presenting it from view controller(self)

let options = AdditionalCustomerWFlagCommonData()
IDentitySDK.idValidation(from: self, options: options, idType: idType, idCountry: idCountry, idState: idState) { result in
    switch result {
        case .success(let validateIdResult):

            // submit the successful result to the server
            validateIdResult.submit { result, hostData in
                switch result {
                    case .success(let response):
                        // Review successful response from the server
                        print(response)
                        
                    case .failure(let error):
                        // Handle error
                        print(error.localizedDescription)
                }
            }

        case .failure(let error):
            // Handle error
            print(error.localizedDescription)
    }
}
```
  
The `AdditionalCustomerWFlagCommonData` documentation contains information on the various capture options that can be set.  

<br />

### 3) ID Validation and face match.  

For `ID Validation and face match` you need to use below respective methods of SDK Flavours with the default options from a `UIViewController`. If successful, call `submit` to send the result to the server.

  -   <u>**IDentitySDK**</u> : For `IdentitySDK` flavour user needs to use below API call for `ID Validation and face match`. 

```swift
// For IDentitySDK : Start ID Validation and face match with the default options, presenting it from view controller(self)

let options =  AdditionalCustomerWFlagCommonData()
IDentitySDK.idValidationAndMatchFace(from: self, options: options) { result in
    switch result {
        case .success(let validateIdMatchFaceResult):

            // submit the successful result to the server 
            validateIdMatchFaceResult.submit { result, hostData in  
                switch result {  
                    case .success(let response):  
                        // Review successful response from the server  
                        print(response)  
                    case .failure(let error):  
                        // Handle error  
                        print(error.localizedDescription)  
                }  
            }
            
        case .failure(let error): 
            print(error.localizedDescription)
    }    
}
```  

-   <u>**IDentityMediumSDK  /  IDentityLiteSDK**</u> : For `IDentityMediumSDK  /  IDentityLiteSDK` flavours user can user either anyone below API call `ID Validation and face match`.

```swift
// For IDentityMediumSDK / IDentityLiteSDK : Start ID Validation and face match using captureBack(true/false) values with the default options, presenting it from view controller(self)

let options = AdditionalCustomerWFlagCommonData()
IDentitySDK.idValidationAndMatchFace(from: self, options: options, captureBack: captureBack) { result in
    switch result {
        case .success(let validateIdMatchFaceResult):

            // submit the successful result to the server
            validateIdMatchFaceResult.submit { result, hostData in
                switch result {
                    case .success(let response):
                        // Review successful response from the server
                        print(response)
                    
                    case .failure(let error):
                        // Handle error
                        print(error.localizedDescription)
                }
            }

        case .failure(let error):
            // Handle error
            print(error.localizedDescription)
    }
}
```
  
OR
  
```swift
// For IDentityMediumSDK / IDentityLiteSDK : Start ID Validation and face match using idType, idCountry, idState with the default options, presenting it from view controller(self)

let options = AdditionalCustomerWFlagCommonData()
IDentitySDK.idValidationAndMatchFace(from: self, options: options, idType: idType, idCountry: idCountry, idState: idState) { result in
    switch result {
        case .success(let validateIdMatchFaceResult):

            // submit the successful result to the server
            validateIdMatchFaceResult.submit { result, hostData in
                switch result {
                    case .success(let response):
                        // Review successful response from the server
                        print(response)
                        
                    case .failure(let error):
                        // Handle error
                        print(error.localizedDescription)
                }
            }

        case .failure(let error):
            // Handle error
            print(error.localizedDescription)
    }
}
```

The `AdditionalCustomerWFlagCommonData` documentation contains information on the various capture options that can be set.  

<br />

### 4) Enroll Biometric.  

For `Enroll Biometric` you need to use below method with personalData & & the default options from a  `UIViewController`. If successful, call `submit` to send the result to the server.  

  -   <u>**IDentitySDK  /  IDentityMediumSDK  /  IDentityLiteSDK**</u> : For all flavours user needs to use below API call method for `Enroll Biometric`.   

```swift
// Start customer enroll birometric with personalData & the default options, presenting it from view controller(self)

let personalData = PersonalCustomerCommonRequestData(uniqueNumber: uniqueNumber)
let options = AdditionalCustomerEnrollBiometricRequestData()
IDentitySDK.customerEnrollBiometrics(from: self, personalData: personalData, options: options) { result in
    switch result {
        case .success(let customerEnrollBiometricsResult):

            // submit the successful result to the server
            customerEnrollBiometricsResult.submit { result in
                switch result {
                    case .success(let response):
                        // Review successful response from the server
                        print(response)
                        
                    case .failure(let error):
                        // Handle error
                        print(error.localizedDescription)
                }
            }

        case .failure(let error):
            // Handle error
            print(error.localizedDescription)
    }
}
```

The `AdditionalCustomerEnrollBiometricRequestData` documentation contains information on the various capture options that can be set.  

<br />

### 5) Enroll Customer with ID validation.  

For `Enroll Customer with ID validation` you need to use below respective methods of SDK Flavours with personalData & the default options from a `UIViewController`. If successful, call `submit` to send the result to the server.

  -   <u>**IDentitySDK**</u> : For `IdentitySDK` flavour user needs to use below API call for `Enroll Customer with ID validation`.  

```swift
// For IDentityMediumSDK / IDentityLiteSDK  : Start Enroll Customer with ID validation with personalData & the default options, presenting it from view controller(self)

let personalData = PersonalCustomerCommonRequestData(uniqueNumber: uniqueNumber)
let options = AdditionalCustomerWFlagCommonData()
IDentitySDK.idValidationAndCustomerEnroll(from: self, personalData: personalData, options: options) { result in
    switch result {
        case .success(let customerEnrollResult):

            // submit the successful result to the server
            customerEnrollResult.submit { result, hostData in
                switch result {
                    case .success(let response):
                        // Review successful response from the server
                        print(response)
                        
                    case .failure(let error):
                        // Handle error
                        print(error.localizedDescription)
                }
            }

        case .failure(let error):
            // Handle error
            print(error.localizedDescription)
    }
}
```
  

-   <u>**IDentityMediumSDK  /  IDentityLiteSDK**</u> : For `IDentityMediumSDK  /  IDentityLiteSDK` flavours user can user either anyone below API call `Enroll Customer with ID validation`.

```swift
// For IDentityMediumSDK / IDentityLiteSDK  : Start Enroll Customer with ID validation using captureBack(true/false) values with personalData & the default options, presenting it from view controller(self)

let personalData = PersonalCustomerCommonRequestData(uniqueNumber: uniqueNumber)
let options = AdditionalCustomerWFlagCommonData()
IDentitySDK.idValidationAndCustomerEnroll(from: self, personalData: personalData, options: options, captureBack: captureBack) { result in
    switch result {
        case .success(let customerEnrollResult):

            // submit the successful result to the server
            customerEnrollResult.submit { result, hostData in
                switch result {
                    case .success(let response):
                        // Review successful response from the server
                        print(response)
                        
                    case .failure(let error):
                        // Handle error
                        print(error.localizedDescription)
                }
            }

        case .failure(let error):
            // Handle error
            print(error.localizedDescription)
    }
}
```

OR

```swift
// For IDentityMediumSDK / IDentityLiteSDK  : Start Enroll Customer with ID validation using idType, idCountry, idState with personalData & the default options, presenting it from view controller(self)

let personalData = PersonalCustomerCommonRequestData(uniqueNumber: uniqueNumber)
let options = AdditionalCustomerWFlagCommonData()
IDentitySDK.idValidationAndCustomerEnroll(from: self, personalData: personalData, options: options, idType: idType, idCountry: idCountry, idState: idState) { result in
    switch result {
        case .success(let customerEnrollResult):

            // submit the successful result to the server
            customerEnrollResult.submit { result, hostData in
                switch result {
                    case .success(let response):
                        // Review successful response from the server
                        print(response)
                        
                    case .failure(let error):
                        // Handle error
                        print(error.localizedDescription)
                }
            }

        case .failure(let error):
            // Handle error
            print(error.localizedDescription)
    }
}
```

The `AdditionalCustomerWFlagCommonData` documentation contains information on the various capture options that can be set.  

<br />

### 6) Customer Verification.  

For `Customer Verification` you need to use below method with personalData from a  `UIViewController`. If successful, call `submit` to send the result to the server.  

  -   <u>**IDentitySDK  /  IDentityMediumSDK  /  IDentityLiteSDK**</u> : For all flavours user needs to use below API call method for `Customer Verification Verification`.   

```swift
// Start Customer Verification with personalData, presenting it from view controller(self)

let personalData = PersonalCustomerVerifyData(uniqueNumber: uniqueNumber)
IDentitySDK.customerVerification(from: self, personalData: personalData) { result in  
    switch result {
        case .success(let customerVerificationResult):

            // submit the successful result to the server
            customerVerificationResult.submit { result in
                switch result {
                    case .success(let response):
                        // Review successful response from the server
                        print(response)
                        
                    case .failure(let error):
                        // Handle error
                        print(error.localizedDescription)
                }
            }

        case .failure(let error):
            // Handle error
            print(error.localizedDescription)
    }
}
```

The `AdditionalCustomerWFlagCommonData` documentation contains information on the various capture options that can be set.  

<br />

### 7) Customer Biometric Verification.  

For `Customer Biometric Verification` you need to use below method of from a  `UIViewController`. If successful, call `submit` to send the result to the server.  

  -   <u>**IDentitySDK  /  IDentityMediumSDK  /  IDentityLiteSDK**</u> : For all flavours user needs to use below API call method for `Customer Biometric Verification`. 
  
```swift
// start Customer Biometric Verification, presenting it from view controller(self)

IDentitySDK.identifyCustomer(from: self) { result in
    switch result {
        case .success(let customerIdentifyResult):

            // submit the successful result to the server
            customerIdentifyResult.submit { result in
                switch result {
                    case .success(let response):
                        // Review successful response from the server
                        print(response)
                        
                    case .failure(let error):
                        // Handle error
                        print(error.localizedDescription)
                }
            }

        case .failure(let error):
            // Handle error
            print(error.localizedDescription)
    }
}
```

<br />

### 8) Autofill.  

For `autofill` you need to use below method of from a  `UIViewController`. If successful, call `submit` to send the result to the server.  

  -   <u>**IDentitySDK  /  IDentityMediumSDK**</u> : For `IDentitySDK  /  IDentityMediumSDK` flavours user needs to use below API call method for `autofill`. 
  
```swift
// start autofill, presenting it from view controller(self)

IDentitySDK.autofill(from: self) { result in
    switch result {
        case .success(let autofillResult):

            // submit the successful result to the server
            autofillResult.submit { result in
                switch result {
                    case .success(let response):
                        // Review successful response from the server
                        print(response)
                        
                    case .failure(let error):
                        // Handle error
                        print(error.localizedDescription)
                }
            }

        case .failure(let error):
            // Handle error
            print(error.localizedDescription)
    }
}
```

<br />

## Optional Customizations

  
-   Before starting an ID Capture flow, optionally adjust the following  [IDCapture](https://demo-documentation.idmission.com/iOS-SDK-2/Classes/IDCapture.html)  static properties:  

```swift
//IDCapture Customization
IDCapture.options.frontRealnessThreshold = 0.5
IDCapture.options.backRealnessThreshold = 0.3
IDCapture.options.frontDocumentConfidence = 0.7
IDCapture.options.backDocumentConfidence = 0.7
IDCapture.options.lowerWidthThresholdTolerance = 0.4
IDCapture.options.upperWidthThresholdTolerance = 0.1
IDCapture.options.isDebugMode = true
IDCapture.options.enableInstructionScreen = true
IDCapture.options.enableRealId = true
IDCapture.options.uploadIdData = true
IDCapture.options.capture4K = true

//IDCapture Camera Screen UI Customization
IDCapture.strings.captureFront = "Capture Front Side"
IDCapture.strings.captureBack = "Capture Back Side"
IDCapture.strings.moveAway = "Move ID Away"
IDCapture.strings.moveCloser = "Move ID Closer"
IDCapture.strings.makeSurePhotoTextVisible = "Make Sure Photo & Text are Visible in ID"
IDCapture.strings.makeSureBarcodeVisible = "Make sure Barcode is visible"
IDCapture.strings.alignRectangle = "Align ID inside Rectangle"
IDCapture.strings.flipToBack = "Flip To Back side"
IDCapture.strings.tooMuchGlare = "Too Much Glare"
IDCapture.colors.successLabelBackgroundColor = .green
IDCapture.colors.errorLabelBackgroundColor = .red
IDCapture.colors.successLabelTextColor = .white
IDCapture.colors.errorLabelTextColor = .white
IDCapture.colors.backgroundColor = .clear
IDCapture.fonts.captureLabelFont = UIFont.boldSystemFont(ofSize: 14)
IDCapture.fonts.labelFont = UIFont.systemFont(ofSize: 14)
IDCapture.images.frontSilhouetteImage = UIImage(named: "IdFrontOverlay")
IDCapture.images.backSilhouetteImage = UIImage(named: "IdBackOverlay")
IDCapture.images.retryScreenImage = UIImage(named: "IdRetryImage")

//IDCapture Retry Screen UI Customization
IDCapture.strings.retryScreenText = "RealID not Detected. Please try again"
IDCapture.strings.retryButtonText = "Retry"
IDCapture.strings.cancelButtonText = "Cancel"
IDCapture.colors.retryScreenBackgroundColor = .white
IDCapture.colors.retryScreenLabelTextColor = .black
IDCapture.colors.retryScreenImageTintColor = .green
IDCapture.colors.retryScreenButtonTextColor = .green
IDCapture.colors.retryScreenButtonBackgroundColor = .clear
IDCapture.fonts.retryScreenLabelFont = UIFont.systemFont(ofSize: 16)
IDCapture.fonts.retryScreenButtonFont = UIFont.systemFont(ofSize: 14)

```

-   Before starting a Selfie Capture flow, optionally adjust the following  [SelfieCapture](https://demo-documentation.idmission.com/iOS-SDK-2/Classes/SelfieCapture.html)  static properties:  

```swift
//SelfieCapture Customization
SelfieCapture.options.minFaceWidth = 0.6
SelfieCapture.options.eyeOpenProbability = 0.4
SelfieCapture.options.minHeadEulerAngle = -10
SelfieCapture.options.maxHeadEulerAngle = 10
SelfieCapture.options.minRelativeNoseHeight = 0.48
SelfieCapture.options.maxRelativeNoseHeight = 0.67
SelfieCapture.options.labelsConfidenceThreshold = 0.79
SelfieCapture.options.faceMaskProbabilityThreshold = 0.79
SelfieCapture.options.liveFaceProbabilityThreshold = 0.9
SelfieCapture.options.consecutiveFakeFaceLimit = 10
SelfieCapture.options.lightIntensityThreshold = 0.05
SelfieCapture.options.isDebugMode = true
SelfieCapture.options.enableInstructionScreen = true
SelfieCapture.options.capture4K = false
SelfieCapture.options.uploadFaceData = true

//SelfieCapture Camera Screen UI Customization
SelfieCapture.strings.alignOval = "Align your face inside oval"
SelfieCapture.strings.moveAway = "Move ID Away"
SelfieCapture.strings.moveCloser = "Move ID Closer"
SelfieCapture.strings.leftEyeClosed = "Left eye are closed"
SelfieCapture.strings.rightEyeClosed = "right eye are closed"
SelfieCapture.strings.faceMaskDetected = "Face mask detected"
SelfieCapture.strings.glassesDetected = "Glasses Detected"
SelfieCapture.strings.removeHat = "hat Detected"
SelfieCapture.strings.fakeFace = "Fake face Detected"
SelfieCapture.strings.realFace = "real face Detected"
SelfieCapture.strings.straightenHead = "Make Sure your head is straight"
SelfieCapture.strings.moveFaceDown = "Move face Down"
SelfieCapture.strings.moveFaceUp = "Move face Up"
SelfieCapture.strings.moveFaceDown = "Move face Down"
SelfieCapture.strings.capturingFace = "Capturing Face"
SelfieCapture.strings.tooMuchLight = "Too much light around face"
SelfieCapture.colors.backgroundColor = .white
SelfieCapture.colors.successLabelBackgroundColor = .green
SelfieCapture.colors.errorLabelBackgroundColor = .red
SelfieCapture.colors.successLabelTextColor = .white
SelfieCapture.colors.errorLabelTextColor = .white
SelfieCapture.fonts.labelFont = UIFont.systemFont(ofSize: 14)
SelfieCapture.images.silhouetteImage = UIImage(named: "Selfiecapture")
SelfieCapture.images.retryScreenImage = UIImage(named: "SelfieRetryImage")

//SelfieCapture Retry Screen UI Customization
SelfieCapture.strings.retryScreenText = "Live face not Detected. Please try again"
SelfieCapture.strings.retryButtonText = "Retry"
SelfieCapture.strings.cancelButtonText = "Cancel"
SelfieCapture.colors.retryScreenBackgroundColor = .white
SelfieCapture.colors.retryScreenLabelTextColor = .black
SelfieCapture.colors.retryScreenImageTintColor = .blue
SelfieCapture.colors.retryScreenButtonTextColor = .blue
SelfieCapture.colors.retryScreenButtonBackgroundColor = .clear
SelfieCapture.fonts.retryScreenLabelFont = UIFont.systemFont(ofSize: 16)
SelfieCapture.fonts.retryScreenButtonFont = UIFont.systemFont(ofSize: 14)

```

## SDK Version History
  
### **v 9.3.1.50**
- Added properties to customize Images of SelfieCapture screen & Retry screen.
- Added properties to customize Images of IdCapture screen & Retry screen.

### **v 9.3.1.49**
- Autofill.
- Added SDK UI Customization.
- Instruction screens for selfie and ID capture.
- Replcae `.framework` file with `.xcframework` file which has frameworks for device as well as for simulator.

### **v 9.1.7.31**
- Live face Check
- ID Validation
- ID Validation and face match
- Enroll Biometric
- Enroll Customer with ID validation
- Customer Verification
- Customer Biometric Verification
