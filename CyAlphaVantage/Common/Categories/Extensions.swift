//
//  Extensions.swift
//  CyAlphaVantage
//
//  Created by Lucy on 15/01/21.
//

import Foundation
import UIKit

extension UIView {
    func loadViewFromNIB() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: classForCoder), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView

        return view
    }

    static func getViewFromNib(bundle bdl: Bundle? = nil, nibName strNibName: String? = nil, tag intTag: Int) -> UIView? {
        let nib: UINib

        if let strNibName = strNibName {
            if let bdl = bdl {
                nib = UINib(nibName: strNibName, bundle: bdl)
            } else {
                nib = UINib(nibName: strNibName, bundle: Bundle(for: classForCoder()))
            }
        } else {
            if let bdl = bdl {
                nib = UINib(nibName: String(describing: classForCoder()), bundle: bdl)
            } else {
                nib = UINib(nibName: String(describing: classForCoder()), bundle: Bundle(for: classForCoder()))
            }
        }

        let obj = nib.instantiate(withOwner: nil, options: nil)

        for vw in obj {
            if let vw = vw as? UIView {
                if intTag == -1 {
                    if vw.isKind(of: classForCoder()) {
                        return vw
                    }
                } else {
                    if vw.tag == intTag {
                        return vw
                    }
                }
            }
        }

        return nil
    }
}

extension UIStoryboard {
    static func getMainStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
}

extension UIFont {
    static func printAllFonts() {
        for familyName in UIFont.familyNames as [String] {
            print("\(familyName)")
            for fontName in UIFont.fontNames(forFamilyName: familyName) as [String] {
                print("\tFont: \(fontName)")
            }
        }
    }
}

extension String {
    func formatDegree() -> String {
        let str: String = self + "°C"
        return str
    }

    func imageName() -> String {
        switch lowercased() {
        case "clouds":
            return "cloud.fill"
        case "clear":
            return "moon.stars.fill"
        default:
            return "cloud.fill"
        }
    }
}

extension UIViewController {}

extension Date {
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }

    func getDate(dayDifference: Int) -> Date {
        var components = DateComponents()
        components.day = dayDifference
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }

    func getDatebyHour(dayDifference: Int) -> Date {
        var components = DateComponents()
        components.hour = dayDifference
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }
}

extension UIImageView {
    func setImageColor(color: UIColor) {
        let templateImage = image?.withRenderingMode(.alwaysTemplate)
        image = templateImage
        tintColor = color
    }
}

extension Data {
    init<T>(from value: T) {
        var value = value
        self.init(buffer: UnsafeBufferPointer(start: &value, count: 1))
    }

    func to<T>(type _: T.Type) -> T {
        return withUnsafeBytes { $0.load(as: T.self) }
    }
}
