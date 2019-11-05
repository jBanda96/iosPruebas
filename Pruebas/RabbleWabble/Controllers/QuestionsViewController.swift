//
//  QuestionsViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 7/28/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import UIKit

protocol QuestionViewControllerProtocol: class {
    func questionViewController(_ viewController: QuestionsViewController, didCancel questionGroup: QuestionStrategy, at questionIndex: Int)
    
    func questionViewController(_ viewController: QuestionsViewController, didComplete questionGroup: QuestionStrategy)
}

class QuestionsViewController: UIViewController {

    private lazy var questionIndexItem: UIBarButtonItem = {
        let item = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        item.tintColor = .black
        navigationItem.rightBarButtonItem = item
        
        return item
    }()
    
    public var questionIndex = 0
    
    public var correctCount = 0
    public var incorrectCount = 0
    
    public weak var delegate: QuestionViewControllerProtocol?
    
    public var questionStrategy: QuestionStrategy! {
        didSet {
            navigationItem.title = questionStrategy.title
        }
    }
    
    public var questionView: QuestionView! {
        guard isViewLoaded else { return nil }
        return (view! as! QuestionView)
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCancelButton()
        self.showQuestion()
    }
    
    private func showQuestion() {
        let question = questionStrategy.currentQuestion()
        
        questionView.answerLabel.text = question.answer
        questionView.promptLabel.text = question.prompt
        questionView.hintLabel.text = question.hint
        
        questionView.answerLabel.isHidden = true
        questionView.hintLabel.isHidden = true
        
        questionIndexItem.title = questionStrategy.questionIndexTitle()
    }
    
    func setupCancelButton() {
        let action = #selector(handleCancelPressed(sender:))
        let image = UIImage(named: "ic_menu")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: action)
    }
    
    @IBAction func toggleAnswerLabels(_ sender: Any) {
            self.questionView.answerLabel.isHidden = !self.questionView.answerLabel.isHidden
            self.questionView.hintLabel.isHidden = !self.questionView.hintLabel.isHidden
            
    }
    
    @IBAction func handleCorrect(_ sender: Any) {
        let question = questionStrategy.currentQuestion()
        questionStrategy.markQuestionCorrect(question)
        
        questionView.correctCountLabel.text = "\(questionStrategy.correctCount)"
        showNextQuestion()
    }
    
    @IBAction func handleInorrect(_ sender: Any) {
        let question = questionStrategy.currentQuestion()
        questionStrategy.markQuestionIncorrect(question)
        
        questionView.incorrectCountLabel.text = "\(questionStrategy.incorrectCount)"
        showNextQuestion()
    }
    
    private func showNextQuestion() {
        questionIndex += 1
        guard questionStrategy.advanceToNextQuestion() else {
            delegate?.questionViewController(self, didComplete: questionStrategy)
            return
        }
        showQuestion()
    }
    
    @objc private func handleCancelPressed(sender: UIBarButtonItem) {
        delegate?.questionViewController(self, didCancel: questionStrategy, at: questionIndex)
    }
    
}
