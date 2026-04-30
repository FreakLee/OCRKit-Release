//
//  ViewController.swift
//  OCRKitDemo
//
//  Created by min Lee on 2026/04/05.
//  Copyright © 2026 min Lee. All rights reserved.
//

import UIKit
import OCRKit

/// Demo 入口列表
final class ViewController: UITableViewController {

    private struct Demo {
        let title: String
        let icon: String
        let action: (ViewController) -> Void
    }

    private lazy var demos: [Demo] = {
        var list: [Demo] = [
        
            Demo(
                title: "银行卡",
                icon: "creditcard",
                action: { vc in
                    Task { [weak vc] in
                        guard let vc else { return }
                        do {
                            let result = try await OCRKitSDK.shared.scanBankCard(from: vc)
                            let info = result.info
                            vc.showScanResultPage(
                                title: "银行卡识别结果",
                                image: result.capturedImage,
                                items: [
                                    ("卡号（格式化）", info.cardNumber),
                                    ("卡号（纯数字）", info.rawCardNumber),
                                    ("发卡行", info.bankName ?? "未识别"),
                                    ("卡类型", info.cardType?.localizedName ?? "未识别"),
                                ]
                            )
                        } catch OCRError.cancelled {
                            // 用户取消，无需处理
                        } catch {
                            vc.showError(error)
                        }
                    }
                }
            ),
            Demo(
                title: "身份证正面",
                icon: "person.text.rectangle",
                action: { vc in
                    Task { [weak vc] in
                        guard let vc else { return }
                        do {
                            let result = try await OCRKitSDK.shared.scanIDCardFront(from: vc)
                            let info = result.info
                            vc.showScanResultPage(
                                title: "身份证正面识别结果",
                                image: result.capturedImage,
                                items: [
                                    ("姓名", info.name),
                                    ("性别", info.gender),
                                    ("民族", info.ethnicity),
                                    ("出生日期", info.birthDate),
                                    ("住址", info.address),
                                    ("身份证号", info.idNumber),
                                ]
                            )
                        } catch OCRError.cancelled {
                            // 用户取消，无需处理
                        } catch {
                            vc.showError(error)
                        }
                    }
                }
            ),
            Demo(
                title: "身份证背面",
                icon: "camera.viewfinder",
                action: { vc in
                    Task { [weak vc] in
                        guard let vc else { return }
                        do {
                            let result = try await OCRKitSDK.shared.scanIDCardBack(from: vc)
                            let info = result.info
                            vc.showScanResultPage(
                                title: "身份证背面识别结果",
                                image: result.capturedImage,
                                items: [
                                    ("签发机关", info.issuingAuthority),
                                    ("有效期限", info.validityPeriod),
                                    ("是否长期", info.isLongTerm ? "是" : "否"),
                                ]
                            )
                        } catch OCRError.cancelled {
                            // 用户取消，无需处理
                        } catch {
                            vc.showError(error)
                        }
                    }
                }
            ),
            Demo(
                title: "二维码/条形码",
                icon: "viewfinder",
                action: { vc in
                    Task { [weak vc] in
                        guard let vc else { return }
                        do {
                            let result = try await OCRKitSDK.shared.scanQRCode(from: vc)
                            let info = result.info
                            vc.showScanResultPage(
                                title: "二维码识别结果",
                                image: result.capturedImage,
                                items: [
                                    ("码内容", info.payload),
                                    ("码制名称", info.symbology),
                                ]
                            )
                        } catch OCRError.cancelled {
                            // 用户取消，无需处理
                        } catch {
                            vc.showError(error)
                        }
                    }
                }
            ),
        ]
        return list
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "OCRKit Demo"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 72
        
        // 开启 OCRKit 调试日志
        //OCRLogger.level = .debug
    }

    // MARK: - UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        demos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let demo = demos[indexPath.row]
        var config = UIListContentConfiguration.subtitleCell()
        config.text = demo.title
        config.image = UIImage(systemName: demo.icon)
        config.imageProperties.tintColor = .systemBlue

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.contentConfiguration = config
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    // MARK: - UITableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        demos[indexPath.row].action(self)
    }
}

// MARK: - Helpers

extension ViewController {

    func showError(_ error: Error) {
        let alert = UIAlertController(title: "识别失败", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "好", style: .default))
        present(alert, animated: true)
    }

    /// 展示扫描结果页面（带图片预览）
    func showScanResultPage(title: String, image: UIImage?, items: [(String, String)]) {
        let resultVC = UIViewController()
        resultVC.title = title
        resultVC.view.backgroundColor = .systemGroupedBackground

        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        resultVC.view.addSubview(scrollView)

        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stack)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: resultVC.view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: resultVC.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: resultVC.view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: resultVC.view.bottomAnchor),

            stack.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 16),
            stack.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -16),
            stack.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -16),
            stack.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor, constant: -32),
        ])

        // 图片预览
        if let img = image {
            let imageView = UIImageView(image: img)
            imageView.contentMode = .scaleAspectFit
            imageView.backgroundColor = .tertiarySystemGroupedBackground
            imageView.layer.cornerRadius = 10
            imageView.clipsToBounds = true
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.63).isActive = true
            stack.addArrangedSubview(imageView)
        }

        // 结果行
        let card = UIView()
        card.backgroundColor = .secondarySystemGroupedBackground
        card.layer.cornerRadius = 10
        let cardStack = UIStackView()
        cardStack.axis = .vertical
        cardStack.spacing = 0
        cardStack.translatesAutoresizingMaskIntoConstraints = false
        card.addSubview(cardStack)
        NSLayoutConstraint.activate([
            cardStack.topAnchor.constraint(equalTo: card.topAnchor),
            cardStack.leadingAnchor.constraint(equalTo: card.leadingAnchor),
            cardStack.trailingAnchor.constraint(equalTo: card.trailingAnchor),
            cardStack.bottomAnchor.constraint(equalTo: card.bottomAnchor),
        ])

        for (i, (key, value)) in items.enumerated() {
            let row = makeResultRow(key: key, value: value)
            cardStack.addArrangedSubview(row)
            if i < items.count - 1 {
                let sep = UIView()
                sep.backgroundColor = .separator
                sep.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
                let wrapper = UIView()
                wrapper.addSubview(sep)
                sep.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    sep.leadingAnchor.constraint(equalTo: wrapper.leadingAnchor, constant: 16),
                    sep.trailingAnchor.constraint(equalTo: wrapper.trailingAnchor),
                    sep.topAnchor.constraint(equalTo: wrapper.topAnchor),
                    sep.bottomAnchor.constraint(equalTo: wrapper.bottomAnchor),
                ])
                cardStack.addArrangedSubview(wrapper)
            }
        }

        stack.addArrangedSubview(card)

        navigationController?.pushViewController(resultVC, animated: true)
    }

    private func makeResultRow(key: String, value: String) -> UIView {
        let row = UIView()
        row.heightAnchor.constraint(greaterThanOrEqualToConstant: 44).isActive = true

        let keyLabel = UILabel()
        keyLabel.text = key
        keyLabel.textColor = .secondaryLabel
        keyLabel.font = .systemFont(ofSize: 15)
        keyLabel.setContentHuggingPriority(.required, for: .horizontal)
        keyLabel.setContentCompressionResistancePriority(.required, for: .horizontal)

        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.textColor = .label
        valueLabel.font = .systemFont(ofSize: 15)
        valueLabel.textAlignment = .right
        valueLabel.numberOfLines = 0

        let hStack = UIStackView(arrangedSubviews: [keyLabel, valueLabel])
        hStack.axis = .horizontal
        hStack.spacing = 12
        hStack.alignment = .center
        hStack.translatesAutoresizingMaskIntoConstraints = false
        row.addSubview(hStack)

        NSLayoutConstraint.activate([
            hStack.topAnchor.constraint(equalTo: row.topAnchor, constant: 12),
            hStack.bottomAnchor.constraint(equalTo: row.bottomAnchor, constant: -12),
            hStack.leadingAnchor.constraint(equalTo: row.leadingAnchor, constant: 16),
            hStack.trailingAnchor.constraint(equalTo: row.trailingAnchor, constant: -16),
        ])

        return row
    }
}

