//
//  CurrencySelectionViewController.swift
//  FakeNFT
//
//  Created by Алишер Дадаметов on 28.01.2024.
//

import UIKit

final class CurrencySelectionViewController: UIViewController {
    
    weak var delegate: PaymentSuccessDelegate?
    
    private let viewModel: CurrencySelectionViewModel
    
    private var currencyId = ""
    
    private let currencyCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var bottomPanel: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 375, height: 76)
        view.layer.cornerRadius = 12
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.backgroundColor = UIColor.segmentInactive
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var payButton: UIButton = {
        let button = UIButton()
        button.setTitle("Оплатить", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.backgroundColor = UIColor.ypBlack
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(payButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var agreementLabel: UILabel = {
        let label = UILabel()
        label.text = "Совершая покупку, вы соглашаетесть с условиями"
        label.font = .systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var linkLabel: UILabel = {
        let label = UILabel()
        label.text = "Пользовательского соглашения"
        label.font = .systemFont(ofSize: 13)
        label.textColor = UIColor(named: "YPBlueUniversal")
        let tapGesture = UITapGestureRecognizer(target: self, action:#selector(linkLabelTapped))
        label.addGestureRecognizer(tapGesture)
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(viewModel: CurrencySelectionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        configureNavigationBar()
        currencyCollectionView.dataSource = self
        currencyCollectionView.delegate = self
        currencyCollectionView.register(CurrencyCollectionViewCell.self, forCellWithReuseIdentifier: "CurrencyCell")
        addSubViews()
        setupConstraints()
        
        bindViewModel()
    }
    
    @objc private func payButtonTapped() {
        viewModel.makePayment(with: self.currencyId)
    }
    
    @objc private func linkLabelTapped() {
        viewModel.linkTapped { [weak self] url in
            let webVC = AgreementWebViewController()
            webVC.setURL(url)
            self?.navigationController?.pushViewController(webVC, animated: true)
        }
    }
    
    private func configureNavigationBar() {
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 17),
            .foregroundColor: UIColor.black
        ]
        navigationController?.navigationBar.titleTextAttributes = titleAttributes
        navigationItem.title = "Выберите способ оплаты"
        
        navigationController?.navigationBar.tintColor = .black
        
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
    
    private func bindViewModel() {
        
        viewModel.onCurrenciesLoaded = { [weak self] in
                self?.currencyCollectionView.reloadData()
            }
        
        viewModel.onPaymentSuccess = { [weak self] in
            let paymentSuccessVC = PaymentSuccessViewController()
            paymentSuccessVC.delegate = self?.delegate
            self?.navigationController?.pushViewController(paymentSuccessVC, animated: true)
        }

        viewModel.onError = { [weak self] error in
            self?.showRetryCancelAlert(message: "", retryAction: {
                self?.viewModel.makePayment(with: self?.currencyId ?? "")
            })
        }

    }
    
    private func addSubViews() {
        view.addSubview(currencyCollectionView)
        view.addSubview(bottomPanel)
        bottomPanel.addSubview(agreementLabel)
        bottomPanel.addSubview(linkLabel)
        bottomPanel.addSubview(payButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            currencyCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            currencyCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            currencyCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            currencyCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -186),
            
            bottomPanel.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomPanel.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -186),
            bottomPanel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomPanel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            agreementLabel.topAnchor.constraint(equalTo: bottomPanel.topAnchor, constant: 16),
            agreementLabel.leadingAnchor.constraint(equalTo: bottomPanel.leadingAnchor, constant: 16),
            agreementLabel.heightAnchor.constraint(equalToConstant: 18),
            
            linkLabel.topAnchor.constraint(equalTo: bottomPanel.topAnchor, constant: 38),
            linkLabel.leadingAnchor.constraint(equalTo: bottomPanel.leadingAnchor, constant: 16),
            linkLabel.heightAnchor.constraint(equalToConstant: 18),
            
            payButton.topAnchor.constraint(equalTo: bottomPanel.topAnchor, constant: 76),
            payButton.leadingAnchor.constraint(equalTo: bottomPanel.leadingAnchor,constant: 16),
            payButton.trailingAnchor.constraint(equalTo: bottomPanel.trailingAnchor, constant: -16),
            payButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}

//MARK: - UICollectionViewDataSource

extension CurrencySelectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.currencies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = currencyCollectionView.dequeueReusableCell(withReuseIdentifier: "CurrencyCell", for: indexPath) as? CurrencyCollectionViewCell else {
            assertionFailure("Не удалось извлечь и привести ячейку к типу CurrencyCollectionViewCell")
            return UICollectionViewCell()
        }
        
        let currency = viewModel.currencies[indexPath.row]
        cell.configure(with: currency)
        return cell
    }
}

//MARK: - UICollectionViewDelegate

extension CurrencySelectionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CurrencyCollectionViewCell {
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor.ypBlack.cgColor
            self.currencyId = String(indexPath.row)
            print(self.currencyId)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CurrencyCollectionViewCell {
            cell.layer.borderWidth = 0
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension CurrencySelectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.width - 39) / 2, height: 46)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 16, bottom: 20, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        7
    }
}

//MARK: - UIAlertController

extension CurrencySelectionViewController {

    func showRetryCancelAlert(message: String, retryAction: @escaping () -> Void) {
        let alert = UIAlertController(title: "Не удалось произвести оплату", message: message, preferredStyle: .alert)
        
        let retryAction = UIAlertAction(title: "Повторить", style: .default) { _ in
            retryAction()
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)

        alert.addAction(retryAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
}
