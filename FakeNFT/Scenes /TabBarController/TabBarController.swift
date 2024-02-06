import UIKit

final class TabBarController: UITabBarController {

    var servicesAssembly: ServicesAssembly!

    private let catalogTabBarItem = UITabBarItem(
        title: NSLocalizedString("Tab.catalog", comment: ""),
        image: UIImage(systemName: "square.stack.3d.up.fill"),
        tag: 0
    )
    
    private let cartTabBarItem: UITabBarItem = {
        let normalIcon = UIImage(named: "cartInactive")
        let selectedIcon = UIImage(named: "cartActive")
        let item = UITabBarItem(
            title: NSLocalizedString("Tab.cart", comment: ""),
            image: normalIcon,
            selectedImage: selectedIcon
        )
        item.tag = 1
        return item
    }()

    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let catalogController = TestCatalogViewController(
            servicesAssembly: servicesAssembly
        )
        catalogController.tabBarItem = catalogTabBarItem
        
        let cartViewModel: CartViewModelProtocol = CartViewModel(serviceAssembly: servicesAssembly)
        let cartController = CartViewController(viewModel: cartViewModel, serviceAssembly: servicesAssembly)

        cartController.tabBarItem = cartTabBarItem
        
        let cartNavController = UINavigationController(rootViewController: cartController)

        viewControllers = [catalogController, cartNavController]

        view.backgroundColor = .systemBackground
    }
}
