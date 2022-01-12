//
//  MessageInputView.swift
//  SwiftRCON
//
//  Created by LeeSeGun on 2022/01/12.
//

import UIKit

class MessageInputView: UIControl {

    // MARK: - Initialize
    required public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init() {
        super.init(frame: .zero)
        setup()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    open func setup() {
        setupOwnHeight()
        setupTextView()
        setupSendButton()
        setupBorder()
        setupGesuture()
    }
    
    
    // MARK: - Public
    internal var message: String = "" {
        didSet {
            guard !message.isEmpty else { return }
            sendMessages.append(message)
        }
    }
    private var sendMessages = [String]()
    private var historyIndex = NSNotFound
    
    
    // MAKR: - Growing Height Stuff
    private var heightConstraint: NSLayoutConstraint?
    private var minHeight = 47.0
    private var maxHeight = 150.0

    
    // MARK: - TextView Stuff
    private lazy var textView: UITextView = {
        let t = UITextView()
        t.translatesAutoresizingMaskIntoConstraints = false
        t.font = .systemFont(ofSize: 14)
        t.textColor = .darkGray
        t.textContainerInset = UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 55)
        return t
    }()
    
    
    // MARK: - Send Button
    private lazy var sendButton: MessageSendButton = {
        let b = MessageSendButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
}


extension MessageInputView {
    private func setupOwnHeight() {
        heightConstraint = heightAnchor.constraint(equalToConstant: minHeight)
        heightConstraint?.isActive = true
    }
}

extension MessageInputView: UITextViewDelegate {
    private func setupTextView() {
        addSubview(textView)
        textView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        textView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        textView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        textView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        textView.delegate = self
    }
    
    func textViewDidChange(_ textView: UITextView) {
        sendButton.isEnabled = textView.text.count > 0
        let size = textView.sizeThatFits(CGSize(width: textView.bounds.width, height: .infinity))
        heightConstraint?.constant = size.height < maxHeight ? size.height : maxHeight
        sendActions(for: .valueChanged)
    }
}


extension MessageInputView {
    private func setupSendButton() {
        addSubview(sendButton)
        sendButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 35).isActive = true
        sendButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        sendButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        sendButton.isEnabled = false
        sendButton.addTarget(self, action: #selector(didTapSendButton(_:)), for: .touchUpInside)
    }
    
    @objc private func didTapSendButton(_ button: MessageSendButton) {
        message = textView.text
        textView.text = nil
        textViewDidChange(textView)
        sendActions(for: .primaryActionTriggered)
    }
}


extension MessageInputView {
    private func setupBorder() {
        let border = UIView()
        border.backgroundColor = .lightGray
        border.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: 0.5)
        addSubview(border)
    }
}


extension MessageInputView {
    private func setupGesuture() {
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        swipe.direction = [.up, .down]
        addGestureRecognizer(swipe)
    }
    
    @objc private func handleSwipeGesture(_ gesture: UISwipeGestureRecognizer) {
        guard !sendMessages.isEmpty else { return }
        switch gesture.direction {
        case .up:
            print(sendMessages[historyIndex])
        case .down:
            print(sendMessages[historyIndex])
        default:
            break
        }
    }
}



class MessageSendButton: UIButton {
    
    // MARK: -
    override var isEnabled: Bool {
        didSet {
            UIView.animate(withDuration: 0.25) {
                self.alpha = self.isEnabled ? 1 : 0.3
            }
        }
    }
    
    
    // MARK: -
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    
    func setup() {
        setImage(UIImage(named: "SendArrow"), for: .normal)
        setImage(UIImage(named: "SendArrow"), for: .selected)
        setImage(UIImage(named: "SendArrow"), for: .disabled)
        backgroundColor = .blue.withAlphaComponent(0.5)
    }

    
    // MARK: -
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.width / 2
        layer.masksToBounds = true
    }
}
