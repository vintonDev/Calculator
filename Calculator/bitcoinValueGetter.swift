//
//  bitcoinValueGetter.swift
//  Calculator
//
//  Created by Иван Степанов on 31.01.2023.
//

import Foundation

//// Declare struct CoinData that conforms to the Decodable protocol
//struct CoinData: Decodable {
//    // Property "USD" of type Double
//    let USD: Double
//}
//
//// Function getBTCPrice with a completion handler
//func getBTCPrice(completion: @escaping (String?) -> Void) {
//    // Create a URL object using the string URL
//    let url = URL(string: "https://min-api.cryptocompare.com/data/price?fsym=BTC&tsyms=USD")!
//    
//    // Make a data task using shared URLSession object to fetch data from the URL
//    URLSession.shared.dataTask(with: url) { (data, response, error) in
//        // Check if there is an error, call completion with nil and print the error description
//        if let error = error {
//            completion(nil)
//            print(error.localizedDescription)
//            return
//        }
//        
//        // Check if data is not nil, otherwise call completion with nil
//        guard let data = data else {
//            completion(nil)
//            return
//        }
//        
//        // Try to decode the data into CoinData object using JSONDecoder
//        do {
//            let coinData = try JSONDecoder().decode(CoinData.self, from: data)
//            // Get the USD price of Bitcoin
//            let btcUsdPrice = coinData.USD
//            // Call completion with the string representation of the USD price
//            completion(String(btcUsdPrice))
//        } catch let error {
//            // If decoding fails, call completion with nil and print the error description
//            completion(nil)
//            print(error.localizedDescription)
//        }
//    }.resume() // Resume the data task to start the network request
//}
//
