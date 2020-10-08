import UIKit
import Flutter


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
  
    
    // payemnt
    let paymentChannel = FlutterMethodChannel(name: "com.env.pay/payemntMethod",
                                                 binaryMessenger: controller.binaryMessenger)
    let provider = OPPPaymentProvider(mode: OPPProviderMode.test)

    let checkoutSettings = OPPCheckoutSettings()

    // Set available payment brands for your shop
    checkoutSettings.paymentBrands = ["VISA", "DIRECTDEBIT_SEPA"]

    // Set shopper result URL
    checkoutSettings.shopperResultURL = "com.companyname.appname.payments://result"
    
    
    
    paymentChannel.setMethodCallHandler({
      (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      // Note: this method is invoked on the UI thread.
      // Handle battery messages.
     
     guard call.method == "getPaymentMetod" else {
       result(FlutterMethodNotImplemented)
       return
     }
        
        let checkoutProvider = OPPCheckoutProvider(paymentProvider: provider, checkoutID: call.arguments as! String, settings: checkoutSettings)
        
        checkoutProvider?.presentCheckout(forSubmittingTransactionCompletionHandler: { (transaction, error) in
            guard let transaction = transaction else {
                // Handle invalid transaction, check error
               result(FlutterError(code: "UNAVAILABLE ELSE",
               message: "Payemt info unavailable",
               details: nil))
                return
            }
            if transaction.type == .synchronous {
                // If a transaction is synchronous, just request the payment status
                // You can use transaction.resourcePath or just checkout ID to do it
                result(transaction.resourcePath)
            } else if transaction.type == .asynchronous {
                // The SDK opens transaction.redirectUrl in a browser
                // See 'Asynchronous Payments' guide for more details
                result(transaction.redirectURL?.absoluteString)
            } else {
                // Executed in case of failure of the transaction for any reason
                result(FlutterError(code: "UNAVAILABLE Else",
                                                                      message: "Payemt info unavailable",
                                                                      details: nil))
            }
        }, cancelHandler: {
            // Executed if the shopper closes the payment page prematurely
          result(FlutterError(code: "UNAVAILABLE Error",
                                                                message: "Payemt info unavailable",
                                                                details: nil))
        })
    })
    
    

    
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
      
    
}



