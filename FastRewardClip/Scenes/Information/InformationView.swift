//
//  InformationView.swift
//  FastRewardClip
//
//  Created by Asadbek Nematov on 6/15/24.
//

import SwiftUI
import Combine

struct InformationView: View {
    @Binding var selectedRewards: [Reward]
    @State private var selectedGender: String = ""
    @State private var dateOfBirth: String = ""
    @State private var phoneNumber: String = ""
    @State private var isDateOfBirthValid: Bool = true
    @State private var navigateToCodeGenerator = false

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter
    }

    init(selectedRewards: Binding<[Reward]>) {
        self._selectedRewards = selectedRewards

        // Customize the navigation bar appearance
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "backgroundT")
        appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "primaryT") ?? UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "primaryT") ?? UIColor.white]
        appearance.setBackIndicatorImage(UIImage(contentsOfFile: "ic_left_arrow"), transitionMaskImage: UIImage(contentsOfFile: "ic_left_arrow"))
        appearance.backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor(named: "primaryT") ?? UIColor.green]
        appearance.shadowColor = .clear // Remove the bottom shadow
        if let backButtonImage = UIImage(named: "ic_left_arrow") {
            appearance.setBackIndicatorImage(backButtonImage, transitionMaskImage: backButtonImage)
        }
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().tintColor = UIColor(named: "primaryT") // Set the back arrow color
    }

    var body: some View {
        NavigationStack {
            VStack {
                // Introductory Text
                Text("We require this info only once for account recovery purposes")
                    .font(.system(size: 14))
                    .foregroundColor(Color("secondaryT"))
                    .multilineTextAlignment(.center)
                    .padding(.top, 10)
                    .padding()
                    .padding(.horizontal, 20)

                // User Information Form
                VStack(alignment: .leading, spacing: 20) {
                    // Gender Selection
                    Text("Gender")
                        .font(.custom("Futura-Bold", size: 30))
                        .foregroundColor(Color("primaryT"))

                    HStack {
                        GenderButton(gender: "Male", icon: "ic_male", selectedIcon: "ic_male_selected", selectedGender: $selectedGender)
                        GenderButton(gender: "Female", icon: "ic_female", selectedIcon: "ic_female_selected", selectedGender: $selectedGender)
                    }
                    GenderButton(gender: "Other", icon: nil, selectedIcon: nil, selectedGender: $selectedGender)

                    // Date of Birth Picker
                    Text("Date of Birth")
                        .font(.custom("Futura-Bold", size: 30))
                        .foregroundColor(Color("primaryT"))

                    TextField("MM/DD/YYYY", text: $dateOfBirth)
                        .keyboardType(.numbersAndPunctuation)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(30)
                        .shadow(radius: 5)
                        .multilineTextAlignment(.center)
                        .onChange(of: dateOfBirth) {
                            self.dateOfBirth = self.limitInput(self.formatDateInput(dateOfBirth), to: 10)
                        }

                    if !isDateOfBirthValid {
                        Text("Please enter a valid date of birth")
                            .font(.caption)
                            .foregroundColor(.red)
                    }

                    // Phone Number Input
                    Text("Phone Number")
                        .font(.custom("Futura-Bold", size: 30))
                        .foregroundColor(Color("primaryT"))

                    HStack {
                        PhoneNumberTextFieldView(phoneNumber: $phoneNumber)
                            .frame(height: 30)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(30)
                            .multilineTextAlignment(.center)
                            .shadow(radius: 5)
                            .onChange(of: phoneNumber) {
                                self.phoneNumber = self.limitInput(phoneNumber, to: 17)
                            }
                    }
                }
                .padding(.horizontal, 20)

                Spacer()

                // Action Buttons
                HStack {
                    NavigationLink(destination: FinalPageView()) {
                        HStack {
                            Image("ic_left_arrow")
                                .padding(.horizontal)
                            Text("Later")
                                .font(.custom("Futura", size: 24))
                        }
                        .font(.title)
                        .padding()
                        .frame(width: 150, height: 60)
                        .foregroundColor(Color("primaryT"))
                        .cornerRadius(50)
                    }
                    .padding()

                    Button(action: {
                        self.isDateOfBirthValid = self.validateDateOfBirth(dateOfBirth)
                        if isDateOfBirthValid {
                            self.navigateToCodeGenerator = true
                        }
                    }) {
                        Text("Redeem")
                            .font(.custom("Futura", size: 24))
                            .padding()
                            .frame(width: 150, height: 60)
                            .background(Color("primaryT"))
                            .foregroundColor(.white)
                            .cornerRadius(50)
                    }
                    .padding()
                }
            }
            .background(Color("backgroundT").ignoresSafeArea())
            .onTapGesture {
                hideKeyboard()
            }
            .onAppear {
                print("InformationView appeared")
            }
            .onDisappear {
                print("InformationView disappeared")
            }
            .navigationDestination(isPresented: $navigateToCodeGenerator) {
                CodeGeneratorView(cart: $selectedRewards)
            }
        }
        .navigationBarTitle("Information", displayMode: .automatic)
    }

    private func formatDateInput(_ input: String) -> String {
        let digits = input.filter { $0.isNumber }
        let length = digits.count

        switch length {
        case 0...2:
            return digits
        case 3...4:
            let month = digits.prefix(2)
            let day = digits.suffix(length - 2)
            return "\(month)/\(day)"
        default:
            let month = digits.prefix(2)
            let day = digits.prefix(4).suffix(2)
            let year = digits.suffix(length - 4)
            return "\(month)/\(day)/\(year)"
        }
    }

    private func limitInput(_ input: String, to length: Int) -> String {
        return String(input.prefix(length))
    }

    private func validateDateOfBirth(_ input: String) -> Bool {
        guard let date = dateFormatter.date(from: input) else { return false }

        let calendar = Calendar.current
        let currentDate = Date()

        // Ensure the date is not in the future
        guard date <= currentDate else { return false }

        // Ensure the date is not before 1930
        let components = calendar.dateComponents([.year], from: date)
        if let year = components.year, year < 1930 {
            return false
        }

        return true
    }

    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct InformationView_Previews: PreviewProvider {
    @State static var selectedRewards: [Reward] = [
        Reward(name: "Free Pho Noodle", pointsRequired: 6, image: "reward5"),
        Reward(name: "Free Normal Size Spaghetti", pointsRequired: 6, image: "reward1")
    ]

    static var previews: some View {
        InformationView(selectedRewards: $selectedRewards)
    }
}
