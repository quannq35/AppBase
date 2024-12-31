//
//  String+Ext.swift
//  AppBase
//
//  Created by Quân Nguyễn on 31/12/24.
//

import UIKit

public extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    var trim: String {
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }
    
    var containsEmoji: Bool {
        for scalar in unicodeScalars {
            switch scalar.value {
            case 0x1F600...0x1FAF9, // Emoticons
                0x1F300...0x1F5FF, // Misc Symbols and Pictographs
                0x1F680...0x1F6FF, // Transport and Map
                0x1F1E6...0x1F1FF, // Regional country flags
                0x2600...0x26FF,   // Misc symbols 9728 - 9983
                0x2700...0x27BF,   // Dingbats
                0xFE00...0xFE0F,   // Variation Selectors
                0x1F900...0x1F9FF,  // Supplemental Symbols and Pictographs 129280 - 129535
                0x1F018...0x1F270, // Various asian characters           127000...127600
                65024...65039, // Variation selector
                9100...9300, // Misc items
                8400...8447: // Combining Diacritical Marks for Symbols
                return true
            default:
                continue
            }
        }
        return false
    }
    
    // MARK: Validate
    // swiftlint:disable implicit_getter
    var isBlank: Bool {
        get {
            let trimmed = trimmingCharacters(in: CharacterSet.whitespaces)
            return trimmed.isEmpty
        }
    }
    // swiftlint:enable implicit_getter
    
    var isEmail: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^[a-zA-Z0-9+._%-]{1,256}@[a-zA-Z0-9][a-zA-Z0-9-]{0,64}(\\.[a-zA-Z0-9][a-zA-Z0-9-]{1,24})+$", options: .caseInsensitive)
            return regex.firstMatch(in: self,
                                    options: NSRegularExpression.MatchingOptions(rawValue: 0),
                                    range: NSRange(location: 0, length: self.count)) != nil
        } catch {
            return false
        }
    }
    
    var isPhone: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^[0-9+]{0,1}+[0-9]{8,16}$", options: .caseInsensitive)
            return regex.firstMatch(in: self,
                                    options: NSRegularExpression.MatchingOptions(rawValue: 0),
                                    range: NSRange(location: 0, length: self.count)) != nil
        } catch {
            return false
        }
    }
    
    var isPhoneHyphen: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^[0-9+.-]{0,1}+[0-9.-]{8,16}$", options: .caseInsensitive)
            return regex.firstMatch(in: self,
                                    options: NSRegularExpression.MatchingOptions(rawValue: 0),
                                    range: NSRange(location: 0, length: self.count)) != nil
        } catch {
            return false
        }
    }
    
    var isPassword: Bool {
        let numberTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,}$")
        return numberTest.evaluate(with: self)
    }
    
    var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
    
    var isNumeric: Bool {
        return !isEmpty && range(of: "[0-9]", options: .regularExpression) == nil
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    func toDate(withFormat format: String = "dd/MM/yyyy HH:mm") -> Date? {
        let dateFormatter = DateFormatter()
//        dateFormatter.locale = Locale(identifier: "ja_JP")
        dateFormatter.dateFormat = format
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            return nil
        }
    }
    
    func timeToDate(withFormat format: String = "HH:mm") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            return nil
        }
    }
    
    func localToUTC() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = K.Format.dateTime
        dateFormatter.calendar = NSCalendar.current
        dateFormatter.timeZone = TimeZone.current
        let dt = dateFormatter.date(from: self)
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = K.Format.fullDate
        return dateFormatter.string(from: dt ?? Date())
    }
    
    func utcToLocal() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = K.Format.fullDate
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let dt = dateFormatter.date(from: self)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "yyyy/MM/dd"
        return dateFormatter.string(from: dt ?? Date())
    }
    
    func utcToLocalFullTime() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = K.Format.fullDate
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let dt = dateFormatter.date(from: self)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        return dateFormatter.string(from: dt ?? Date())
    }
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data,
                                          options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    var normalizedString: String {
        return folding(options: .diacriticInsensitive, locale: .current)
    }
    
}

extension RangeReplaceableCollection where Self: StringProtocol {
    var removeEmoji: Self {
        filter { !($0.unicodeScalars.first?.properties.isEmoji == true && !("0"..."9" ~= $0)) }
    }
}
