//
//  SettingsView.swift
//  TVGuide
//
//  Created by Luis Capellan on 3/4/25.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    
    @AppStorage(AppStorageKeys.isPinLockEnabled.rawValue) private var isPinLockEnabled: Bool = false
    @AppStorage(AppStorageKeys.pinCode.rawValue) private var pinCode: String = "0000"
    @AppStorage(AppStorageKeys.isFaceIDEnabled.rawValue) private var isFaceIDEnabled: Bool = false

    @State private var isShowingPinSheet = false

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Security")) {
                    Toggle("Enable PIN Lock", isOn: $isPinLockEnabled)

                    if isPinLockEnabled {
                        Button(action: { isShowingPinSheet = true }) {
                            HStack {
                                Text("Set PIN (0000 is default)")
                                Spacer()
                                Text(pinCode.isEmpty ? "Not Set" : "●●●●")
                                    .foregroundColor(.gray)
                            }
                        }

                        Toggle("Enable Face ID", isOn: $isFaceIDEnabled)
                    }
                }
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
            }
            .sheet(isPresented: $isShowingPinSheet) {
                SetPinView(pinCode: $pinCode)
            }
        }
    }
}

struct SetPinView: View {
    @Binding var pinCode: String
    @State private var enteredPin: String = ""

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Enter a 4-digit PIN")
                    .font(.headline)
                
                SecureField("PIN", text: $enteredPin)
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .multilineTextAlignment(.center)
                    .frame(width: 150)
                
                HStack {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .foregroundColor(.red)

                    Spacer()

                    Button("Save") {
                        if enteredPin.count == 4 {
                            pinCode = enteredPin
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                    .disabled(enteredPin.count != 4)
                }
                .padding(.horizontal, 50)
            }
            .padding()
            .navigationTitle("Set PIN")
        }
    }
}
