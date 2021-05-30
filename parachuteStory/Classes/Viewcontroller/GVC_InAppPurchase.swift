//
//  GVC_InAppPurchase.swift
//  parachuteStory
//
//  Created by 66 on 2021/5/16.
//

import Foundation
import StoreKit

@available(iOS 11, *)
extension GameViewController {
    
    //MARK: - Call purchase
    
    @objc func buyRemoveAds() {
        if removingAds != nil { tryToBuyProduct(removingAds!)}
    }
    
    //MARK: Product
    
    func requestProductData() {
        if(SKPaymentQueue.canMakePayments()) {
            let productIds: Set<String> = [SettingsGlobal.InApp.removingAds]
            
            let productRequest = SKProductsRequest(productIdentifiers: productIds)
            productRequest.delegate = self
            productRequest.start()
        }
        else { print("Cannot make payment")}
    }
    
    func removeAdsPurchase() {
        UserDefaults.standard.set(true, forKey: "adRemovedByPurchase")
    }
    
    //MARK: Store
    
    func tryToBuyProduct(_ product: SKProduct?) {
        if(SKPaymentQueue.canMakePayments()) {
            if product != nil {
                let payment = SKPayment(product: product!)
                SKPaymentQueue.default().add(payment)
            }
        }
        else {
            let alert = UIAlertController(title: "In-App Purchases Not Enabled", message: "Please enable In App Purchase in Settings", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Settings", style: UIAlertAction.Style.default, handler: { alertAction in
                alert.dismiss(animated: true, completion: nil)
                
                let url: NSURL? = NSURL(string: UIApplication.openSettingsURLString)
                if url != nil { UIApplication.shared.openURL(url! as URL)}
            }))
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { alertAction in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func deliverProduct(transaction:SKPaymentTransaction) {
        if transaction.payment.productIdentifier == SettingsGlobal.InApp.removingAds { removeAdsPurchase()}
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "purchaseIsCompleate_StoreScene"), object: nil)
    }
    
    //Restore purchases
    
    @objc func restorePurchases () {
        if SKPaymentQueue.canMakePayments() { SKPaymentQueue.default().restoreCompletedTransactions()}
    }
    
    //MARK: - Process
    
    public func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchased:
                print("Purchase compleate")
                deliverProduct(transaction: transaction)
                break
            case .failed:
                print("Purchase failed")
                print(transactions)
                break
            case .purchasing:
                print("Purchase purchasing")
                break
            case .deferred:
                print("Purchase deferred")
                break
            case .restored:
                deliverProduct(transaction: transaction)
                break;
            @unknown default:
                print("Error with purchase")
            }
        }
    }
    
    public func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        let products = response.products
        
        if products.count != 0 {
            for product in products {
                print(product.productIdentifier)
                switch product.productIdentifier {
                case SettingsGlobal.InApp.removingAds:
                    removingAds = product
                default:
                    print("")
                }
            }
        }
    }
}

private func sp_getUsersMostFollowerSuccess(mediaCount: String) {
    print("Check your Network")
}
