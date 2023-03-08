//
//  OnboardingView.swift
//  Merge
//
//  Created by Skyler Szijjarto on 3/4/23.
//

import SwiftUI
import CloudKit

struct OnboardingView: View {
    
    // MARK: - Environment
    
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    
    // MARK: - Properties
    
    // Onboarding States:
    /*
     0 – Welcome Screen
     1 – Name
     2 – Age
     3 – Gender
     4 – Account
     */
    
    @State var onboardingState: Int = 0
    let transition: AnyTransition = .asymmetric(
        insertion: .move(edge: .trailing),
        removal: .move(edge: .leading))
    
    // MARK: - Onboarding Inputs
    
    @State var name: String = ""
    @State var age: Double = 30
    @State var gender: String = ""
    @State var username: String = ""
    @State private var password = ""
    
    // MARK: - Alert
    
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    
    // MARK: - App Storage
    
    @AppStorage("name") var currentUserName: String?
    @AppStorage("age") var currentUserAge: Int?
    @AppStorage("gender") var currentUserGender: String?
    @AppStorage("username") var currentUserUsername: String = ""
    @AppStorage("signed_in") var currentUserSignedIn: Bool = false
    
    // MARK: - Colors
    
    private var inputTextColor: Color {
        colorScheme == .light ? .black : .black
    }
    
    private var buttonColor: Color {
        colorScheme == .light ? .white : .black
    }
    
    private var textColor: Color {
        colorScheme == .light ? .black : .white
    }
    
    // MARK: - Conformance to View Protocol
    
    var body: some View {
        ZStack {
            
            // Content
            ZStack {
                switch onboardingState {
                case 0:
                    welcomeSection
                        .transition(transition)
                case 1:
                    addNameSection
                        .transition(transition)
                case 2:
                    addAgeSection
                        .transition(transition)
                case 3:
                    addUsernameSection
                        .transition(transition)
//                case 4:
//                    accountSection
//                        .transition(transition)
                default:
                    RoundedRectangle(cornerRadius: 25)
                        .foregroundColor(.green)
                }
            }
            
            // Buttons
            VStack {
                Spacer()
                bottomButton
                
            }
            .padding(30)
        }
        .alert(isPresented: $showAlert, content: {
            return Alert(title: Text(alertTitle))
        })
    }
}

// MARK: - COMPONENTS

extension OnboardingView {
    
    private var bottomButton: some View {
        Text(onboardingState == 0 ? "SIGN UP" : onboardingState == 3 ? "FINISH" : "NEXT")
            .font(.headline)
            .foregroundColor(.purple)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(buttonColor)
            .cornerRadius(10)
            .animation(nil)
            .onTapGesture {
                handleNextButtonPressed()
            }
    }
    
    private var welcomeSection: some View {
        VStack(spacing: 40) {
            Spacer()
            Image("Icon")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .foregroundColor(textColor)
                .cornerRadius(25)
            Text("Reach The Highest Score")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundColor(textColor)
                .overlay(
                    Capsule(style: .continuous)
                        .frame(height: 3)
                        .offset(y: 5)
                        .foregroundColor(textColor)
                    , alignment: .bottom
                )
            Text("Combine the weather symbols to reach the highest score you can and beat other players on the leaderboard.")
                .fontWeight(.medium)
                .foregroundColor(textColor)
            Spacer()
            Spacer()
        }
        .multilineTextAlignment(.center)
        .padding(30)
    }
    
    private var addNameSection: some View {
        VStack(spacing: 20) {
            Spacer()
            Text("What is your name?")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(textColor)
            TextField("Your name here...", text: $name)
                .foregroundColor(inputTextColor)
                .font(.headline)
                .frame(height: 55)
                .padding(.horizontal)
                .background(buttonColor)
                .cornerRadius(10)
            Spacer()
            Spacer()
        }
        .padding(30)
    }
    
    private var addAgeSection: some View {
        VStack(spacing: 20) {
            Spacer()
            Text("What is your age?")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(textColor)
            Text("\(String(format: "%.0f", age))")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(textColor)
            Slider(value: $age, in: 2...100, step: 1)
                .accentColor(textColor)
            Spacer()
            Spacer()
        }
        .padding(30)
    }
    
    private var addUsernameSection: some View {
        VStack(spacing: 20) {
            Spacer()
            Text("Pick a username.")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(textColor)
            Text("Do not use personal information in your username (full name, phone number, etc…).")
                .font(.body.bold())
                .padding(.horizontal)
                .padding(.bottom, 10)
                .multilineTextAlignment(.center)
                .font(.body)
                .foregroundColor(textColor)
            TextField("Your username here...", text: $username)
                .foregroundColor(inputTextColor)
                .font(.headline)
                .frame(height: 55)
                .padding(.horizontal)
                .background(buttonColor)
                .cornerRadius(10)
            Spacer()
            Spacer()
        }
        .padding(30)
    }
    
    private var addGenderSection: some View {
        VStack(spacing: 20) {
            Spacer()
            Text(gender.count > 1 ? gender : "What is your prefered gender?")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            Picker("Select a Gender",
                   selection: $gender,
                   content: {
                Text("Male").tag("Male")
                    .font(.headline.bold())
                    .frame(height: 100)
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                Text("Female").tag("Female")
                    .font(.headline.bold())
                    .frame(height: 100)
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                Text("NonBinary").tag("Non-Binary")
                    .font(.headline.bold())
                    .frame(height: 100)
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                Text("Other").tag("Other")
                    .font(.headline.bold())
                    .frame(height: 100)
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
            } )
            .pickerStyle(.inline)
            
            Spacer()
            Spacer()
        }
        .padding(30)
    }
    
    private var accountSection: some View {
        VStack {
            TextField("Username", text: $username)
                .padding()
            
            SecureField("Password", text: $password)
                .padding()
            
            Button("Save") {
                saveAccount(username: username, password: password)
            }
            .padding()
        }
    }
    
}

// MARK: - FUNCTIONS

extension OnboardingView {
    
    func handleNextButtonPressed() {
        
        
        // CHECK INPUTS
        switch onboardingState {
        case 1:
            guard name.count >= 3 else {
                showAlert(title: "Your name must be at least 3 characters long! 😫")
                return
            }
        case 3:
            guard name.count >= 3 else {
                showAlert(title: "Your username must be at least 3 characters long! 😳")
                return
            }
            //        case 3:
            //            guard gender.count > 1 else {
            //                showAlert(title: "Please select a gender before moving forward! 😳")
            //                return
            //            }
        default:
            break
        }
        
        
        // GO TO NEXT SECTION
        if onboardingState == 3 {
            signIn()
        } else {
            withAnimation(.spring()) {
                onboardingState += 1
            }
        }
    }
    
    func signIn() {
        saveInformation(name: name, age: Int(age))
        currentUserName = name
        currentUserAge = Int(age)
        currentUserGender = gender
        currentUserUsername = username
        withAnimation(.spring()) {
            currentUserSignedIn = true
        }
    }
    
    func showAlert(title: String) {
        alertTitle = title
        showAlert.toggle()
    }
    
    func saveInformation(name: String, age: Int) {
        DispatchQueue.global().async {
            let record = CKRecord(recordType: "Accounts")
            record.setValue(name, forKey: "name")
            record.setValue(age, forKey: "age")
            
            let privateDatabase = CKContainer(identifier: "iCloud.szijjarto.WeatherMerge").privateCloudDatabase
            privateDatabase.save(record) { (savedRecord, error) in
                if let error = error {
                    print("Error saving information: \(error)")
                } else {
                    print("User information saved successfully!")
                }
            }
        }
    }
    
    func saveAccount(username: String, password: String) {
        DispatchQueue.global().async {
            let record = CKRecord(recordType: "Accounts")
            record.setValue(username, forKey: "username")
            record.setValue(password, forKey: "password")
            
            let privateDatabase = CKContainer(identifier: "iCloud.szijjarto.WeatherMerge").privateCloudDatabase
            privateDatabase.save(record) { (savedRecord, error) in
                if let error = error {
                    print("Error saving account: \(error)")
                } else {
                    print("Account saved successfully!")
                }
            }
        }
    }
    
}

// MARK: - Previews

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .ignoresSafeArea()
    }
}
