//
//  RequestQueue.swift
//  FakeNFT
//
//  Created by Avtor_103 on 06.02.2024.
//

import Foundation

final class RequestQueue<Parameter> {
    
    private var parameters = [Parameter]()
    
    private var request: ( (Parameter) -> Void )?
    
    private var onFinished: ( () -> Void )?
        
    func add(_ parameters: [Parameter]) {
        self.parameters.append(contentsOf: parameters)
    }
    
    func request(_ request: @escaping (Parameter) -> Void) {
        self.request = request
    }
    
    func onFinished(_ completion: @escaping () -> Void) {
        self.onFinished = completion
    }
    
    func next() {
        guard let request else { return }
        guard let parameter = parameters.first else {
            onFinished?()
            return
        }
        
        parameters.remove(at: 0)
        request(parameter)
    }
    
    func reset() {
        parameters.removeAll()
    }
}
