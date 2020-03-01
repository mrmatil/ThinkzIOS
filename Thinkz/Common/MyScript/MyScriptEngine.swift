//
//  MyScriptEngine.swift
//  Thinkz
//
//  Created by Mateusz Łukasiński on 01/03/2020.
//  Copyright © 2020 Mateusz Łukasiński. All rights reserved.
//

import Foundation

//MARK: Variables and Initializers
class MyScriptEngine{
    
    private var engine:IINKEngine?
    private var errorMessage:String?
    
    var currentEngine:IINKEngine?{
        get{ return engine }
    }
    
    var currentError: String? {
        get{ return errorMessage }
    }
    
    init() {
        initializeEngine()
    }
    
}

//MARK: Public Functions
extension MyScriptEngine{
    
    func setDelegate(delegate:IINKConfigurationDelegate){
        engine?.configuration.addDelegate(delegate)
    }
    
    func changeEngineLanguage(){
        
    }
    
}

//MARK: Private Functions
private extension MyScriptEngine{
    
    func initializeEngine(){
        
        //Checking Certificate
        if myCertificate.length == 0 {
            errorMessage = ">>> MYSCRIPT: NO CERTIFICATE IMPLEMENTED"
            engine = nil
        }
        
        //IINK runtime env
        let data = Data(bytes: myCertificate.bytes, count: myCertificate.length)
        guard let tempEngine = IINKEngine(certificate: data) else {
            errorMessage = ">>> MYSCRIPT: INVALID CERTIFICATE"
            engine = nil
            return
        }
        
        //Configure IINK runtime env
        let configurationPath = Bundle.main.bundlePath.appending("/recognition-assets/conf")
        do{
            //setting where to find recognition asssets
            try tempEngine.configuration.setStringArray([configurationPath],
                                                        forKey: "configuration-manager.search-path")
            
            //setting default language
            try tempEngine.configuration.setString("en-GB", forKey: "lang")
        } catch{
            errorMessage = ">>> MYSCRIPT: RUNTIME CONFIGURING ERROR => \(error.localizedDescription)"
            engine = nil
        }
        
        // Set the temporary directory
        do {
            try tempEngine.configuration.setString(NSTemporaryDirectory(), forKey: "content-package.temp-folder")
        } catch {
            errorMessage = ">>> MYSCRIPT: FAILED TO SET TEMPORARY FOLDER => " + error.localizedDescription
            engine = nil
        }
        
        engine = tempEngine
    }
    
}
