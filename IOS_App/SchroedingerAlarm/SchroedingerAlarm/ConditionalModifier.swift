//
//  ConditionalModifier.swift
//  SchroedingerAlarm
//
//  Created by Monique Golnik on 26.01.22.
//

import Foundation
import SwiftUI
//generischer Modifier für spätere weitere Anwendungen
extension View {
    public func conditionalModifier<M1, M2>(condition: Bool, trueModifier: M1, falseModifier: M2) -> some View where M1: ViewModifier, M2: ViewModifier {
        Group {
            if condition {
                self.modifier(trueModifier)
            }else {
                self.modifier(falseModifier)
            }
        }
    }
}
