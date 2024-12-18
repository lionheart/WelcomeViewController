//
//  WelcomeViewController.swift
//  WelcomeViewController
//
//  Created by Dan Loewenherz on 2/26/18.
//
import UIKit
import SuperLayout

@objc public protocol WelcomeViewControllerDelegate: AnyObject {
    func welcomeViewControllerButtonDidTouchUpInside(_ sender: Any)
    func welcomeViewControllerSecondaryButtonDidTouchUpInside(_ sender: Any)
}

public final class WelcomeViewController<T>: UIViewController where T: WelcomeCardProvider {
    var header: String?
    var paragraph: String?
    var buttonText: String?
    var secondaryButtonText: String?
    var calloutViews: [WelcomeCardView<T>] = []
    weak var delegate: WelcomeViewControllerDelegate?
    
    public convenience init(header: String?, buttonText: String?, callouts: [T], delegate: WelcomeViewControllerDelegate?) {
        self.init(header: header, paragraph: nil, buttonText: buttonText, callouts: callouts, delegate: delegate)
    }
    
    public convenience init(header: String?, paragraph: String?, buttonText: String?, callouts: [T], delegate: WelcomeViewControllerDelegate?) {
        self.init(header: header, paragraph: paragraph, buttonText: buttonText, secondaryButtonText: nil, callouts: callouts, delegate: delegate)
    }
    
    public init(header: String?, paragraph: String?, buttonText: String?, secondaryButtonText: String?, callouts: [T], delegate: WelcomeViewControllerDelegate?) {
        super.init(nibName: nil, bundle: nil)
        
        self.header = header
        self.paragraph = paragraph
        self.buttonText = buttonText
        self.secondaryButtonText = secondaryButtonText
        self.delegate = delegate
        
        for callout in callouts {
            calloutViews.append(WelcomeCardView<T>(callout))
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        var descriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .largeTitle)
        descriptor = descriptor.addingAttributes([UIFontDescriptor.AttributeName.traits: [UIFontDescriptor.TraitKey.weight: UIFont.Weight.heavy]])
        
        title.font = UIFont(descriptor: descriptor, size: descriptor.pointSize)
        title.text = header
        title.numberOfLines = 0
        
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.alwaysBounceVertical = true
        scroll.contentInset = UIEdgeInsets(top: 16, left: 8, bottom: 0, right: 8)

        var theCalloutViews: [UIView] = [title]
        if self.paragraph != nil {
            let paragraph = UILabel()
            paragraph.translatesAutoresizingMaskIntoConstraints = false
            var paragraphDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .body)
            paragraphDescriptor = paragraphDescriptor.addingAttributes([UIFontDescriptor.AttributeName.traits: [UIFontDescriptor.TraitKey.weight: UIFont.Weight.regular]])

            paragraph.font = UIFont(descriptor: paragraphDescriptor, size: paragraphDescriptor.pointSize)
            paragraph.text = self.paragraph
            paragraph.numberOfLines = 0

            theCalloutViews.append(paragraph)
        }
        
        theCalloutViews.append(contentsOf: calloutViews)

        let calloutStackView = UIStackView(arrangedSubviews: theCalloutViews)
        calloutStackView.axis = .vertical
        calloutStackView.spacing = 16
        calloutStackView.translatesAutoresizingMaskIntoConstraints = false
        calloutStackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16)
        calloutStackView.isLayoutMarginsRelativeArrangement = true

        theCalloutViews.append(calloutStackView)

        let stackView = UIStackView(arrangedSubviews: [calloutStackView])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false

        var primaryButton: PlainButton?
        if let buttonText {
            primaryButton = PlainButton()
            primaryButton?.setTitle2(buttonText, for: .normal)
            primaryButton?.translatesAutoresizingMaskIntoConstraints = false
        }

        var secondaryButton: UIButton?
        if let secondaryButtonText {
            secondaryButton = UIButton(type: .custom)
            secondaryButton?.setTitle(secondaryButtonText, for: .normal)
            secondaryButton?.setTitleColor(.darkGray, for: .normal)
            secondaryButton?.setTitleColor(.lightGray, for: .selected)
            secondaryButton?.setTitleColor(.lightGray, for: .highlighted)
            secondaryButton?.translatesAutoresizingMaskIntoConstraints = false
        }

        if let delegate {
            let selector = #selector(WelcomeViewControllerDelegate.welcomeViewControllerButtonDidTouchUpInside(_:))
            let secondarySelector = #selector(WelcomeViewControllerDelegate.welcomeViewControllerSecondaryButtonDidTouchUpInside(_:))
            
            if let primaryButton {
                primaryButton.addTarget(delegate, action: selector, for: .touchUpInside)
            }
            
            if let button = secondaryButton {
                button.addTarget(delegate, action: secondarySelector, for: .touchUpInside)
            }
        }

        scroll.addSubview(stackView)

        view.addSubview(scroll)
        
        if let primaryButton {
            view.addSubview(primaryButton)
        }
        
        if let secondaryButton {
            view.addSubview(secondaryButton)
        }

        let margins = view.layoutMarginsGuide
        scroll.leadingAnchor ~~ margins.leadingAnchor
        scroll.trailingAnchor ~~ margins.trailingAnchor
        scroll.topAnchor ~~ margins.topAnchor
        
        if let primaryButton {
            scroll.bottomAnchor ~~ primaryButton.topAnchor - 16
        } else {
            scroll.bottomAnchor ~~ margins.bottomAnchor - 32
        }

        let scrollGuide = scroll.contentLayoutGuide
        stackView.leadingAnchor ~~ scroll.frameLayoutGuide.leadingAnchor
        stackView.trailingAnchor ~~ scroll.frameLayoutGuide.trailingAnchor
        stackView.centerXAnchor ~~ scrollGuide.centerXAnchor
        stackView.topAnchor ~~ scrollGuide.topAnchor
        stackView.bottomAnchor ~~ scrollGuide.bottomAnchor

        if let primaryButton {
            primaryButton.leadingAnchor ~~ margins.leadingAnchor
            primaryButton.trailingAnchor ~~ margins.trailingAnchor
            if let secondaryButton {
                primaryButton.bottomAnchor ~~ secondaryButton.topAnchor - 8

                secondaryButton.leadingAnchor ~~ margins.leadingAnchor
                secondaryButton.trailingAnchor ~~ margins.trailingAnchor
                secondaryButton.bottomAnchor ~~ margins.bottomAnchor - 32
            } else {
                primaryButton.bottomAnchor ~~ margins.bottomAnchor - 32
            }
        }
    }
}

