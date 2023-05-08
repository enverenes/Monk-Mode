//
//  MailView.swift
//  Monk Mode
//
//  Created by Enver Enes Keskin on 2023-04-16.
//

import Foundation
import SwiftUI
import MessageUI


struct MailView: UIViewControllerRepresentable {
    @Binding var isShowing: Bool

    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let viewController = MFMailComposeViewController()
        viewController.setToRecipients(["support@weinteractive.online"])
        viewController.setSubject("My Feedback")
        viewController.setMessageBody("Feedback and suggestions.", isHTML: false)
        viewController.mailComposeDelegate = context.coordinator
        return viewController
    }

    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {
        // No need to update anything here.
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(isShowing: $isShowing)
    }

    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        @Binding var isShowing: Bool

        init(isShowing: Binding<Bool>) {
            _isShowing = isShowing
        }

        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            defer {
                isShowing = false
            }
            controller.dismiss(animated: true)
        }
    }
}
