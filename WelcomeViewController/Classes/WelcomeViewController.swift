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
}

public final class WelcomeViewController<T>: UIViewController where T: WelcomeCardProvider {
    var header: String?
    var paragraph: String?
    var buttonText: String?
    var calloutViews: [WelcomeCardView<T>] = []
    weak var delegate: WelcomeViewControllerDelegate?
    
    public init(header: String?, buttonText: String?, callouts: [T], delegate: WelcomeViewControllerDelegate?) {
        super.init(nibName: nil, bundle: nil)
        
        self.header = header
        self.buttonText = buttonText ?? "Continue"
        self.delegate = delegate
        
        for callout in callouts {
            calloutViews.append(WelcomeCardView<T>(callout))
        }
    }
    
    public init(header: String?, paragraph: String?, buttonText: String?, callouts: [T], delegate: WelcomeViewControllerDelegate?) {
        super.init(nibName: nil, bundle: nil)
        
        self.header = header
        self.paragraph = paragraph
        self.buttonText = buttonText ?? "Continue"
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

        var theCalloutViews: [UIView] = []
        if self.paragraph != nil {
            let paragraph = UILabel()
            paragraph.translatesAutoresizingMaskIntoConstraints = false
            var paragraphDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .body)
            paragraphDescriptor = paragraphDescriptor.addingAttributes([UIFontDescriptor.AttributeName.traits: [UIFontDescriptor.TraitKey.weight: UIFont.Weight.light]])

            paragraph.font = UIFont(descriptor: paragraphDescriptor, size: paragraphDescriptor.pointSize)
            paragraph.text = self.paragraph
            paragraph.numberOfLines = 0

            theCalloutViews.append(paragraph)
        }
        
        theCalloutViews.append(contentsOf: calloutViews)

        let calloutStackView = UIStackView(arrangedSubviews: theCalloutViews)
        calloutStackView.axis = .vertical
        calloutStackView.spacing = 32
        calloutStackView.translatesAutoresizingMaskIntoConstraints = false
        calloutStackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        calloutStackView.isLayoutMarginsRelativeArrangement = true

        theCalloutViews.append(calloutStackView)

        let stackView = UIStackView(arrangedSubviews: [title, calloutStackView])
        stackView.axis = .vertical
        stackView.spacing = 32
        stackView.translatesAutoresizingMaskIntoConstraints = false

        let button = PlainButton()
        button.setTitle2(buttonText, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false

        if let delegate = delegate {
            let selector = #selector(WelcomeViewControllerDelegate.welcomeViewControllerButtonDidTouchUpInside(_:))
            button.addTarget(delegate, action: selector, for: .touchUpInside)
        }

        scroll.addSubview(stackView)

        view.addSubview(scroll)
        view.addSubview(button)

        let margins = view.layoutMarginsGuide
        scroll.leadingAnchor ~~ margins.leadingAnchor
        scroll.trailingAnchor ~~ margins.trailingAnchor
        scroll.topAnchor ~~ margins.topAnchor
        scroll.bottomAnchor ~~ button.topAnchor - 16
        
        let scrollGuide = scroll.contentLayoutGuide
        stackView.leadingAnchor ~~ scroll.frameLayoutGuide.leadingAnchor
        stackView.trailingAnchor ~~ scroll.frameLayoutGuide.trailingAnchor
        stackView.centerXAnchor ~~ scrollGuide.centerXAnchor
        stackView.topAnchor ~~ scrollGuide.topAnchor
        stackView.bottomAnchor ~~ scrollGuide.bottomAnchor
        
        button.leadingAnchor ~~ margins.leadingAnchor
        button.trailingAnchor ~~ margins.trailingAnchor
        button.bottomAnchor ~~ margins.bottomAnchor - 32
    }
}

