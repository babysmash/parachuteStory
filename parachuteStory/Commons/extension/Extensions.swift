//
//  Extensions.swift
//  parachuteStory
//
//  Created by 66 on 2021/5/18.
//

import Foundation
import UIKit
import WebKit

private struct TemporaryView {
    static let oc_lightBlackView: UIView = {
        let blackView = UIView(frame: .screenSize)
        blackView.backgroundColor = UIColor(white: 0, alpha: 0.1)
        return blackView
    }()
    
    static let oc_darkBlackView: UIView = {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        view.alpha = 0
        return view
    }()
    
    static let oc_activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.center.x = UIScreen.main.bounds.width/2
        activityIndicator.center.y = UIScreen.main.bounds.height/2
        return activityIndicator
    }()
    
    static let oc_hudLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: .screenWidth, height: 100))
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "OpenSans-Bold", size: 18)
        label.center.x = .screenWidth/2
        label.center.y = .screenHeight/2 + 50
        return label
    }()
}

private let downloadCache = NSCache<AnyObject, AnyObject>()

extension UIViewController {
    
    func oc_topMostController() -> UIViewController {
        var rootViewController = UIApplication.shared.keyWindow?.rootViewController
        
        while ((rootViewController?.presentedViewController) != nil) {
            rootViewController = rootViewController!.presentedViewController;
        }
        
        return rootViewController!;
    }
    
    func oc_showProgressHud(_ text: String) {
        DispatchQueue.main.async {
            TemporaryView.oc_hudLabel.text = text
            self.view.addSubview(TemporaryView.oc_hudLabel)
            
            UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseInOut, animations: {
                TemporaryView.oc_hudLabel.alpha = 1
                self.perform(#selector(self.oc_hideProgressHud), with: nil, afterDelay: 1.5)
            }) { finished in
            }
        }
    }
    
    @objc func oc_hideProgressHud() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseInOut, animations: {
                TemporaryView.oc_hudLabel.alpha = 0
            }) { finished in
                TemporaryView.oc_hudLabel.text = ""
                TemporaryView.oc_hudLabel.removeFromSuperview()
            }
        }
    }
    
    @objc func oc_showAlert(_ message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        DispatchQueue.main.async {
            self.oc_topMostController().present(alert, animated: true, completion: nil)
        }
    }
    
    func oc_showBlackView() {
        self.view.addSubview(TemporaryView.oc_darkBlackView)
        TemporaryView.oc_darkBlackView.alpha = 0
        
        TemporaryView.oc_hudLabel.removeFromSuperview()
        TemporaryView.oc_activityIndicator.removeFromSuperview()
        
        self.navigationItem.leftBarButtonItem?.isEnabled = false
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        
        UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseInOut, animations: {
            TemporaryView.oc_darkBlackView.alpha = 1
        }) { finished in
        }
    }
    
    func oc_hideBlackView() {
        DispatchQueue.main.async {
            self.navigationItem.leftBarButtonItem?.isEnabled = true
            self.navigationItem.rightBarButtonItem?.isEnabled = true
            
            UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseInOut, animations: {
                TemporaryView.oc_darkBlackView.alpha = 0
            }) { finished in
                TemporaryView.oc_hudLabel.removeFromSuperview()
                TemporaryView.oc_activityIndicator.removeFromSuperview()
                TemporaryView.oc_darkBlackView.removeFromSuperview()
            }
        }
    }
    
    func oc_showLoading() {
        self.view.addSubview(TemporaryView.oc_darkBlackView)
        TemporaryView.oc_darkBlackView.alpha = 0
        
        TemporaryView.oc_darkBlackView.addSubview(TemporaryView.oc_activityIndicator)
        TemporaryView.oc_activityIndicator.startAnimating()
        UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseInOut, animations: {
            TemporaryView.oc_darkBlackView.alpha = 1
        }) { finished in
        }
    }
    
    func oc_showLoadingWithText(_ text: String) {
        DispatchQueue.main.async {
            self.view.addSubview(TemporaryView.oc_darkBlackView)
            TemporaryView.oc_darkBlackView.alpha = 0
            
            TemporaryView.oc_darkBlackView.addSubview(TemporaryView.oc_hudLabel)
            TemporaryView.oc_hudLabel.text = text
            TemporaryView.oc_darkBlackView.addSubview(TemporaryView.oc_activityIndicator)
            TemporaryView.oc_activityIndicator.startAnimating()
            
            UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseInOut, animations: {
                TemporaryView.oc_darkBlackView.alpha = 1
            }) { finished in
            }
        }
    }
    
    func oc_setLoadingText(_ text: String) {
        DispatchQueue.main.async {
            TemporaryView.oc_hudLabel.text = text
        }
    }
    
    func oc_hideLoading() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseInOut, animations: {
                TemporaryView.oc_darkBlackView.alpha = 0
            }) { finished in
                TemporaryView.oc_hudLabel.removeFromSuperview()
                TemporaryView.oc_activityIndicator.removeFromSuperview()
                TemporaryView.oc_darkBlackView.removeFromSuperview()
            }
        }
    }
    
    final func oc_dismissKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.oc_dismissKeyboard))
        tap.cancelsTouchesInView = false
//        tap.delegate = (self as! UIGestureRecognizerDelegate)
        view.addGestureRecognizer(tap)
    }
    
    @objc final func oc_dismissKeyboard() {
        view.endEditing(true)
    }
    
    func oc_menuButtonTopConstant() -> CGFloat {
        if #available(iOS 11.0, *) {
            return view.safeAreaInsets.top
        }
        return 20
    }
    
    func oc_lightStatusBar() {
        UIApplication.shared.setStatusBarStyle(.lightContent, animated: true)
//        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    func oc_defaultStatusBar() {
        print("defaultStatusBar")
        UIApplication.shared.setStatusBarStyle(.default, animated: true)
//        UIApplication.shared.statusBarStyle = .default
    }
    
    func oc_animatePosition(thing: UIView, center: CGPoint, time: TimeInterval, delay: TimeInterval) {
        UIView.animate(withDuration: time, delay: delay, options: UIView.AnimationOptions.curveEaseOut, animations: { () -> Void in
            thing.center = center
        }, completion: nil)
    }
    
    func oc_animateAlpha(thing: UIView, alpha: CGFloat, time: TimeInterval, delay: TimeInterval) {
        UIView.animate(withDuration: time, delay: delay, options: UIView.AnimationOptions.curveEaseOut, animations: { () -> Void in
            thing.alpha = alpha
        }, completion: nil)
    }
}

extension UIView {
    
    var firstResponder: UIView? {
        guard !isFirstResponder else { return self }
        
        for subview in subviews {
            if let firstResponder = subview.firstResponder {
                return firstResponder
            }
        }
        
        return nil
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable
    /// Shadow color of view; also inspectable from Storyboard.
    public var shadowColor: UIColor? {
        get {
            guard let color = layer.shadowColor else {
                return nil
            }
            return UIColor(cgColor: color)
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }
    
    @IBInspectable
    /// Shadow offset of view; also inspectable from Storyboard.
    public var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    /// Shadow opacity of view; also inspectable from Storyboard.
    public var shadowOpacity: Double {
        get {
            return Double(layer.shadowOpacity)
        }
        set {
            layer.shadowOpacity = Float(newValue)
        }
    }
    
    @IBInspectable
    /// Shadow radius of view; also inspectable from Storyboard.
    public var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    /// Shadow path of view; also inspectable from Storyboard.
    public var shadowPath: CGPath? {
        get {
            return layer.shadowPath
        }
        set {
            layer.shadowPath = newValue
        }
    }
    
    @IBInspectable
    /// Should shadow rasterize of view; also inspectable from Storyboard.
    /// cache the rendered shadow so that it doesn't need to be redrawn
    public var shadowShouldRasterize: Bool {
        get {
            return layer.shouldRasterize
        }
        set {
            layer.shouldRasterize = newValue
        }
    }
    
    @IBInspectable
    /// Should shadow rasterize of view; also inspectable from Storyboard.
    /// cache the rendered shadow so that it doesn't need to be redrawn
    public var shadowRasterizationScale: CGFloat {
        get {
            return layer.rasterizationScale
        }
        set {
            layer.rasterizationScale = newValue
        }
    }
    
    func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        
        self.layer.add(animation, forKey: nil)
    }
    
    func dropShadow() {
        
        var shadowLayer: CAShapeLayer!
        let cornerRadius: CGFloat = 0.0
        let fillColor: UIColor = .white
        
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
            shadowLayer.fillColor = fillColor.cgColor
            
            shadowLayer.shadowColor = UIColor.black.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            shadowLayer.shadowOpacity = 0.2
            shadowLayer.shadowRadius = 2.0
            
            layer.insertSublayer(shadowLayer, at: 0)
        }
    }
    
    func bump() {
        self.transform = CGAffineTransform.identity
        self.alpha = 0
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            self.alpha = 1
        }) { finished in
            UIView.animate(withDuration: 1.3,
                           delay: 0.0,
                           usingSpringWithDamping: CGFloat(0.20),
                           initialSpringVelocity: CGFloat(3.0),
                           options: UIView.AnimationOptions.allowUserInteraction,
                           animations: {
                            self.transform = CGAffineTransform.identity
            },
                           completion: { Void in()  }
            )
        }
    }
    
    func resizeAsSeparator() {
        var sRect = self.frame
        sRect.size = CGSize(width: sRect.size.width, height: 0.5)
        self.frame = sRect
    }
     
    func scaleSubviews() {
        if UIDevice.iPhone8 || UIDevice.iPhone5 {
            for subview in self.subviews as [UIView] {
                if let label = subview as? UILabel {
                    label.scaleFontSize()
                }
                else if let textView = subview as? UITextView {
                    textView.scaleFontSize()
                }
                else if let textField = subview as? UITextField {
                    textField.scaleFontSize()
                }
                else if let button = subview as? UIButton {
                    button.scaleFontSize()
                }
                else {
                    subview.scaleSubviews()
                }
            }
        }
    }
}

extension UILabel {
    func scaleFontSize() {
        self.font = UIFont(name: self.font.fontName,
                           size: scaleTo(number: self.font.pointSize))
    }
}

extension UITextView {
    func scaleFontSize() {
        self.font = UIFont(name: self.font!.fontName,
                           size: scaleTo(number: self.font!.pointSize))
    }
}

extension UITextField {
    func scaleFontSize() {
        self.font = UIFont(name: self.font!.fontName,
                           size: scaleTo(number: self.font!.pointSize))
    }
}

extension UILabel {
    private struct AssociatedKeys {
        static var padding = UIEdgeInsets()
    }

    public var padding: UIEdgeInsets? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.padding) as? UIEdgeInsets
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self, &AssociatedKeys.padding, newValue as UIEdgeInsets?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }

    override open func draw(_ rect: CGRect) {
        if padding != nil {
            self.drawText(in: rect)
        } else {
            self.drawText(in: rect)
        }
    }

    override open var intrinsicContentSize: CGSize {
        guard let text = self.text else { return super.intrinsicContentSize }

        var contentSize = super.intrinsicContentSize
        var textWidth: CGFloat = frame.size.width
        var insetsHeight: CGFloat = 0.0
        var insetsWidth: CGFloat = 0.0

        if let insets = padding {
            insetsWidth += insets.left + insets.right
            insetsHeight += insets.top + insets.bottom
            textWidth -= insetsWidth
        }

        let newSize = text.boundingRect(with: CGSize(width: textWidth, height: CGFloat.greatestFiniteMagnitude),
                                        options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                        attributes: [NSAttributedString.Key.font: self.font!], context: nil)

        contentSize.height = ceil(newSize.size.height) + insetsHeight
        contentSize.width = ceil(newSize.size.width) + insetsWidth

        return contentSize
    }
}

extension UIButton {
    
    func setBackgroundColor(color: UIColor, forState: UIControl.State) {
        let minimumSize: CGSize = CGSize(width: 1.0, height: 1.0)
        
        UIGraphicsBeginImageContext(minimumSize)
        
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(CGRect(origin: .zero, size: minimumSize))
        }
        
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.clipsToBounds = true
        self.setBackgroundImage(colorImage, for: forState)
    }
    
    func setHover() {
        let color = self.backgroundColor
        
        self.setBackgroundColor(color: color!, forState: .normal)
        self.setBackgroundColor(color: (color?.withAlphaComponent(0.7))!, forState: .focused)
        self.setBackgroundColor(color: (color?.withAlphaComponent(0.7))!, forState: .highlighted)
        
//        self.setTitleColor(.white, for: .normal)
//        self.setTitleColor(.white, for: .focused)
//        self.setTitleColor(.white, for: .highlighted)
        
        self.backgroundColor = .clear
    }
    
    func scaleFontSize() {
        if self.title(for: .normal) != "×" {
            self.titleLabel!.font = UIFont(name: self.titleLabel!.font.fontName,
                                           size: scaleTo(number: self.titleLabel!.font.pointSize))
            
//            if UIDevice.iPhone5 {
//                let center = self.center
//                var frame = self.frame
//                frame.size.height = frame.size.height*0.85
//                self.frame = frame
//                self.center = center
//            }
        }
    }
}

extension UITableView {
    func scrollToBottom(animated: Bool){
        DispatchQueue.main.async {
            let indexPath = IndexPath(
                row: self.numberOfRows(inSection:  self.numberOfSections - 1) - 1,
                section: self.numberOfSections - 1)
            self.scrollToRow(at: indexPath, at: .bottom, animated: animated)
        }
    }
    
    func scrollToTop(animated: Bool) {
        
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: 0, section: 0)
            self.scrollToRow(at: indexPath, at: .top, animated: animated)
        }
    }
    
    func keyboardRaised(height: CGFloat){
        self.contentInset.bottom = height
        self.scrollIndicatorInsets.bottom = height
    }
    
    func keyboardClosed(){
        self.contentInset.bottom = 0
        self.scrollIndicatorInsets.bottom = 0
        self.scrollRectToVisible(CGRect.zero, animated: true)
    }
}

extension UIImage {
    func imageWithColor(color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        color.setFill()
        
        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: self.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.setBlendMode(CGBlendMode.normal)
        
        let rect = CGRect(origin: .zero, size: CGSize(width: self.size.width, height: self.size.height))
        context?.clip(to: rect, mask: self.cgImage!)
        context?.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    func scaleImageToSize(newSize: CGSize) -> UIImage {
        var scaledImageRect = CGRect.zero
        
        let aspectWidth = newSize.width/size.width
        let aspectheight = newSize.height/size.height
        
        let aspectRatio = max(aspectWidth, aspectheight)
        
        scaledImageRect.size.width = size.width * aspectRatio;
        scaledImageRect.size.height = size.height * aspectRatio;
        scaledImageRect.origin.x = (newSize.width - scaledImageRect.size.width) / 2.0;
        scaledImageRect.origin.y = (newSize.height - scaledImageRect.size.height) / 2.0;
        
        UIGraphicsBeginImageContext(newSize)
        draw(in: scaledImageRect)
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage!
    }
}

extension UIImageView {
    
    func loadImageUsingCacheWithUrlString(_ urlString: String) {
        self.image = UIImage(imageLiteralResourceName: "profile_avatar")
        
        if let cachedImage = downloadCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = cachedImage
            return
        }
        
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                return
            }
            
            DispatchQueue.main.async(execute: {
                if let data = data, let downloadedImage = UIImage(data: data) {
                    downloadCache.setObject(downloadedImage, forKey: urlString as AnyObject)
                    self.image = downloadedImage
                }
            })
        }).resume()
    }
    
    func getFrameSizeForImage(_ image: UIImage) -> CGRect {
        let hfactor = image.size.width / self.frame.size.width
        let vfactor = image.size.height / self.frame.size.height
        
        let factor = fmax(hfactor, vfactor)
        
        let newWidth = image.size.width / factor
        let newHeight = image.size.height / factor
        
        let leftOffset = (self.frame.size.width - newWidth) / 2
        let topOffset = (self.frame.size.height - newHeight) / 2
        
        return CGRect(x: leftOffset, y: topOffset, width: newWidth, height: newHeight)
    }
    
//    func loadImage(url: String, placeholder: UIImage?) {
//        if let imageURL = NSURL(string: url) {
//            self.sd_setImage(with: imageURL.absoluteURL, placeholderImage: placeholder, options: .continueInBackground, completed: nil)
//        }
//    }
}

extension WKWebView {
    func loadFileUsingCachWithUrlString(_ urlString: String, completion: @escaping ((String?) -> Void)) {
        if let cachedFile = downloadCache.object(forKey: urlString as AnyObject) as? URL {
            self.loadFileURL(cachedFile, allowingReadAccessTo: cachedFile)
            completion(nil)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completion("Invalid URL")
            return
        }
        
        let session = URLSession(configuration: .default)
        let task = session.downloadTask(with: url) { (tempUrl, response, error) in
            if let error = error {
                completion(error.localizedDescription)
                return
            }
            
            guard let tempUrl = tempUrl else {
                completion("Temporary URL not generated")
                return
            }
            
            let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let destinationURL = documentsPath.appendingPathComponent(url.lastPathComponent)
            
            try? FileManager.default.removeItem(at: destinationURL)
            
            do {
                try FileManager.default.copyItem(at: tempUrl, to: destinationURL)
                
                downloadCache.setObject(destinationURL as AnyObject, forKey: url.absoluteString as AnyObject)
                DispatchQueue.main.async {
                    self.loadFileURL(destinationURL, allowingReadAccessTo: destinationURL)
                    completion(nil)
                }
            } catch let error {
                completion("\(error.localizedDescription)")
            }
        }
        task.resume()
    }
}

extension UserDefaults {
    func contains(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
}

extension CGRect {
    static let screenSize = UIScreen.main.bounds
}

extension CGFloat {
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    
    static let statusBarHeight: CGFloat = 20 + topSafeAreaHeight
    static let navigationBarHeight: CGFloat = 44
    static let statusAndNavigationHeight: CGFloat = statusBarHeight + navigationBarHeight
    
    static let topSafeAreaHeight: CGFloat = UIDevice.iPhoneX ? 22 : 0
    static let bottomSafeAreaHeight: CGFloat = UIDevice.iPhoneX ? 34 : 0
}

extension Double {
    func toStringDate() -> String {
        
        let date = NSDate(timeIntervalSince1970: self)
        
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "MM/dd/yy"
        
        let dateString = dayTimePeriodFormatter.string(from: date as Date)
        return dateString
    }
    
    func toStringTime() -> String {
        
        let date = NSDate(timeIntervalSince1970: self)
        
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "hh:mm a"
        
        let dateString = dayTimePeriodFormatter.string(from: date as Date)
        return dateString
    }
}

extension NSNumber {
    func toPrice() -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.current
        currencyFormatter.currencySymbol = "A$"
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.maximumFractionDigits = 2
        currencyFormatter.minimumFractionDigits = 2
        currencyFormatter.maximumIntegerDigits = 7
        
        return currencyFormatter.string(from: self)!
    }
}

extension Int {
    func toPrice() -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.current
        currencyFormatter.currencySymbol = "A$"
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.maximumFractionDigits = 2
        currencyFormatter.minimumFractionDigits = 2
        currencyFormatter.maximumIntegerDigits = 7
        
        return currencyFormatter.string(from: NSNumber(integerLiteral: self))!
    }
    
    func toBool() -> Bool {
        return (self as NSNumber).boolValue
    }
    
    func deg2rad() -> Float {
        return Float(self) * .pi / 180
    }
    
    func toRandomString() -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0...self-1).map{ _ in letters.randomElement()! })
    }
    
    func toRandomInt() -> String {
        let letters = "0123456789"
        return String((0...self-1).map{ _ in letters.randomElement()! })
    }
}

extension NSMutableAttributedString {
    
    func getSizeWithWidth(width: CGFloat) -> CGSize {
        
        let rect = self.boundingRect(with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions(rawValue: NSStringDrawingOptions.usesLineFragmentOrigin.rawValue | NSStringDrawingOptions.usesFontLeading.rawValue), context: nil)
        
        return rect.size
    }
    
    func getHeightWithWidth(width: CGFloat) -> CGFloat {
        
        let rect = self.boundingRect(with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions(rawValue: NSStringDrawingOptions.usesLineFragmentOrigin.rawValue | NSStringDrawingOptions.usesFontLeading.rawValue), context: nil)
        
        return rect.size.height
    }
}

extension Date {
    func stringDateToFormat(to: String) -> String {
        let dateFormat: DateFormatter = DateFormatter()
        dateFormat.dateFormat = to
        return dateFormat.string(from: self)
    }
    
    func today() -> Bool {
        if dateToday("dd MMM yyyy") == self.stringDateToFormat(to: "dd MMM yyyy") {
            return true
        }
        else {
            return false
        }
    }
}

extension URL {
    func addSchemeIfNeeded(_ newScheme: String = "https") -> URL {
        let urlString = self.absoluteString
        if let oldScheme = self.scheme {
            guard oldScheme != newScheme else { return self }

            let filterRange = urlString.range(of: oldScheme)
            let newURLString = urlString.replacingOccurrences(of: oldScheme,
                                                              with: newScheme,
                                                              options: [],
                                                              range: filterRange)
            return URL(string: newURLString) ?? self
        }
        let newURLString = String(format: "%@://%@", newScheme, urlString)
        return URL(string: newURLString) ?? self
    }
}

extension String {
    var isValidUrl: Bool {
        guard let url = URL(string: self) else { return false }
        return UIApplication.shared.canOpenURL(url.addSchemeIfNeeded())
    }
    
    var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
    
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: font], context: nil)
        return boundingBox.height
    }
    
    func reformatStringDate(from: String, to: String) -> String {
        let dateFormat: DateFormatter = DateFormatter()
        dateFormat.dateFormat = from
        let date = dateFormat.date(from: self)
        dateFormat.dateFormat = to
        return dateFormat.string(from: date!)
    }
    
    func toDate(format: String) -> Date {
        let dateFormat: DateFormatter = DateFormatter()
        dateFormat.dateFormat = format
        return dateFormat.date(from: self)!
    }
    
    func toOdometer() -> String {
        
        var string = self.trim()
        
        string = string.replacingOccurrences(of: ",", with: "")
        
        if string == "" {
            return string
        }
        
        if !string.isNumber {
            string = "0"
        }
        
        let currencyFormatter = NumberFormatter()
        currencyFormatter.locale = Locale.current
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.maximumIntegerDigits = 7
        currencyFormatter.groupingSize = 3
        
        return currencyFormatter.string(from: NSNumber(integerLiteral: Int(string)!))!
    }
    
    func toPrice() -> String {
        
        var string = self.trim()
        
        string = string.replacingOccurrences(of: ",", with: "")
        
        if string == "" {
            return string
        }
        
        let number = Int(string)
        return (number?.toPrice())!
    }
    
    func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "\n", with: " ").replacingOccurrences(of: "\r", with: " ").replacingOccurrences(of: "N/A", with: "")
    }
    
    func trimSpaces() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "\n", with: " ").replacingOccurrences(of: "\r", with: " ").replacingOccurrences(of: "N/A", with: "").replacingOccurrences(of: " ", with: "")
    }
    
    func toObject() -> AnyObject {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as AnyObject
            } catch {
                print(error.localizedDescription)
            }
        }
        return AnyObject?.self as AnyObject
    }
    
    func toDictionary() -> NSDictionary {
        let blankDict : NSDictionary = [:]
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
            } catch {
                print(error.localizedDescription)
            }
        }
        return blankDict
    }
    
    func toArray() -> NSArray {
        let blankArray : NSArray = []
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as! NSArray
            } catch {
                print(error.localizedDescription)
            }
        }
        return blankArray
    }
    
    func toBool() -> Bool{
        if self == "false" {
            return false
        }
        else{
            return true
        }
    }
}

extension Dictionary {
}

extension NSDictionary {
    
    func removeNull() -> NSDictionary {
        
        let mainDict = NSMutableDictionary.init(dictionary: self)
        for _dict in mainDict {
            if _dict.value is NSNull {
                mainDict.setObject("N/A", forKey: _dict.key as! NSCopying)
            }
            if _dict.value is NSString {
                let string = _dict.value as! NSString
                if string.length == 0 {
                    mainDict.setObject("N/A", forKey: _dict.key as! NSCopying)
                }
            }
            if _dict.value is NSDictionary {
                let dict = _dict.value as! NSDictionary
                mainDict.setObject(dict.removeNull(), forKey: _dict.key as! NSCopying)
            }
            if _dict.value is NSArray {
                let array = _dict.value as! NSArray
                mainDict.setObject(array.removeNull(), forKey: _dict.key as! NSCopying)
            }
        }
        return mainDict as NSDictionary
    }
    
    func map<T: Decodable>(_ type: T.Type) -> T? {
        if let data = try? JSONSerialization.data(withJSONObject: self, options: []) {
            return try? data.map(type)
        }
        return nil
    }
}

extension NSArray {
    func removeNull() -> NSArray {
        
        let mainArray = NSMutableArray.init()
        for _dict in self {
            if _dict is NSNull {
                mainArray.add("N/A")
            }
            if _dict is NSString {
                let string = _dict as! NSString
                if string.length == 0 {
                    mainArray.add("N/A")
                }
            }
            if _dict is NSDictionary {
                let dict = _dict as! NSDictionary
                mainArray.add(dict.removeNull())
            }
            if _dict is NSArray {
                let array = _dict as! NSArray
                mainArray.add(array.removeNull())
            }
        }
        return mainArray as NSArray
    }
}

extension Array {
    /// Returns an array containing this sequence shuffled
    var shuffled: Array {
        var elements = self
        return elements.shuffle()
    }
    /// Shuffles this sequence in place
    @discardableResult
    mutating func shuffle() -> Array {
        let count = self.count
        indices.lazy.dropLast().forEach {
            swapAt($0, Int(arc4random_uniform(UInt32(count - $0))) + $0)
        }
        return self
    }
    var chooseOne: Element { return self[Int(arc4random_uniform(UInt32(count)))] }
    func choose(_ n: Int) -> Array { return Array(shuffled.prefix(n)) }
}

extension Data {
    func map<T: Decodable>(_ type: T.Type) throws -> T {
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(type, from: self)
        } catch {
            print("[DEBUG JSON Mapping]: [Model: \(T.self)] \(error)...")
            throw AppError.net(.jsonMapping)
        }
    }
}

private func sp_checkUserInfo() {
    print("Continue")
}
