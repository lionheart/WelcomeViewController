//
//  WelcomeCardView.swift
//  WelcomeViewController
//
//  Created by Dan Loewenherz on 2/26/18.
//

import UIKit
import SuperLayout

final class WelcomeCardView<T>: UIStackView where T: WelcomeCardProvider {
    init(_ type: T) {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        axis = .horizontal
        spacing = 16
        alignment = .center
        
        var image: UIImage?
        if let imageName = type.imageName {
            image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
        }
        
        let imageView = UIImageView(image: image)
        if let color = type.color {
            imageView.tintColor = color
        }
        
        let headlineAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.preferredFont(forTextStyle: .headline)
        ]
        let headlineString = NSAttributedString(string: type.title, attributes: headlineAttributes)
        
        let descriptionAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.preferredFont(forTextStyle: .subheadline)
        ]
        let descriptionString = NSAttributedString(string: "\n" + type.description, attributes: descriptionAttributes)
        
        let string = NSMutableAttributedString()
        string.append(headlineString)
        string.append(descriptionString)
        
        let label = UILabel()
        label.attributedText = string
        label.numberOfLines = 0
        
        addArrangedSubview(imageView)
        addArrangedSubview(label)
        
        imageView.heightAnchor ~~ 32
        imageView.widthAnchor ~~ 32
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
