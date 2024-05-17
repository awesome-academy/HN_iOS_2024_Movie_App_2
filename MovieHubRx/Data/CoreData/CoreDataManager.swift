//
//  CoreDataManager.swift
//  MovieHubRx
//
//  Created by Duy Nguyễn on 16/05/2024.
//

import Foundation
import UIKit
import CoreData
import RxSwift

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MovieHubRx")
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private init() {}
    
    func save<T: NSManagedObject>(object: T) -> Observable<Bool> {
        return Observable.create { observer in
            let context = self.persistentContainer.viewContext
            do {
                try context.save()
                observer.onNext(true)
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
    func delete<T: NSManagedObject>(object: T) -> Observable<Bool> {
        return Observable.create { observer in
            let context = self.persistentContainer.viewContext
            context.delete(object)
            do {
                try context.save()
                observer.onNext(true)
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
    func fetch<T: NSManagedObject>(request: NSFetchRequest<T>) -> Observable<[T]> {
        return Observable.create { observer in
            let context = self.persistentContainer.viewContext
            do {
                let fetchedData = try context.fetch(request)
                observer.onNext(fetchedData)
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
    func fetchObject<T: NSManagedObject>(request: NSFetchRequest<T>) -> Observable<T?> {
        return Observable.create { observer in
            let context = self.persistentContainer.viewContext
            do {
                let fetchedData = try context.fetch(request).first
                observer.onNext(fetchedData)
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
    func isObjectExists<T: NSManagedObject>(request: NSFetchRequest<T>) -> Observable<Bool> {
        return Observable.create { observer in
            let context = self.persistentContainer.viewContext
            do {
                let count = try context.count(for: request)
                observer.onNext(count > 0)
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
    func getPersistentContainer() -> NSPersistentContainer {
        return persistentContainer
    }
}
