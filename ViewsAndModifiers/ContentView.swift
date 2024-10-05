//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by yEETBOI on 6/11/24.
//test

import SwiftData
import SwiftUI

struct Buttonn: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(.black)
            .foregroundStyle(.white)
            .clipShape(Capsule())
            .fontWeight(.semibold)
            .font(.title)
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .fontDesign(.rounded)
            .fontWeight(.heavy)
    }
}

extension View {
    func button() -> some View {
        modifier(Buttonn())
    }
    func title() -> some View {
        modifier(Title())
    }
    func Exit() -> some View {
        Text("Drag here to exit view!")
            .padding()
    }
}

extension EditMode {
    func toggleEditMode(_ editMode: inout EditMode)
    {
        editMode = editMode == .inactive ? .active : .inactive
    }
}

struct ContentView: View { // Homepage
    @Environment(\.modelContext) var modelContext
    
    @State private var showCredits = false
    @State private var showingActionSheet = false
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationView {
            TabView{
                HomeView()
                    .tabItem{
                        Label("Home", systemImage: "house.fill")
                    }
                
                CardsView()
                    .tabItem {
                        Label("All Cards", systemImage: "rectangle.on.rectangle.angled")
                    }
                
                DeckView()
                    .tabItem {
                        Label("Decks", systemImage: "rectangle.stack")
                    }
                
                TagsView()
                    .tabItem {
                        Label("Tags", systemImage: "tag")
                    }
                SettingsView()
                    .tabItem {
                        Label("Credits", systemImage: "list.clipboard")
                    }
//                CardDrawingView()
//                    .tabItem {
//                        Label("Drawing Tool", systemImage: "circle")
//                    }
            }
            
            
            // TabView number 2
//            TabView{
//                HomeView()
//                    .tabItem{
//                        Label("Home", systemImage: "house.fill")
//                    }
//                
//                CardsView()
//                    .tabItem {
//                        Label("All Cards", systemImage: "rectangle.on.rectangle.angled")
//                    }
//                
//                DeckView()
//                    .tabItem {
//                        Label("Decks", systemImage: "rectangle.stack")
//                    }
//                
//                TagsView()
//                    .tabItem {
//                        Label("Tags", systemImage: "tag")
//                    }
//                SettingsView()
//                    .tabItem {
//                        Label("Credits", systemImage: "list.clipboard")
//                    }
////                CardDrawingView()
////                    .tabItem {
////                        Label("Drawing Tool", systemImage: "circle")
////                    }
//            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            let descriptor = FetchDescriptor<Card>(predicate: #Predicate { $0.front.count >= 0 })
            let count = (try? modelContext.fetchCount(descriptor)) ?? 0
            
            print(count)
            
            if count == 0 {
                loadData()
            }
        }
    }
    
    
    func loadData(){
        
        let countryLandmarks = Deck(name: "Country Landmarks")
        modelContext.insert(countryLandmarks)
        let landmarkCards = [Card(front: "Eiffel Tower", back: "France", deck: countryLandmarks),
                     Card(front: "Great Wall of China", back: "China", deck: countryLandmarks),
                     Card(front: "Statue of Liberty", back: "United States", deck: countryLandmarks),
                     Card(front: "Machu Picchu", back: "Peru", deck: countryLandmarks),
                     Card(front: "Taj Mahal", back: "India", deck: countryLandmarks),
                     Card(front: "Colosseum", back: "Italy", deck: countryLandmarks),
                     Card(front: "Christ the Redeemer", back: "Brazil", deck: countryLandmarks),
                     Card(front: "Big Ben", back: "United Kingdom", deck: countryLandmarks),
                     Card(front: "Sydney Opera House", back: "Australia", deck: countryLandmarks),
                     Card(front: "Petra", back: "Jordan", deck: countryLandmarks),
                     Card(front: "Pyramids of Giza", back: "Egypt", deck: countryLandmarks),
                     Card(front: "Mount Fuji", back: "Japan", deck: countryLandmarks),
                     Card(front: "Angkor Wat", back: "Cambodia", deck: countryLandmarks),
                     Card(front: "Acropolis of Athens", back: "Greece", deck: countryLandmarks),
                     Card(front: "Neuschwanstein Castle", back: "Germany", deck: countryLandmarks),
                     Card(front: "Table Mountain", back: "South Africa", deck: countryLandmarks),
                     Card(front: "Sagrada Familia", back: "Spain", deck: countryLandmarks),
                     Card(front: "Uluru (Ayers Rock)", back: "Austrailia", deck: countryLandmarks),
                     Card(front: "Santorini", back: "Greece", deck: countryLandmarks),
                     Card(front: "Kremlin and Red Square", back: "Russia", deck: countryLandmarks),
                     Card(front: "Chichen Itza", back: "Mexico", deck: countryLandmarks),
                     Card(front: "Great Barrier Reef", back: "Australia", deck: countryLandmarks),
                     Card(front: "Burj Khalifa", back: "United Arab Emirates", deck: countryLandmarks),
                     Card(front: "Mount Kilimanjaro", back: "Tanzania", deck: countryLandmarks),
                     Card(front: "Versailles Palace", back: "France", deck: countryLandmarks),
                     Card(front: "Niagara Falls", back: "Canada/United States", deck: countryLandmarks),
                     Card(front: "Moai Statues", back: "Easter Island, Chile", deck: countryLandmarks),
                     Card(front: "Alhambra", back: "Spain", deck: countryLandmarks), 
                     Card(front: "Mount Everest", back: "Nepal/China", deck: countryLandmarks),
                     Card(front: "Stonehenge", back: "United Kingdom", deck: countryLandmarks),
                     Card(front: "Forbidden City", back: "China", deck: countryLandmarks),
                     Card(front: "Buckingham Palace", back: "United Kingdom", deck: countryLandmarks),
                     Card(front: "Golden Gate Bridge", back: "United States", deck: countryLandmarks),
                     Card(front: "Louvre Museum", back: "France", deck: countryLandmarks),
                     Card(front: "Brandenburg Gate", back: "Germany", deck: countryLandmarks),
                     Card(front: "Tulum Ruins", back: "Mexico", deck: countryLandmarks),
                     Card(front: "Mount Rushmore", back: "United States", deck: countryLandmarks),
                     Card(front: "Opera House of Vienna", back: "Austria", deck: countryLandmarks),
                     Card(front: "Guggenheim Museum Bilbao", back: "Spain", deck: countryLandmarks),
                     Card(front: "Notre Dame Cathedral", back: "France", deck: countryLandmarks),
                     Card(front: "Hagia Sophia", back: "Turkey", deck: countryLandmarks),
                     Card(front: "Yellowstone National Park", back: "United States", deck: countryLandmarks),
                     Card(front: "Banff National Park", back: "Canada", deck: countryLandmarks),
                     Card(front: "Victoria Falls", back: "Zambia/Zimbabwe", deck: countryLandmarks),
                     Card(front: "Easter Island", back: "Chile", deck: countryLandmarks),
                     Card(front: "Buckingham Palace", back: "United Kingdom", deck: countryLandmarks),
                     Card(front: "Leaning Tower of Pisa", back: "Italy", deck: countryLandmarks),
                     Card(front: "Cappadocia", back: "Turkey", deck: countryLandmarks),
                     Card(front: "Lake Bled", back: "Slovenia", deck: countryLandmarks),
                     Card(front: "Mont Saint Michel", back: "France", deck: countryLandmarks),
                     Card(front: "Sultan Ahmed Mosque (Blue Mosque)", back: "Turkey", deck: countryLandmarks),
                     Card(front: "Grand Canyon", back: "United States", deck: countryLandmarks),
                     Card(front: "Prague Castle", back: "Czech Republic", deck: countryLandmarks),
                     Card(front: "Skellig Michael", back: "Ireland", deck: countryLandmarks),
                     Card(front: "Ha Long Bay", back: "Vietnam", deck: countryLandmarks),
                     Card(front: "Petronas Towers", back: "Malaysia", deck: countryLandmarks),
                     Card(front: "Moscow Metro", back: "Russia", deck: countryLandmarks),
                     Card(front: "Fiordland National Park", back: "New Zealand", deck: countryLandmarks),
                     Card(front: "Edinburgh Castle", back: "Scotland", deck: countryLandmarks),
                     Card(front: "Rialto Bridge", back: "Italy", deck: countryLandmarks),
                     Card(front: "Chateau de Chambord", back: "France", deck: countryLandmarks),
                     Card(front: "Gateway of India", back: "India", deck: countryLandmarks),
                     Card(front: "Terracotta Army", back: "China", deck: countryLandmarks),
                     Card(front: "Mount Cook", back: "New Zealand", deck: countryLandmarks)
        ]
        
        let presService = Deck(name: "US President Years of Service")
        modelContext.insert(presService)
        let presCards = [Card(front: "George Washington", back: "1789-1797", deck: presService),
                         Card(front: "John Adams", back: "1797-1801", deck: presService),
                         Card(front: "Thomas Jefferson", back: "1801-1809", deck: presService),
                         Card(front: "James Madison", back: "1809-1817", deck: presService),
                         Card(front: "James Monroe", back: "1817-1825", deck: presService),
                         Card(front: "John Quincy Adams", back: "1825-1829", deck: presService),
                         Card(front: "Andrew Jackson", back: "1829-1837", deck: presService),
                         Card(front: "Martin Van Buren", back: "1837-1841", deck: presService),
                         Card(front: "William Henry Harrison", back: "1841", deck: presService),
                         Card(front: "John Tyler", back: "1841-1845", deck: presService),
                         Card(front: "James K. Polk", back: "1845-1849", deck: presService),
                         Card(front: "Zachary Taylor", back: "1849-1850", deck: presService),
                         Card(front: "Millard Fillmore", back: "1850-1853", deck: presService),
                         Card(front: "Franklin Pierce", back: "1853-1857", deck: presService),
                         Card(front: "James Buchanan", back: "1857-1861", deck: presService),
                         Card(front: "Abraham Lincoln", back: "1857-1865", deck: presService),
                         Card(front: "Andrew Johnson", back: "1865-1869", deck: presService),
                         Card(front: "Ulysses S. Grant", back: "1869-1877", deck: presService),
                         Card(front: "Rutherford B. Hayes", back: "1877-1881", deck: presService),
                         Card(front: "James A. Garfield", back: "1881", deck: presService),
                         Card(front: "Chester A. Arthur", back: "1881-1885", deck: presService),
                         Card(front: "Grover Cleveland", back: "1885-1889", deck: presService),
                         Card(front: "Benjamin Harrison", back: "1889-1893", deck: presService),
                         Card(front: "Grover Cleveland", back: "1893-1897", deck: presService),
                         Card(front: "William McKinley", back: "1897-1901", deck: presService),
                         Card(front: "Theodore Roosevelt", back: "1901-1909", deck: presService),
                         Card(front: "William Howard Taft", back: "1909-1913", deck: presService),
                         Card(front: "Woodrow Wilson", back: "1913-1921", deck: presService),
                         Card(front: "Warren G. Harding", back: "1921-1923", deck: presService),
                         Card(front: "Calvin Coolidge", back: "1923-1929", deck: presService),
                         Card(front: "Herbert Hoover", back: "1929-1933", deck: presService),
                         Card(front: "Franklin D. Roosevelt", back: "1933-1945", deck: presService),
                         Card(front: "Harry S. Truman", back: "1945-1953", deck: presService),
                         Card(front: "Dwight D. Eisenhower", back: "1953-1961", deck: presService),
                         Card(front: "John F. Kennedy", back: "1961-1963", deck: presService),
                         Card(front: "Lyndon B. Johnson", back: "1963-1969", deck: presService),
                         Card(front: "Richard Nixon", back: "1969-1974", deck: presService),
                         Card(front: "Gerald Ford", back: "1974-1977", deck: presService),
                         Card(front: "Jimmy Carter", back: "1977-1981", deck: presService),
                         Card(front: "Ronald Reagan", back: "1981-1989", deck: presService),
                         Card(front: "George H. W. Bush", back: "1989-1993", deck: presService),
                         Card(front: "Bill Clinton", back: "1993-2001", deck: presService),
                         Card(front: "George W. Bush", back: "2001-2009", deck: presService),
                         Card(front: "Barack Obama", back: "2009-2017", deck: presService),
                         Card(front: "Donald Trump", back: "2017-2021", deck: presService),
                         Card(front: "Joe Biden", back: "2021-2024", deck: presService)
        ]
        
        //for card in cards {
        //    modelContext.insert(card)
        //}
    }
    
    
}

#Preview {
    ContentView()
}
