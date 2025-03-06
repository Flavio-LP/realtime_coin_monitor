require 'net/http'
require 'json'

class HomeController < ApplicationController

    CURRENCIES =[
        { code: 'USD-BRL' },
        { code: 'EUR-BRL' },
        { code: 'BTC-BRL' },
    ]

    def index
        #@chart_data = [["2025-01-01", 2], ["2025-01-02", 3]]
        @chart_data = []

        CURRENCIES.each do | currency |

            url = URI("https://economia.awesomeapi.com.br/json/daily/#{currency[:code]}/30")
            #url = URI("https://economia.awesomeapi.com.br/json/daily/USD-BRL/30")
            response = Net::HTTP.get(url)

            data = JSON.parse(response)

            hash = {}

            data.each do | entry | 
                date = Time.at(entry['timestamp'].to_i)
                rate = entry['high']

                hash[date] = rate 
            end

            #@chart_data = hash

            @chart_data << { currency: currency[:code],data: hash }

            #asdasd
        
        end
    end
end
