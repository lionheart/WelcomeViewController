//
//  WelcomeViewController.swift
//  WelcomeViewController
//
//  Created by Dan Loewenherz on 2/26/18.
//
import UIKit
import SuperLayout

public final class WelcomeViewController<T>: UIViewController where T: WelcomeCardProvider {
    var header: String?
    var buttonText: String?
    var calloutViews: [WelcomeCardView<T>] = []
    
    public init(header: String?, buttonText: String?, callouts: [T]) {
        super.init(nibName: nil, bundle: nil)
        
        self.header = header
        self.buttonText = buttonText ?? "Continue"
        
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
        title.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        title.text = header
        
        let stackView = UIStackView(arrangedSubviews: calloutViews)
        stackView.axis = .vertical
        stackView.spacing = 32
        stackView.translatesAutoresizingMaskIntoConstraints = false

        let button = PlainButton()
        button.setTitle2(buttonText, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(title)
        view.addSubview(stackView)
        view.addSubview(button)
        
        let margins = view.layoutMarginsGuide
        title.topAnchor ~~ margins.topAnchor + 32
        title.centerXAnchor ~~ view.centerXAnchor
        
        stackView.leadingAnchor ~~ margins.leadingAnchor + 8
        stackView.trailingAnchor ~~ margins.trailingAnchor - 8
        stackView.centerXAnchor ~~ view.centerXAnchor
        stackView.topAnchor ~~ title.bottomAnchor + 48
        
        button.leadingAnchor ~~ margins.leadingAnchor
        button.trailingAnchor ~~ margins.trailingAnchor
        button.bottomAnchor ~~ margins.bottomAnchor - 32
    }
}

