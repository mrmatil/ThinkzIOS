//
//  MainViewController+Moya.swift
//  Thinkz
//
//  Created by Mateusz Łukasiński on 29/02/2020.
//  Copyright © 2020 Mateusz Łukasiński. All rights reserved.
//

import Foundation
import Moya


internal extension MainViewController{

    func MoyaResponse(){
        
        let provider = MoyaProvider<HandWritingRecognition>()
        provider.request(.recognizeFromStrokes(language: .english,
                                               coordinates: drawingView.coordinates))
        { (response) in
            
            switch response{
            case .success(let response):
                self.parseJSONintoAzureObject(responseData: response.data)
            case .failure(let error):
                print(">>> AZURE API RESPONSE ERROR: \(error)")
            }
            
        }
        
    }
    
    private func parseJSONintoAzureObject(responseData:Data){
        
        let decoder = JSONDecoder()
            
        do{
            let response = try decoder.decode(AzureResponse.self, from: responseData)
           
            let temporaryString = response.recognitionUnits.first?.recognizedText
            guard let recognizedString = temporaryString else {throw AzureResponseErrors.noFreeTry}
            print(recognizedString)
    
        }
        catch is AzureResponseErrors{
            print(">>> TOO MANY AZURE API CALLS")
        }
        catch{
            print(">>> UNRECOGNIZED AZURE API ERROR WHILE PARSING JSON")
        }
        
    }
    
}
