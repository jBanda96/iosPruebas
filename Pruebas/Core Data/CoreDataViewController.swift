//
//  CoreDataViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 06/05/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

import UIKit
import CoreData



class CoreDataViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var fetchRC: NSFetchedResultsController<Friend>!
    
    var query: String = ""
    
    lazy var searchController: UISearchController = {
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Friends"
        search.hidesNavigationBarDuringPresentation = false
        
        return search
    }()
    
    //CoreData properties
    private let appDelegate =   UIApplication.shared.delegate as! AppDelegate
    private let context     =   (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        readFromCoreData()
        
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
    }
    
    @IBAction func addName(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "New Name",
                                      message: "Add a new name",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save",
                                       style: .default) {
                                        [unowned self] action in
                                        
                                        guard let textField = alert.textFields?.first,
                                            let nameToSave = textField.text else {
                                                return
                                        }
                                        
                                        self.save(name: nameToSave)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel)
        
        alert.addTextField()
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    
    func save(name: String) {
        let friend = Friend(entity: Friend.entity(), insertInto: context)
        friend.name = name
        friend.address = "Address for \(name)"
        
        appDelegate.saveContext()
        
        readFromCoreData()
    }
    
    fileprivate func readFromCoreData() {
        
        let request =   Friend.fetchRequest() as NSFetchRequest
        let sort    =   NSSortDescriptor(key: "name", ascending: true)
        //let name    =   NSSortDescriptor(key: #keyPath(Friend.name), ascending: true)
        
        if !query.isEmpty {
            request.predicate = NSPredicate(format: "name CONTAINS[cd] %@", searchController.searchBar.text!)
        }
        
        request.sortDescriptors = [sort]
        
        do {
            fetchRC = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: #keyPath(Friend.name), cacheName: nil)
            try fetchRC.performFetch()
            tableView.reloadData()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func saveAndSeePets(of friend: Friend, in indexPath: IndexPath){
        
//        let formatter = DateFormatter()
//        formatter.dateFormat = "d MMM yyyy"
//        let fetchResultController: NSFetchedResultsController<Pets>!
//
//        let pet = Pets(entity: Pets.entity(), insertInto: context)
//        pet.dob = Date()
//        pet.kind = nil
//        pet.name = "Roger"
//        pet.picture = ""
//        pet.owner = friend
//        appDelegate.saveContext()
//
//        let request = Pets.fetchRequest() as NSFetchRequest<Pets>
//        request.predicate = NSPredicate(format: "owner = %@", friend)
//        let sort = NSSortDescriptor(keyPath: \Pets.name, ascending: true)
//        request.sortDescriptors = [sort]
//
//        do {
//            fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
//            try fetchResultController.performFetch()
//        } catch {
//            print(error.localizedDescription)
//        }
//
//        fetchResultController.fetchedObjects?.forEach {
//            print($0.name)
//        }

        
        context.delete(friend)
        appDelegate.saveContext()
        readFromCoreData()
        
    }
    
}


extension CoreDataViewController: UITableViewDataSource, UITableViewDelegate {
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return fetchRC.sections?.count ?? 0
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//        guard let sections = fetchRC.sections,
//            let objects = sections[section].objects else { return 0 }
//
//        return objects.count
        
        return fetchRC.fetchedObjects?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = fetchRC.object(at: indexPath).name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        saveAndSeePets(of: fetchRC.object(at: indexPath), in: indexPath)
    }
    
}

//extension CoreDataViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44))
//        return label
//    }
//}

extension CoreDataViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        query = searchController.searchBar.text ?? ""
        readFromCoreData()
    }
}






//class CoreDataViewController: UIViewController {
//
//@IBOutlet weak var tableView: UITableView!
//
//    var people: [NSManagedObject] = []
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.title = "The list"
//
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//        let managedContext = appDelegate.persistentContainer.viewContext
//
//        let fecthRequest = NSFetchRequest<NSManagedObject>(entityName: "Person1")
//
//        do {
//            people = try managedContext.fetch(fecthRequest)
//        } catch let error as NSError {
//            print("Could not fetch. \(error), \(error.userInfo)")
//        }
//
//    }
//
//    @IBAction func addName(_ sender: UIBarButtonItem) {
//        let alert = UIAlertController(title: "New Name",
//                                      message: "Add a new name",
//                                      preferredStyle: .alert)
//
//        let saveAction = UIAlertAction(title: "Save",
//                                       style: .default) {
//                                        [unowned self] action in
//
//                                        guard let textField = alert.textFields?.first,
//                                            let nameToSave = textField.text else {
//                                                return
//                                        }
//
//                                        self.save(name: nameToSave)
//                                        self.tableView.insertRows(at: [IndexPath(row: self.people.count - 1, section: 0)], with: .automatic)
//        }
//
//        let cancelAction = UIAlertAction(title: "Cancel",
//                                         style: .cancel)
//
//        alert.addTextField()
//
//        alert.addAction(saveAction)
//        alert.addAction(cancelAction)
//
//        present(alert, animated: true)
//    }
//
//    func save(name: String) {
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//
//        let managedContext = appDelegate.persistentContainer.viewContext
//        let entity = NSEntityDescription.entity(forEntityName: "Person1", in: managedContext)!
//        let person = NSManagedObject(entity: entity, insertInto: managedContext)
//
//        person.setValue(name, forKey: "name")
//
//        do {
//            try managedContext.save()
//            people.append(person)
//        } catch {
//            print("Could not save. \(error.localizedDescription), \(String(describing: error._userInfo))")
//        }
//    }
//
//}
//
//
//extension CoreDataViewController: UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return people.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        let person = people[indexPath.row]
//
//        cell.textLabel?.text = person.value(forKeyPath: "name") as? String
//
//        return cell
//    }
//
//}


import SystemConfiguration
import Foundation

class NetworkManager: NSObject {
    var reachability: Reachability!
    
    static let sharedInstance: NetworkManager = {
        return NetworkManager()
    }()
    
    override init() {
        super.init()
        
        reachability = Reachability()!
        
        NotificationCenter.default.addObserver(self, selector: #selector(networkStatusChanged(_:)), name: .reachabilityChanged, object: reachability)
        
        do {
            try reachability.startNotifier()
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    @objc private func networkStatusChanged(_ notification: Notification){
        guard let object = notification.object as? Reachability else { return }
        print(object.connection)
    }
    
    static func isReachable(complete: @escaping (NetworkManager) -> Void){
        if (NetworkManager.sharedInstance.reachability).connection != .none {
            complete(NetworkManager.sharedInstance)
        }
    }
    
    static func isUnreachable(completed: @escaping (NetworkManager) -> Void) {
        if (NetworkManager.sharedInstance.reachability).connection == .none {
            completed(NetworkManager.sharedInstance)
        }
    }
    
    static func isReachableViaWWAN(completed: @escaping (NetworkManager) -> Void) {
        if (NetworkManager.sharedInstance.reachability).connection == .cellular {
            completed(NetworkManager.sharedInstance)
        }
    }
    
    static func isReachableViaWiFi(completed: @escaping (NetworkManager) -> Void) {
        if (NetworkManager.sharedInstance.reachability).connection == .wifi {
            completed(NetworkManager.sharedInstance)
        }
    }
    
}

public enum ReachabilityError: Error {
    case FailedToCreateWithAddress(sockaddr_in)
    case FailedToCreateWithHostname(String)
    case UnableToSetCallback
    case UnableToSetDispatchQueue
    case UnableToGetInitialFlags
}

@available(*, unavailable, renamed: "Notification.Name.reachabilityChanged")
public let ReachabilityChangedNotification = NSNotification.Name("ReachabilityChangedNotification")

public extension Notification.Name {
    static let reachabilityChanged = Notification.Name("reachabilityChanged")
}

public class Reachability {
    
    public typealias NetworkReachable = (Reachability) -> ()
    public typealias NetworkUnreachable = (Reachability) -> ()
    
    @available(*, unavailable, renamed: "Connection")
    public enum NetworkStatus: CustomStringConvertible {
        case notReachable, reachableViaWiFi, reachableViaWWAN
        public var description: String {
            switch self {
            case .reachableViaWWAN: return "Cellular"
            case .reachableViaWiFi: return "WiFi"
            case .notReachable: return "No Connection"
            }
        }
    }
    
    public enum Connection: CustomStringConvertible {
        case none, wifi, cellular
        public var description: String {
            switch self {
            case .cellular: return "Cellular"
            case .wifi: return "WiFi"
            case .none: return "No Connection"
            }
        }
    }
    
    public var whenReachable: NetworkReachable?
    public var whenUnreachable: NetworkUnreachable?
    
    @available(*, deprecated, renamed: "allowsCellularConnection")
    public let reachableOnWWAN: Bool = true
    
    /// Set to `false` to force Reachability.connection to .none when on cellular connection (default value `true`)
    public var allowsCellularConnection: Bool
    
    // The notification center on which "reachability changed" events are being posted
    public var notificationCenter: NotificationCenter = NotificationCenter.default
    
    @available(*, deprecated, renamed: "connection.description")
    public var currentReachabilityString: String {
        return "\(connection)"
    }
    
    @available(*, unavailable, renamed: "connection")
    public var currentReachabilityStatus: Connection {
        return connection
    }
    
    public var connection: Connection {
        if flags == nil {
            try? setReachabilityFlags()
        }
        
        switch flags?.connection {
        case .none?, nil: return .none
        case .cellular?: return allowsCellularConnection ? .cellular : .none
        case .wifi?: return .wifi
        }
    }
    
    fileprivate var isRunningOnDevice: Bool = {
        #if targetEnvironment(simulator)
        return false
        #else
        return true
        #endif
    }()
    
    fileprivate var notifierRunning = false
    fileprivate let reachabilityRef: SCNetworkReachability
    fileprivate let reachabilitySerialQueue: DispatchQueue
    fileprivate(set) var flags: SCNetworkReachabilityFlags? {
        didSet {
            guard flags != oldValue else { return }
            reachabilityChanged()
        }
    }
    
    required public init(reachabilityRef: SCNetworkReachability, queueQoS: DispatchQoS = .default, targetQueue: DispatchQueue? = nil) {
        self.allowsCellularConnection = true
        self.reachabilityRef = reachabilityRef
        self.reachabilitySerialQueue = DispatchQueue(label: "uk.co.ashleymills.reachability", qos: queueQoS, target: targetQueue)
    }
    
    public convenience init?(hostname: String, queueQoS: DispatchQoS = .default, targetQueue: DispatchQueue? = nil) {
        guard let ref = SCNetworkReachabilityCreateWithName(nil, hostname) else { return nil }
        self.init(reachabilityRef: ref, queueQoS: queueQoS, targetQueue: targetQueue)
    }
    
    public convenience init?(queueQoS: DispatchQoS = .default, targetQueue: DispatchQueue? = nil) {
        var zeroAddress = sockaddr()
        zeroAddress.sa_len = UInt8(MemoryLayout<sockaddr>.size)
        zeroAddress.sa_family = sa_family_t(AF_INET)
        
        guard let ref = SCNetworkReachabilityCreateWithAddress(nil, &zeroAddress) else { return nil }
        
        self.init(reachabilityRef: ref, queueQoS: queueQoS, targetQueue: targetQueue)
    }
    
    deinit {
        stopNotifier()
    }
}

public extension Reachability {
    
    // MARK: - *** Notifier methods ***
    func startNotifier() throws {
        guard !notifierRunning else { return }
        
        let callback: SCNetworkReachabilityCallBack = { (reachability, flags, info) in
            guard let info = info else { return }
            
            let reachability = Unmanaged<Reachability>.fromOpaque(info).takeUnretainedValue()
            reachability.flags = flags
        }
        
        var context = SCNetworkReachabilityContext(version: 0, info: nil, retain: nil, release: nil, copyDescription: nil)
        context.info = UnsafeMutableRawPointer(Unmanaged<Reachability>.passUnretained(self).toOpaque())
        if !SCNetworkReachabilitySetCallback(reachabilityRef, callback, &context) {
            stopNotifier()
            throw ReachabilityError.UnableToSetCallback
        }
        
        if !SCNetworkReachabilitySetDispatchQueue(reachabilityRef, reachabilitySerialQueue) {
            stopNotifier()
            throw ReachabilityError.UnableToSetDispatchQueue
        }
        
        // Perform an initial check
        try setReachabilityFlags()
        
        notifierRunning = true
    }
    
    func stopNotifier() {
        defer { notifierRunning = false }
        
        SCNetworkReachabilitySetCallback(reachabilityRef, nil, nil)
        SCNetworkReachabilitySetDispatchQueue(reachabilityRef, nil)
    }
    
    // MARK: - *** Connection test methods ***
    @available(*, deprecated, message: "Please use `connection != .none`")
    var isReachable: Bool {
        return connection != .none
    }
    
    @available(*, deprecated, message: "Please use `connection == .cellular`")
    var isReachableViaWWAN: Bool {
        // Check we're not on the simulator, we're REACHABLE and check we're on WWAN
        return connection == .cellular
    }
    
    @available(*, deprecated, message: "Please use `connection == .wifi`")
    var isReachableViaWiFi: Bool {
        return connection == .wifi
    }
    
    var description: String {
        guard let flags = flags else { return "unavailable flags" }
        let W = isRunningOnDevice ? (flags.isOnWWANFlagSet ? "W" : "-") : "X"
        let R = flags.isReachableFlagSet ? "R" : "-"
        let c = flags.isConnectionRequiredFlagSet ? "c" : "-"
        let t = flags.isTransientConnectionFlagSet ? "t" : "-"
        let i = flags.isInterventionRequiredFlagSet ? "i" : "-"
        let C = flags.isConnectionOnTrafficFlagSet ? "C" : "-"
        let D = flags.isConnectionOnDemandFlagSet ? "D" : "-"
        let l = flags.isLocalAddressFlagSet ? "l" : "-"
        let d = flags.isDirectFlagSet ? "d" : "-"
        
        return "\(W)\(R) \(c)\(t)\(i)\(C)\(D)\(l)\(d)"
    }
}

fileprivate extension Reachability {
    
    func setReachabilityFlags() throws {
        try reachabilitySerialQueue.sync { [unowned self] in
            var flags = SCNetworkReachabilityFlags()
            if !SCNetworkReachabilityGetFlags(self.reachabilityRef, &flags) {
                self.stopNotifier()
                throw ReachabilityError.UnableToGetInitialFlags
            }
            
            self.flags = flags
        }
    }
    
    func reachabilityChanged() {
        let block = connection != .none ? whenReachable : whenUnreachable
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            block?(self)
            self.notificationCenter.post(name: .reachabilityChanged, object: self)
        }
    }
}

extension SCNetworkReachabilityFlags {
    
    typealias Connection = Reachability.Connection
    
    var connection: Connection {
        guard isReachableFlagSet else { return .none }
        
        // If we're reachable, but not on an iOS device (i.e. simulator), we must be on WiFi
        #if targetEnvironment(simulator)
        return .wifi
        #else
        var connection = Connection.none
        
        if !isConnectionRequiredFlagSet {
            connection = .wifi
        }
        
        if isConnectionOnTrafficOrDemandFlagSet {
            if !isInterventionRequiredFlagSet {
                connection = .wifi
            }
        }
        
        if isOnWWANFlagSet {
            connection = .cellular
        }
        
        return connection
        #endif
    }
    
    var isOnWWANFlagSet: Bool {
        #if os(iOS)
        return contains(.isWWAN)
        #else
        return false
        #endif
    }
    var isReachableFlagSet: Bool {
        return contains(.reachable)
    }
    var isConnectionRequiredFlagSet: Bool {
        return contains(.connectionRequired)
    }
    var isInterventionRequiredFlagSet: Bool {
        return contains(.interventionRequired)
    }
    var isConnectionOnTrafficFlagSet: Bool {
        return contains(.connectionOnTraffic)
    }
    var isConnectionOnDemandFlagSet: Bool {
        return contains(.connectionOnDemand)
    }
    var isConnectionOnTrafficOrDemandFlagSet: Bool {
        return !intersection([.connectionOnTraffic, .connectionOnDemand]).isEmpty
    }
    var isTransientConnectionFlagSet: Bool {
        return contains(.transientConnection)
    }
    var isLocalAddressFlagSet: Bool {
        return contains(.isLocalAddress)
    }
    var isDirectFlagSet: Bool {
        return contains(.isDirect)
    }
    var isConnectionRequiredAndTransientFlagSet: Bool {
        return intersection([.connectionRequired, .transientConnection]) == [.connectionRequired, .transientConnection]
    }
}
