//
//  KeychainService.swift
//  VKClient
//
//  Created by Alex on 26.03.2022.
//

import Foundation
import Security

protocol KeyChainService {
    func saveToken(token: String, key: String)
    func getToken(token: String) -> String?
    func deleteToken(token: String)
}

final class KeychainServiceImpl: KeyChainService {

    func saveToken(token: String, key: String) {
        let data = key.data(using: String.Encoding.utf8)!
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrAccount as String: token,
                                    kSecValueData as String: data]

        SecItemDelete(query as CFDictionary)
        SecItemAdd(query as CFDictionary, nil)
    }

    func getToken(token: String) -> String? {
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrAccount as String: token,
                                    kSecMatchLimit as String: kSecMatchLimitOne,
                                    kSecReturnData as String: true]

        var item: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &item)

        var key: String?

        if status == errSecSuccess {
            if let retrivedData = item as? Data {
                key = String(data: retrivedData, encoding: String.Encoding.utf8)
            }
        } else {
            print("Nothing was retrieved from the keychain. Status code \(status)")
        }
        return key
    }

    func deleteToken(token: String) {
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrAccount as String: token]

        SecItemDelete(query as CFDictionary )
    }
}
