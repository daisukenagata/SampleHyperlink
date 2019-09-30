//
//  ViewController.swift
//  SampleHyperlink
//
//  Created by 永田大祐 on 2019/06/17.
//  Copyright © 2019 永田大祐. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let loginTermsTextsView = LoginTermsTextView()
        view.addSubview(loginTermsTextsView)
    }
}

// MARK: - Event

class LoginTermsTextView: UITextView {

    var termsTitle       = "This app is developed as an individual. Supported OS is iOS. (Yahoo) The information to collect apps using True Depth API is the collection of eye movement information. The purpose of collecting information is eye movement for screen operation.(Google) Collected data is not shared or stored with third parties."
    var attributes       : [NSAttributedString.Key: Any] = [:]
    let paragraphStyle   = NSMutableParagraphStyle()
    var attributedString = NSMutableAttributedString()

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame,textContainer: textContainer)

        self.delegate = self
        desgin()
        atribute()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func desgin() {
        self.sizeToFit()
        self.font = UIFont.systemFont(ofSize: 14)
        self.isEditable = false
        self.isSelectable = true
        self.frame = UIScreen.main.bounds
        self.frame.origin.y = 100
    }

    func atribute() {
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

        self.attributedText = attributedString
        self.linkTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)]
    }
}

extension LoginTermsTextView: UITextViewDelegate {
    public func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        guard URL.absoluteString == "" else {
            if UIApplication.shared.canOpenURL(URL) {UIApplication.shared.open(URL)}
            return false
        }
        return false
    }
}
