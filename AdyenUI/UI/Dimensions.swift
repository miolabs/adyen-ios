//
// Copyright (c) 2021 Adyen N.V.
//
// This file is open source and available under the MIT license. See the LICENSE file for more info.
//

import Adyen
import Foundation
import UIKit

@_spi(AdyenInternal)
public enum Dimensions {

    public static var leastPresentableScale: CGFloat = 0.25

    public static var greatestPresentableHeightScale: CGFloat = 0.9

    public static var maxAdaptiveWidth: CGFloat = 360

    public static var greatestPresentableScale: CGFloat {
        #if os(visionOS)
            return greatestPresentableHeightScale
        #else
            return UIDevice.current.userInterfaceIdiom == .phone && UIDevice.current.orientation.isLandscape ? 1 : greatestPresentableHeightScale
        #endif
    }

    public static func expectedWidth(for window: UIWindow? = nil) -> CGFloat {
        let containerSize = keyWindowSize(for: window)
        if UIDevice.current.userInterfaceIdiom == .pad {
            #if os(visionOS)
                return min(containerSize.width * (1 - leastPresentableScale), maxAdaptiveWidth * 2.0)
            #else
                return min(containerSize.width * (1 - leastPresentableScale), maxAdaptiveWidth * UIScreen.main.scale)
            #endif
        } else {
            return containerSize.width
        }
    }

    public static func keyWindowSize(for window: UIWindow? = nil) -> CGRect {
        guard let window = window ?? UIApplication.shared.adyen.mainKeyWindow else {
            #if os(visionOS)
                return CGRect(x: 0, y: 0, width: 1280, height: 720)
            #else
                return UIScreen.main.bounds
            #endif
        }
        return window.bounds
    }

}
