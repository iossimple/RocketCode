//
//  OfflineListRepository.swift
//  sample-id
//
//  Created by Viet Nguyen Tran on 2021-06-25.
//

import Foundation
import Bond
import ReactiveKit
import Cache

open class OfflineListRepository<Item: Equatable & Codable> {
    private var _items = MutableObservableArray<Item>()
    
    public var items: ObservableArray<Item> { return _items.readOnlyView }
    
    public var allItems: [Item] { return items.array }
    
    public func removeAll() { _items.removeAll() }
    
    /// Remove an item.
    /// - Parameter item: Item to remove.
    /// - Returns: Successful or not. If item is not existed in the list, return false. Otherwise, return true.
    @discardableResult
    public func remove(_ item: Item) -> Bool { // Bool: successful or not
        guard let indexToRemove = allItems.firstIndex(of: item)
        else { return false }
        
        _items.remove(at: indexToRemove)
        return true
    }
    
    /// Replace by a new list.
    /// - Parameter items: The new list to replace.
    public func replace(with items: [Item]) {
        _items.replace(with: items)
    }
    
    /// Append an item.
    /// - Parameter item: Item to append.
    /// - Returns: Successful or not. If item is already in the list, return false. Otherwise, return true.
    @discardableResult
    public func append(_ item: Item) -> Bool { // Bool: successful or not
        guard !existed(item) else { return false }
        
        _items.append(item)
        return true
    }
    
    /// Insert an item into the list.
    /// - Parameters:
    ///   - item: Item to insert.
    ///   - index: Index to insert
    /// - Returns: Successful or not. If item is already in the list, return false. Otherwise, return true.
    @discardableResult
    public func insert(_ item: Item, at index: Int) -> Bool {
        guard !existed(item) else { return false }
        
        _items.insert(item, at: index)
        return true
    }
    
    /// Check whether the list contains an item.
    /// - Parameter item: Item to check.
    /// - Returns: True if the list contains item. False otherwise.
    public func existed(_ item: Item) -> Bool {
        return allItems.contains(item)
    }
    
    
    private var storage: DiskStorage<String, [Item]>
    private var savingKey: String
    
    private let disposeBag = DisposeBag()
    
    public init(storage: DiskStorage<String, [Item]>, savingKey: String) {
        self.storage = storage
        self.savingKey = savingKey
        
        loadListFromStorage()
        items.toSignal()
            .observeNext { [unowned self] _ in
                saveListToStorage()
            }.dispose(in: disposeBag)
    }
    
    private func saveListToStorage() {
        try? storage.setObject(allItems, forKey: savingKey)
    }
    
    private func loadListFromStorage() {
        let loadFromStorage = (try? storage.object(forKey: savingKey)) ?? []
        _items.replace(with: loadFromStorage)
    }
}
