//
//  UIScrollView+Combine.swift
//  CombineCocoa
//
//  Created by Joan Disho on 09/08/2019.
//  Copyright © 2020 Combine Community. All rights reserved.
//

#if canImport(Combine) && os(iOS)
import UIKit
import Combine

// swiftlint:disable force_cast
@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
extension UIScrollView {
    /// A publisher emitting content offset changes from this UIScrollView.
    public var contentOffsetPublisher: AnyPublisher<CGPoint, Never> {
        publisher(for: \.contentOffset)
            .eraseToAnyPublisher()
    }

    /// A publisher emitting if the bottom of the UIScrollView is reached.
    ///
    /// - parameter offset: A threshold indicating how close to the bottom of the UIScrollView this publisher should emit.
    ///                     Defaults to 0
    /// - returns: A publisher that emits when the bottom of the UIScrollView is reached within the provided threshold.
    public func reachedBottomPublisher(offset: CGFloat = 0) -> AnyPublisher<Void, Never> {
        contentOffsetPublisher
            .map { [weak self] contentOffset -> Bool in
                guard let self else {
                    return false
                }
                let visibleHeight = self.frame.height - self.contentInset.top - self.contentInset.bottom
                let yDelta = contentOffset.y + self.contentInset.top
                let threshold = max(offset, self.contentSize.height - visibleHeight)
                return yDelta > threshold
            }
            .removeDuplicates()
            .filter { $0 }
            .map { _ in () }
            .eraseToAnyPublisher()
    }
    
    /// Combine wrapper for `scrollViewDidScroll(_:)`
    public var didScrollPublisher: AnyPublisher<Void, Never> {
        let selector = #selector(UIScrollViewDelegate.scrollViewDidScroll(_:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { _ in () }
            .eraseToAnyPublisher()
    }
    
    /// Combine wrapper for `scrollViewWillBeginDecelerating(_:)`
    public var willBeginDeceleratingPublisher: AnyPublisher<Void, Never> {
        let selector = #selector(UIScrollViewDelegate.scrollViewWillBeginDecelerating(_:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { _ in () }
            .eraseToAnyPublisher()
    }
    
    /// Combine wrapper for `scrollViewDidEndDecelerating(_:)`
    public var didEndDeceleratingPublisher: AnyPublisher<Void, Never> {
        let selector = #selector(UIScrollViewDelegate.scrollViewDidEndDecelerating(_:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { _ in () }
            .eraseToAnyPublisher()
    }
    
    /// Combine wrapper for `scrollViewWillBeginDragging(_:)`
    public var willBeginDraggingPublisher: AnyPublisher<Void, Never> {
        let selector = #selector(UIScrollViewDelegate.scrollViewWillBeginDragging(_:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { _ in () }
            .eraseToAnyPublisher()
    }
    
    /// Combine wrapper for `scrollViewWillEndDragging(_:withVelocity:targetContentOffset:)`
    public var willEndDraggingPublisher: AnyPublisher<(velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>), Never> {
        let selector = #selector(UIScrollViewDelegate.scrollViewWillEndDragging(_:withVelocity:targetContentOffset:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { values in
                let targetContentOffsetValue = values[2] as! NSValue
                let rawPointer = targetContentOffsetValue.pointerValue!
                
                return (values[1] as! CGPoint, rawPointer.bindMemory(to: CGPoint.self, capacity: MemoryLayout<CGPoint>.size))
            }
            .eraseToAnyPublisher()
    }
    
    /// Combine wrapper for `scrollViewDidEndDragging(_:willDecelerate:)`
    public var didEndDraggingPublisher: AnyPublisher<Bool, Never> {
        let selector = #selector(UIScrollViewDelegate.scrollViewDidEndDragging(_:willDecelerate:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { $0[1] as! Bool }
            .eraseToAnyPublisher()
    }
    
    /// Combine wrapper for `scrollViewDidZoom(_:)`
    public var didZoomPublisher: AnyPublisher<Void, Never> {
        let selector = #selector(UIScrollViewDelegate.scrollViewDidZoom(_:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { _ in () }
            .eraseToAnyPublisher()
    }
    
    /// Combine wrapper for `scrollViewDidScrollToTop(_:)`
    public var didScrollToTopPublisher: AnyPublisher<Void, Never> {
        let selector = #selector(UIScrollViewDelegate.scrollViewDidScrollToTop(_:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { _ in () }
            .eraseToAnyPublisher()
    }
    
    /// Combine wrapper for `scrollViewDidEndScrollingAnimation(_:)`
    public var didEndScrollingAnimationPublisher: AnyPublisher<Void, Never> {
        let selector = #selector(UIScrollViewDelegate.scrollViewDidEndScrollingAnimation(_:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { _ in () }
            .eraseToAnyPublisher()
    }
    
    /// Combine wrapper for `scrollViewWillBeginZooming(_:with:)`
    public var willBeginZoomingPublisher: AnyPublisher<UIView?, Never> {
        let selector = #selector(UIScrollViewDelegate.scrollViewWillBeginZooming(_:with:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { $0[1] as! UIView? }
            .eraseToAnyPublisher()
    }
    
    /// Combine wrapper for `scrollViewDidEndZooming(_:with:atScale:)`
    public var didEndZooming: AnyPublisher<(view: UIView?, scale: CGFloat), Never> {
        let selector = #selector(UIScrollViewDelegate.scrollViewDidEndZooming(_:with:atScale:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { ($0[1] as! UIView?, $0[2] as! CGFloat) }
            .eraseToAnyPublisher()
    }
    
    @objc var delegateProxy: DelegateProxy {
        ScrollViewDelegateProxy.createDelegateProxy(for: self)
    }
}

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
private class ScrollViewDelegateProxy: DelegateProxy, UIScrollViewDelegate, DelegateProxyType {
    func setDelegate(to object: UIScrollView) {
        object.delegate = self
    }
}
#endif
// swiftlint:enable force_cast

