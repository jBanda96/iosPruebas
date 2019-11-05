//
//  SelectQuestionGroupViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 7/29/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import UIKit

class SelectQuestionGroupViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet internal var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView()
        }
    }
    
    // MARK: Properties
private let questionGroupTaker = QuestionGroupCaretaker()
    public var questionGroups: [QuestionGroup] {
        return questionGroupTaker.questionGroups
    }
    private var selectedQuestionGroup: QuestionGroup! {
        get { return questionGroupTaker.selectedQuestionGroup }
        set { questionGroupTaker.selectedQuestionGroup = newValue }
    }
    private let appSettings = AppSettings.shared

}

extension SelectQuestionGroupViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionGroups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionGroupCell", for: indexPath) as! QuestionGroupCell
        let questionGroup = questionGroups[indexPath.row]
        
        cell.titleLabel.text = questionGroup.title
        return cell
    }
}

extension SelectQuestionGroupViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedQuestionGroup = questionGroups[indexPath.row]
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let viewController = segue.destination as? QuestionsViewController else { return }
        viewController.questionStrategy = appSettings.questionStrategy(for: questionGroupTaker)
        viewController.delegate = self
    }
}

extension SelectQuestionGroupViewController: QuestionViewControllerProtocol {
    func questionViewController(_ viewController: QuestionsViewController, didCancel questionGroup: QuestionStrategy, at questionIndex: Int) {
        navigationController?.popToViewController(self, animated: true)
    }
    
    func questionViewController(_ viewController: QuestionsViewController, didComplete questionGroup: QuestionStrategy) {
        navigationController?.popToViewController(self, animated: true)
    }
}
