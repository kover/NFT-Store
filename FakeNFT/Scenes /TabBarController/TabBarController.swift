import UIKit

final class TabBarController: UITabBarController {

    var servicesAssembly: ServicesAssembly!

    private let catalogTabBarItem = UITabBarItem(
        title: NSLocalizedString("Tab.catalog", comment: ""),
        image: UIImage(systemName: "square.stack.3d.up.fill"),
        tag: 0
    )

    override func viewDidLoad() {
        super.viewDidLoad()

        let catalogController = CatalogViewController(
            viewModel: CatalogViewModel(serviceAssembly: servicesAssembly),
            serviceAssembly: servicesAssembly
        )
        catalogController.tabBarItem = catalogTabBarItem

        let navigationController = UINavigationController()
        navigationController.viewControllers = [catalogController]

        viewControllers = [navigationController]

        view.backgroundColor = .systemBackground
    }
}
