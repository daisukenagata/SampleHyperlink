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
    let termsTitle       = "This app is developed as an individual. Supported OS is iOS. (Yahoo) The information to collect apps using True Depth API is the collection of eye movement information. The purpose of collecting information is eye movement for screen operation.(Google) Collected data is not shared or stored with third parties."

    override func viewDidLoad() {
        super.viewDidLoad()

        loginTermsTextsView.delegate = self
        loginTermsTextsView.isEditable = false
        loginTermsTextsView.isSelectable = true
        loginTermsTextsView.frame = self.view.frame

        loginTermsTextsView.frame.origin.y = 100
        view.addSubview(loginTermsTextsView)

        paragraphStyle.lineSpacing = 5
        paragraphStyle.alignment = .left
        attributes.updateValue(paragraphStyle, forKey: .paragraphStyle)
        attributedString = NSMutableAttributedString(string: termsTitle)

        attributedString.addAttribute(.link,
                                      value: "https://www.yahoo.co.jp",
                                      range: NSString(string: termsTitle).range(of: "Yahoo"))
        attributedString.addAttribute(.link,
                                      value: "https://www.google.com",
                                      range: NSString(string: termsTitle).range(of: "Google"))
        
        // 行間とハイパーリンクを同時に実施する方法
        let allLink  = NSString(string: termsTitle).range(of: termsTitle)
        attributedString.addAttributes(attributes, range: allLink)

        loginTermsTextsView.attributedText = attributedString
        loginTermsTextsView.linkTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)]
        
    }

}

// MARK: - Event

extension ViewController: UITextViewDelegate {
    
    public func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {

        guard  URL.absoluteString == "" else {
            if UIApplication.shared.canOpenURL(URL) { UIApplication.shared.open(URL) }
            return false
        }
        return false
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
