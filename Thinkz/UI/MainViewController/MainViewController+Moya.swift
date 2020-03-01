//
//  MainViewController+Moya.swift
//  Thinkz
//
//  Created by Mateusz Łukasiński on 29/02/2020.
//  Copyright © 2020 Mateusz Łukasiński. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON


extension MainViewController{

    func MoyaResponse(){
        
        let provider = MoyaProvider<HandWritingRecognition>()
        
        switch pickedProvider{
        case .Azure:
            
            //MARK: Azure Request
            provider.request(.recognizeFromStrokesAzure(language: .english,
                                                        coordinates: drawingView.coordinates))
            { (response) in
                
                switch response{
                case .success(let response):
                    self.parseJSONintoAzureObject(responseData: response.data)
                case .failure(let error):
                    print(">>> AZURE API RESPONSE ERROR: \(error)")
                }
                
            }
            
        case .Google:
            
            //MARK: Google Request
            
            provider.request(.recognizeFromStrokesGoogle(language: .english,
                                                         coordinates: drawingView.coordinates,
                                                         area: drawingView.areaDimensions))
            { (response) in
                switch response{
                case .success(let response):
                    self.parseGoogleJSON(responseJSON: response.data)
//                    print(try! response.mapJSON())
                case .failure(let error):
                    print(">>> GOOGLE API RESPONSE ERROR: \(error)")
                }
            }
            
        case .none:
            return
        }
  
    }
    
    private func parseJSONintoAzureObject(responseData:Data){
        
        let decoder = JSONDecoder()
            
        do{
            let response = try decoder.decode(AzureResponse.self, from: responseData)
           
            let temporaryString = response.recognitionUnits.first?.recognizedText
            guard let recognizedString = temporaryString else {throw AzureResponseErrors.noFreeTry}
            print(">>> AZURE API RESPONSE: " + recognizedString)
    
        }
        catch is AzureResponseErrors{
            print(">>> TOO MANY AZURE API CALLS")
        }
        catch{
            print(">>> UNRECOGNIZED AZURE API ERROR WHILE PARSING JSON")
        }
        
    }
    
    private func parseGoogleJSON(responseJSON:Data){
        
        do{
            let json = try JSON.init(data: responseJSON)
            let arrayOfBest = json[1][0][1].array!
            print(">>> GOOGLE API RESPONSE: " + arrayOfBest[0].string!)
        }
        catch{
            print(error.localizedDescription)
        }
        

    }
    
}
