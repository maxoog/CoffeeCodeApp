import SwiftUI
import UIKit
import Core

extension View {
    public func hostingControllerSetup(_ setup: @escaping (HostingController) -> Void) -> some View {
        ZStack {
            ParentViewControllerFinder { viewController in
                guard let viewController = viewController as? HostingController else {
//                    assertionFailure("Missing parent HostingController!")
                    return
                }
                setup(viewController)
            }

            self
        }
    }
}

private struct ParentViewControllerFinder: UIViewControllerRepresentable {
    final class UIViewControllerType: UIViewController {
        var didMoveToParentCallback: ((UIViewController) -> Void)?

        override func didMove(toParent parent: UIViewController?) {
            super.didMove(toParent: parent)

            guard let parent else {
                return
            }

            didMoveToParentCallback?(parent)
        }
    }

    @WeakState private var parentVC: UIViewController?

    private let parentVCSetup: (UIViewController?) -> Void

    init(_ parentVCSetup: @escaping (UIViewController?) -> Void) {
        self.parentVCSetup = parentVCSetup
    }

    func makeUIViewController(context: Context) -> UIViewControllerType {
        let controller = UIViewControllerType()
        controller.didMoveToParentCallback = {
            parentVC = $0
        }
        return controller
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        guard let parentVC else {
            return
        }

        parentVCSetup(parentVC)
    }
}


