//
//  WelcomeItem.swift
//  WelcomeViewController
//
//  Created by Dan Loewenherz on 2/26/18.
//

import UIKit

public protocol WelcomeCardProvider {
    /// An optional image for the card.
    var imageName: String? { get }
    
    /// An optional color to tint the image with.
    var color: UIColor? { get }

    /// The title for the card.
    var title: String { get }
    
    /// The description for the card.
    var description: String { get }
}
