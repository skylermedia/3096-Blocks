//
//  User.swift
//  Merge
//
//  Created by Skyler Szijjarto on 3/7/23.
//

import SwiftUI
import CloudKit

class CloudKitUserViewModel: ObservableObject {
    
    @Published var isSignedInToiCloud: Bool = false
    @Published var error: String = ""
    
    init() {
        getiCloudStatus()
    }
    
    private func getiCloudStatus() {
        CKContainer.default().accountStatus { [weak self] returnedStatus, returnedError in
            DispatchQueue.main.async {
                switch returnedStatus {
                case .available:
                    self?.isSignedInToiCloud = true
                case .noAccount:
                    self?.error = CloudKitError.iCloudAccountNotFound.rawValue
                case .couldNotDetermine:
                    self?.error = CloudKitError.iCloudAccountNotDetermined.rawValue
                case .restricted:
                    self?.error = CloudKitError.iCloudAccountRestricted.rawValue
                default:
                    self?.error = CloudKitError.iCloudAccountUnknown.rawValue
                }
            }
        }
    }
    
    enum CloudKitError: String, LocalizedError {
        case iCloudAccountNotFound
        case iCloudAccountNotDetermined
        case iCloudAccountRestricted
        case iCloudAccountUnknown
    }
    
}

struct User: View {
    
    // MARK: - State Objects
    
    @StateObject private var vm = CloudKitUserViewModel()
    
    // MARK: Conformance to View Protocol
    
    var body: some View {
        VStack {
            Text("IS SIGNED IN: \(vm.isSignedInToiCloud.description.uppercased())")
            Text(vm.error)
        }
    }
}

// MARK: - Previews
struct CloudKitUser_Previews: PreviewProvider {
    static var previews: some View {
        User()
    }
}
