//
//  WelcomeViewController.swift
//  WelcomeViewController
//
//  Created by Dan Loewenherz on 2/26/18.
//
import UIKit
import SuperLayout

@objc public protocol WelcomeViewControllerDelegate: class {
    func welcomeViewControllerButtonDidTouchUpInside(_ sender: Any)
}

public final class WelcomeViewController<T>: UIViewController where T: WelcomeCardProvider {
    var header: String?
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
        scroll.contentInset = UIEdgeInsets(top: 48, left: 8, bottom: 0, right: 8)

        let stackView = UIStackView(arrangedSubviews: calloutViews)
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
        
        view.addSubview(title)
        view.addSubview(scroll)
        view.addSubview(button)
        
        let margins = view.layoutMarginsGuide
        title.topAnchor ~~ margins.topAnchor + 32
        title.leadingAnchor ≥≥ margins.leadingAnchor
        title.trailingAnchor ≤≤ margins.trailingAnchor
        title.centerXAnchor ~~ view.centerXAnchor
        
        scroll.leadingAnchor ~~ margins.leadingAnchor + 16
        scroll.trailingAnchor ~~ margins.trailingAnchor - 16
        scroll.topAnchor ~~ title.bottomAnchor
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

