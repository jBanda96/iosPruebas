//
//  QuestionsViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 7/28/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import UIKit

protocol QuestionViewControllerProtocol: class {
    func questionViewController(_ viewController: QuestionsViewController, didCancel questionGroup: QuestionGroup, at questionIndex: Int)
    
    func questionViewController(_ viewController: QuestionsViewController, didComplete questionGroup: QuestionGroup)
}

class QuestionsViewController: UIViewController {

    private lazy var questionIndexItem: UIBarButtonItem = {
        let item = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        item.tintColor = .black
        navigationItem.rightBarButtonItem = item
        
        return item
    }()
    
    public var questionGroup: QuestionGroup! {
        didSet {
            navigationItem.title =  questionGroup.title
        }
    }
    public var questionIndex = 0
    
    public var correctCount = 0
    public var incorrectCount = 0
    
    public weak var delegate: QuestionViewControllerProtocol?
    
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
        let question = questionGroup.questions[questionIndex]
        
        questionView.answerLabel.text = question.answer
        questionView.promptLabel.text = question.prompt
        questionView.hintLabel.text = question.hint
        
        questionView.answerLabel.isHidden = true
        questionView.hintLabel.isHidden = true
        
        questionIndexItem.title = "\(questionIndex + 1)/\(questionGroup.questions.count)"
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
        correctCount += 1
        questionView.correctCountLabel.text = "\(correctCount)"
        showNextQuestion()
    }
    
    @IBAction func handleInorrect(_ sender: Any) {
        incorrectCount += 1
        questionView.incorrectCountLabel.text = "\(incorrectCount)"
        showNextQuestion()
    }
    
    private func showNextQuestion() {
        questionIndex += 1
        guard questionIndex < questionGroup.questions.count else {
            delegate?.questionViewController(self, didComplete: questionGroup)
            return
        }
        showQuestion()
    }
    
    @objc private func handleCancelPressed(sender: UIBarButtonItem) {
        delegate?.questionViewController(self, didCancel: questionGroup, at: questionIndex)
    }
    
}
