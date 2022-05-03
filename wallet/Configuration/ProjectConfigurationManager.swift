//
//  ProjectConfigurationManager.swift
//  wallet
//
//  Created by Kevin Campuzano on 1/14/22.
//

import Foundation
private let kProjectConfigFileName = "ProjectConfiguration"
private let kProjectFileExtension = "plist"

typealias ProjectInfoDictionary = Dictionary<String, AnyObject>

class ProjectConfigurationManager {
    
    // MARK: - Shared instance
    static let shared = ProjectConfigurationManager()
    
    // MARK: - Private properties
    fileprivate var projectConfigDictionary: ProjectInfoDictionary
    
    // MARK: - Private initialization
    fileprivate init() {
        let projectConfigFilePath = Bundle.init(for: ProjectConfigurationManager.self).path(forResource: kProjectConfigFileName, ofType: kProjectFileExtension)
        let projectConfigPlistDictionary = NSDictionary(contentsOfFile: projectConfigFilePath!)
        self.projectConfigDictionary = projectConfigPlistDictionary as! ProjectInfoDictionary
    }
    
    // MARK: - Internal properties
    
    var url: String {
        guard let urlString = projectConfigDictionary["URL"] as? String else {
            fatalError("Missing URL")
        }
        return urlString
    }
    
    
    var decimalMask: String {
        if let mask = projectConfigDictionary["DecimalMask"] as? String {
            return mask
        }
        return "."
    }
    
    var integerMask: String {
        if let mask = projectConfigDictionary["IntegerMask"] as? String {
            return mask
        }
        return ","
    }
    
    var maxLength: Int {
        if let max = projectConfigDictionary["MaxLength"] as? Int {
            return max
        }
        return 15
    }
    
    var decimalMaxLength: Int {
        if let max = projectConfigDictionary["DecimalMaxLength"] as? Int {
            return max
        }
        return 2
    }
    
    var decimalMaxLengthCuotapartes: Int {
        if let max = projectConfigDictionary["DecimalFourLength"] as? Int {
            return max
        }
        return 4
    }
    
    var integerMaxLength: Int {
        if let max = projectConfigDictionary["IntegerMaxLength"] as? Int {
            return max
        }
        return 10
    }
    
    var accessibilityAbbreviations: Dictionary<String, String> {
        if let accessibilityAbbreviations = projectConfigDictionary["AccessibilityAbbreviations"] as? Dictionary<String, String> {
            return accessibilityAbbreviations
        }
        return [:]
    }
    
}
