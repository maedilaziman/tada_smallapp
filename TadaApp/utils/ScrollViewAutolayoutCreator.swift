//
//  ScrollViewAutolayoutCreator.swift
//  TadaApp
//
//  Created by maedi laziman on 29/01/22.
//  Copyright © 2022 maedi laziman. All rights reserved.
//

import UIKit

class ScrollViewAutolayoutCreator {
    let contentView: UIView
    let scrollView: UIScrollView

    /**
     An initializer for `ScrollViewAutolayoutCreator` to allow easier vertical scrolling using autolayout and `UISCrollView`
     - parameters:
        - superView: A view to which our autolayout equipped scrollView should be added
     */
    init(superView: UIView, marginTop: CGFloat = 0.0) {
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false

        superView.addSubview(scrollView)
        scrollView.addSubview(contentView)

        // Constraint to bind view horizontally. We do not support our scrollView to scroll horizontally for the sake of simplicity
        //NSLayoutConstraint.activate([
        //    superView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        //    superView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        //    ])

        // Constraints to make UIScrollView working with autolayout so that it can expand in both directions as per the view added
        // For scrollView
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: superView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: superView.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: superView.topAnchor, constant: marginTop),
            scrollView.bottomAnchor.constraint(equalTo: superView.bottomAnchor)
            ])

        // For contentView
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
            ])
    }
    
    /**
     Utility method to constraint `ScrollView` subviews horizontally with specified horizontal padding
     - parameters:
        - views: A sequential array of views which should be constrained horizontally
        - horizontalPadding: A value of padding which should be applied at both horizontal ends
     - Attention: Calling this method is optional. You can also set up horizontal constraints manually if you want to add custom layout as opposed to the generic one added here
     */
    func addHorizontalConstraints(views: [UIView], horizontalPadding: CGFloat = 0.0) {
        views.forEach { view in
            NSLayoutConstraint.activate([
                view.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: horizontalPadding),
                view.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -horizontalPadding)
                ])
        }
    }

    /**
     Utility method to constraint `ScrollView` subviews horizontally with specified vertical padding
     - parameters:
     - views: A sequential array of views which should be constrained vertically
     - verticalPadding: A value of padding which should be applied at both vertical ends as well as between successive views
     - Attention: Calling this method is optional. You can also set up vertical constraints manually if you want to add custom layout as opposed to the generic one added here
     */
    func addVerticalConstraints(views: [UIView], verticalPadding: CGFloat = 10.0) {
        guard !views.isEmpty else {
            return
        }
        if views.count == 1, let view = views.first {
            NSLayoutConstraint.activate([
                view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: verticalPadding),
                view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -verticalPadding)
                ])
        } else {
            // Add top constraint to first view
            if let firstView = views.first {
                NSLayoutConstraint.activate([
                    firstView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: verticalPadding)
                    ])
            }

            // Add bottom constraint to first view
            if let lastView = views.last {
                NSLayoutConstraint.activate([
                    lastView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -verticalPadding)
                    ])
            }

            // Add constraints between remaining views. Remember that we already setup vertical constraints for topmost and bottommost views
            var temporaryViews = views
            var previousView = temporaryViews.first!

            temporaryViews.removeFirst()

            for view in temporaryViews {
                NSLayoutConstraint.activate([
                    view.topAnchor.constraint(equalTo: previousView.bottomAnchor, constant: verticalPadding),
                    ])
                previousView = view
            }
        }
    }

    /**
     Utility method to scroll `UIScrollView` all the way to top
     */
    func scrollToTop() {
        scrollView.setContentOffset(CGPoint(x: 0.0, y: -scrollView.contentInset.top), animated: true)
    }

    /**
     Utility method to scroll `UIScrollView` all the way to bottom
     */
    func scrollToBottom() {
        scrollView.setContentOffset(CGPoint(x: 0.0, y: scrollView.contentSize.height - scrollView.bounds.height), animated: true)
    }
}
