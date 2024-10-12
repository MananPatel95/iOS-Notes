//
//  UserDefaultsViewModel.swift
//  PersistantStorageUserDefKeyChain
//
//  Created by Manan Patel on 2024-09-02.
//

import Foundation

class UserDefaultsViewModel {
    init() {
        let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0]
        
        print("User defaults will be saved in the plist at this path: \(path) /Preferences/ in a .plist file")
    }
}
