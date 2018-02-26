//
//  PlainButton.swift
//  WelcomeViewController
//
//  Created by Dan Loewenherz on 2/26/18.
//

import UIKit
import LionheartExtensions

final class PlainButton: UIButton {
    func setTitle2(_ title: String?, for state: UIControlState, size: CGFloat = 20) {
        guard let title = title else {
            setAttributedTitle(nil, for: state)
            return
        }
        
        let color: UIColor
        switch state {
        case .normal: color = .white
        case .highlighted: color = .lightGray
        default: color = .white
        }
        
        let attributes: [NSAttributedStringKey: Any] = [
            .font: UIFont.systemFont(ofSize: size, weight: .medium),
            .foregroundColor: color
        ]
        
        let string = NSAttributedString(string: title, attributes: attributes)
        setAttributedTitle(string, for: state)
    }
    
    init() {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        
        layer.cornerRadius = 13
        
        contentEdgeInsets = UIEdgeInsets(top: 12, left: 30, bottom: 12, right: 30)
        
        let color = UIColor(.RGB(0, 122, 255))
        setBackgroundImage(UIImage(color: color), for: .normal)
        setBackgroundImage(UIImage(color: .darkGray), for: .highlighted)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
