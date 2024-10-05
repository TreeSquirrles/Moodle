//
//  ViewsAndModifiersApp.swift
//  ViewsAndModifiers
//
//  Created by yEETBOI on 6/11/24.
//

import SwiftUI
import SwiftData

@main
struct ViewsAndModifiersApp: App {
    let modelContainer : ModelContainer
    //@Environment(\.modelContext) var modelContext
    
    init() {
        do {
            modelContainer = try ModelContainer(for: Card.self)
        } catch {
            fatalError("Could not initialize ModelContainer")
        }
        
         
        //var countryLandmarks = Deck(name: "Country Landmarks")
        //var cards = [Card(front: "Eiffel Tower", back: "France", deck: countryLandmarks), Card(front: "Great Wall of China", back: "China", deck: countryLandmarks), Card(front: "Statue of Liberty", back: "United States", deck: countryLandmarks), Card(front: "Machu Picchu", back: "Peru", deck: countryLandmarks), Card(front: "Taj Mahal", back: "India", deck: countryLandmarks), Card(front: "Colosseum", back: "Italy", deck: countryLandmarks), Card(front: "Christ the Redeemer", back: "Brazil", deck: countryLandmarks), Card(front: "Big Ben", back: "United Kingdom", deck: countryLandmarks), Card(front: "Sydney Opera House", back: "Australia", deck: countryLandmarks), Card(front: "Petra", back: "Jordan", deck: countryLandmarks), Card(front: "Pyramids of Giza", back: "Egypt", deck: countryLandmarks), Card(front: "Mount Fuji", back: "Japan", deck: countryLandmarks), Card(front: "Angkor Wat", back: "Cambodia", deck: countryLandmarks), Card(front: "Acropolis of Athens", back: "Greece", deck: countryLandmarks), Card(front: "Neuschwanstein Castle", back: "Germany", deck: countryLandmarks), Card(front: "Table Mountain", back: "South Africa", deck: countryLandmarks), Card(front: "Sagrada Familia", back: "Spain", deck: countryLandmarks), Card(front: "Uluru (Ayers Rock)", back: "Austrailia", deck: countryLandmarks), Card(front: "Santorini", back: "Greece", deck: countryLandmarks), Card(front: "Kremlin and Red Square", back: "Russia", deck: countryLandmarks), Card(front: "Chichen Itza", back: "Mexico", deck: countryLandmarks), Card(front: "Great Barrier Reef", back: "Australia", deck: countryLandmarks), Card(front: "Burj Khalifa", back: "United Arab Emirates", deck: countryLandmarks), Card(front: "Mount Kilimanjaro", back: "Tanzania", deck: countryLandmarks), Card(front: "Versailles Palace", back: "France", deck: countryLandmarks), Card(front: "Niagara Falls", back: "Canada/United States", deck: countryLandmarks), Card(front: "Moai Statues", back: "Easter Island, Chile", deck: countryLandmarks), Card(front: "Alhambra", back: "Spain", deck: countryLandmarks), Card(front: "Mount Everest", back: "Nepal/China", deck: countryLandmarks), Card(front: "Stonehenge", back: "United Kingdom", deck: countryLandmarks), Card(front: "Forbidden City", back: "China", deck: countryLandmarks), Card(front: "Buckingham Palace", back: "United Kingdom", deck: countryLandmarks), Card(front: "Golden Gate Bridge", back: "United States", deck: countryLandmarks), Card(front: "Louvre Museum", back: "France", deck: countryLandmarks), Card(front: "Brandenburg Gate", back: "Germany", deck: countryLandmarks), Card(front: "Tulum Ruins", back: "Mexico", deck: countryLandmarks), Card(front: "Mount Rushmore", back: "United States", deck: countryLandmarks), Card(front: "Opera House of Vienna", back: "Austria", deck: countryLandmarks), Card(front: "Guggenheim Museum Bilbao", back: "Spain", deck: countryLandmarks), Card(front: "Notre Dame Cathedral", back: "France", deck: countryLandmarks), Card(front: "Hagia Sophia", back: "Turkey", deck: countryLandmarks), Card(front: "Yellowstone National Park", back: "United States", deck: countryLandmarks), Card(front: "Banff National Park", back: "Canada", deck: countryLandmarks), Card(front: "Victoria Falls", back: "Zambia/Zimbabwe", deck: countryLandmarks), Card(front: "Easter Island", back: "Chile", deck: countryLandmarks), Card(front: "Buckingham Palace", back: "United Kingdom", deck: countryLandmarks), Card(front: "Leaning Tower of Pisa", back: "Italy", deck: countryLandmarks), Card(front: "Cappadocia", back: "Turkey", deck: countryLandmarks), Card(front: "Lake Bled", back: "Slovenia", deck: countryLandmarks), Card(front: "Mont Saint Michel", back: "France", deck: countryLandmarks), Card(front: "Sultan Ahmed Mosque (Blue Mosque)", back: "Turkey", deck: countryLandmarks), Card(front: "Grand Canyon", back: "United States", deck: countryLandmarks), Card(front: "Prague Castle", back: "Czech Republic", deck: countryLandmarks), Card(front: "Skellig Michael", back: "Ireland", deck: countryLandmarks), Card(front: "Ha Long Bay", back: "Vietnam", deck: countryLandmarks), Card(front: "Petronas Towers", back: "Malaysia", deck: countryLandmarks), Card(front: "Moscow Metro", back: "Russia", deck: countryLandmarks), Card(front: "Fiordland National Park", back: "New Zealand", deck: countryLandmarks), Card(front: "Edinburgh Castle", back: "Scotland", deck: countryLandmarks), Card(front: "Rialto Bridge", back: "Italy", deck: countryLandmarks), Card(front: "Chateau de Chambord", back: "France", deck: countryLandmarks), Card(front: "Gateway of India", back: "India", deck: countryLandmarks), Card(front: "Terracotta Army", back: "China", deck: countryLandmarks), Card(front: "Mount Cook", back: "New Zealand", deck: countryLandmarks)]
        
        //modelContainer(for: [cards])
        
        //var presService = Deck(name: "US President Years of Service")
        //presService.cards = [Card(front: "George Washington", back: "1789-1797"), Card(front: "John Adams", back: "1797-1801"), Card(front: "Thomas Jefferson", back: "1801-1809"), Card(front: "James Madison", back: "1809-1817"), Card(front: "James Monroe", back: "1817-1825"), Card(front: "John Quincy Adams", back: "1825-1829"), Card(front: "Andrew Jackson", back: "1829-1837"), Card(front: "Martin Van Buren", back: "1837-1841"), Card(front: "William Henry Harrison", back: "1841"), Card(front: "John Tyler", back: "1841-1845"), Card(front: "James K. Polk", back: "1845-1849"), Card(front: "Zachary Taylor", back: "1849-1850"), Card(front: "Millard Fillmore", back: "1850-1853"), Card(front: "Franklin Pierce", back: "1853-1857"), Card(front: "James Buchanan", back: "1857-1861"), Card(front: "Abraham Lincoln", back: "1857-1865"), Card(front: "Andrew Johnson", back: "1865-1869"), Card(front: "Ulysses S. Grant", back: "1869-1877"), Card(front: "Rutherford B. Hayes", back: "1877-1881"), Card(front: "James A. Garfield", back: "1881"), Card(front: "Chester A. Arthur", back: "1881-1885"), Card(front: "Grover Cleveland", back: "1885-1889"), Card(front: "Benjamin Harrison", back: "1889-1893"), Card(front: "Grover Cleveland", back: "1893-1897"), Card(front: "William McKinley", back: "1897-1901"), Card(front: "Theodore Roosevelt", back: "1901-1909"), Card(front: "William Howard Taft", back: "1909-1913"), Card(front: "Woodrow Wilson", back: "1913-1921"), Card(front: "Warren G. Harding", back: "1921-1923"), Card(front: "Calvin Coolidge", back: "1923-1929"), Card(front: "Herbert Hoover", back: "1929-1933"), Card(front: "Franklin D. Roosevelt", back: "1933-1945"), Card(front: "Harry S. Truman", back: "1945-1953"), Card(front: "Dwight D. Eisenhower", back: "1953-1961"), Card(front: "John F. Kennedy", back: "1961-1963"), Card(front: "Lyndon B. Johnson", back: "1963-1969"), Card(front: "Richard Nixon", back: "1969-1974"), Card(front: "Gerald Ford", back: "1974-1977"), Card(front: "Jimmy Carter", back: "1977-1981"), Card(front: "Ronald Reagan", back: "1981-1989"), Card(front: "George H. W. Bush", back: "1989-1993"), Card(front: "Bill Clinton", back: "1993-2001"), Card(front: "George W. Bush", back: "2001-2009"), Card(front: "Barack Obama", back: "2009-2017"), Card(front: "Donald Trump", back: "2017-2021"), Card(front: "Joe Biden", back: "2021-2024")]
        
        //ForEach(cards) { card in
        //    modelContext.insert(card)
        //}
        //modelContext.insert(presService)
    }
    
    var body: some Scene {
        WindowGroup {
            VStack{
                ContentView()
            }
        }
        .modelContainer(for: Card.self)
        
    }
    
}
