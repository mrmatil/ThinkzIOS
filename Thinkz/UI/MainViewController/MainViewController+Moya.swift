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

    //MARK: - HandWriting Recognition
    
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
            changeTemporaryResultTextFieldText(text: recognizedString)
    
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
            guard let arrayOfBest = json[1][0][1].array else {return}
            if arrayOfBest.count == 0 {return}
            guard let response = arrayOfBest[0].string else {return}
            print(">>> GOOGLE API RESPONSE: " + response)
            changeTemporaryResultTextFieldText(text: response)
            
        }
        catch{
            print(error.localizedDescription)
        }
        

    }
    
    
    
    //MARK: - Grammar Checking
    
    func MoyaGrammarCheck(text:String, numberOfRow:Int){
        let provider = MoyaProvider<GrammarChecking>()
        
        switch pickedGrammarRecignizer{
            
        case .grammarbot:
            provider.request(.grammarbot(text: text)) { (response) in
                switch response{
                case .success(let succresp):
                    self.parseGrammarCheckData(jsonData: succresp.data, number: numberOfRow)
                case .failure(let error):
                    print(error)
                }
            }
            
        case .textGears:
            provider.request(.textGears(text: text)) { (response) in
                switch response{
                case .success(let succresp):
                    self.parseGrammarTextGearsCheckData(jsonData: succresp.data, number: numberOfRow, text: text)
                case .failure(let error):
                    print(error)
                }
            }
            
        }
        

    }
    
    private func parseGrammarCheckData(jsonData:Data, number:Int){

        let response = GrammarResponse(jsonData: jsonData)
        let temp = response.getWarnings()
        results[number].warings = temp
        resultsTableView.reloadData()
    }
    
    private func parseGrammarTextGearsCheckData(jsonData:Data, number:Int, text:String){
        let response = GrammarResponse(jsonData: jsonData)
        let temp = response.getWarningsForTextGears(text: text)
        results[number].warings = temp
        resultsTableView.reloadData()
    }
    
}
