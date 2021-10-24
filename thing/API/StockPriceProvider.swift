//
//  StockPriceProvider.swift
//  thing
//
//  Created by John Pothier on 10/21/21.
//

import Foundation

private func jsonDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    let dateFormatter = DateFormatter()
    
    // 2021-10-20T00:00:00+0000
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    dateFormatter.locale = Locale(identifier: "en_US")
    dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
    
    decoder.dateDecodingStrategy = .formatted(dateFormatter)
    return decoder
}

class StockPriceProvider : StockPriceProviding {
    struct Constants {
        static let accessKey = "5fa0e052d1497ef7d8ddc4b044aa69d4"
        static let baseURL = "http://api.marketstack.com/v1/"
    }
    
    func fetchTicker(callback: @escaping (TickerResponse) -> ()) {
        fetch(endpoint: "tickers?access_key=\(Constants.accessKey)") { response in
            do {
                guard let data = response.data(using: .utf8) else {
                    callback(TickerResponse(data: []))
                    return
                }
                
                let decoded =
                    try jsonDecoder().decode(
                        TickerResponse.self,
                        from: data
                    )
                callback(decoded)
            } catch {
                print("Error decoding ticker response: \(error)")
                callback(TickerResponse(data: []))
            }
        }
    }
    
    func fetchEOD(symbol: String, callback: @escaping (EODResponse) -> ()) {
        fetch(endpoint: "eod?symbols=\(symbol)&access_key=\(Constants.accessKey)") { response in
            do {
                guard let data = response.data(using: .utf8) else {
                    callback(EODResponse(data: []))
                    return
                }
                
                let decoded =
                    try jsonDecoder().decode(
                        EODResponse.self,
                        from: data
                    )
                callback(decoded)
            } catch {
                print("Error decoding EOD response: \(error)")
                callback(EODResponse(data: []))
            }
        }
    }
    
    private func fetch(endpoint: String, processResponse: @escaping (String) -> ()) {
        guard let url = URL(string: "\(Constants.baseURL)\(endpoint)") else {
            processResponse("")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            let fail = {
                    DispatchQueue.main.async {
                    processResponse("")
                }
            }
            
            if let error = error {
                print("Error sending http request: \(error)")
                fail()
                return
            }
            
            guard let data = data else {
                print("HTTP request responded with no data")
                fail()
                return
            }
            
            guard let string = String(data: data, encoding: .utf8) else {
                print("HTTP request responded with malformed data")
                fail()
                return
            }
            
            DispatchQueue.main.async {
                processResponse(string)
            }
        }
        
        task.resume()
    }
}
