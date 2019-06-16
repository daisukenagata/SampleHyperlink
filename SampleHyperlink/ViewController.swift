//
//  ViewController.swift
//  SampleHyperlink
//
//  Created by 永田大祐 on 2019/06/17.
//  Copyright © 2019 永田大祐. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var loginTermsTextsView: LoginTermsTextView = {
        let lv = LoginTermsTextView()
        return lv
    }()

    var attributes       : [NSAttributedString.Key: Any] = [:]
    let paragraphStyle   = NSMutableParagraphStyle()
    var attributedString = NSMutableAttributedString()
    let termsTitle  = "This app is developed as an individual. Supported OS is iOS. (Yahoo) The information to collect apps using True Depth API is the collection of eye movement information. The purpose of collecting information is eye movement for screen operation.(Google) Collected data is not shared or stored with third parties."

    override func viewDidLoad() {
        super.viewDidLoad()

        loginTermsTextsView.isEditable = false
        loginTermsTextsView.delegate = self
        loginTermsTextsView.isSelectable = true
        loginTermsTextsView.frame = self.view.frame
        loginTermsTextsView.frame.origin.y = 100
        view.addSubview(loginTermsTextsView)

        paragraphStyle.lineSpacing = 20
        paragraphStyle.alignment = .left
        attributes.updateValue(paragraphStyle, forKey: .paragraphStyle)
        attributedString = NSMutableAttributedString(string: termsTitle)
        attributedString.addAttribute(.link,
                                      value: "TermLink",
                                      range: NSString(string: termsTitle).range(of: "Yahoo"))
        attributedString.addAttribute(.link,
                                      value: "ConsentLink",
                                      range: NSString(string: termsTitle).range(of: "Google"))
        
        let allLink  = NSString(string: termsTitle).range(of: termsTitle)
        attributedString.addAttributes(attributes, range: allLink)
        loginTermsTextsView.attributedText = attributedString
        loginTermsTextsView.linkTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)]
        
    }

}

// MARK: - Event

extension ViewController: UITextViewDelegate {
    
    public func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {

        let urlString = URL.absoluteString
        if  urlString == "TermLink" { termOfUseLink() }
        if  urlString == "ConsentLink" { privacyPolicyLink() }
        return false
    }

    func termOfUseLink() {
        let  url = URL(string: "https://www.yahoo.co.jp")!
        if UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url)
            } else {
                // Fallback on earlier versions
            }
        }
    }

    func privacyPolicyLink() {
        let  url = URL(string: "https://www.google.com/?client=safari")!
        if UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url)
            } else {
                // Fallback on earlier versions
            }
        }
    }
}


class LoginTermsTextView: UITextView {
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame,textContainer: textContainer)
        
        self.sizeToFit()
        self.font = UIFont.systemFont(ofSize: 14)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
