//
//  ContentView.swift
//  Moteno
//
//  Created by jacob on 12/09/2022.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    
    @State private var permissionGranted = false
    
    private func requestPermissions() {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                if success {
                    permissionGranted = true
                } else if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    
    @State var Quote:String = "Data not loaded" {
        didSet {
                sendNotification()
            }
    }
    
    @State var Author:String = "Data not loaded"
    
    @State var ads:Bool = true
    @AppStorage("noti") var noti:Bool = false
    @AppStorage("accent") var accent:Bool = true
    
    @State private var isNotiDisabled = false
    @State private var isNotiEnabled = true
    
    @State private var isAccentDisabled = false
    @State private var isAccentEnabled = true
    
    @State var accentColor = Color.blue
    @State var accentColorAlt = Color.white
    
    let timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect()
    
    func notiPermission() {
        if (noti == true) {
            requestPermissions()
        }
    }
    
    func uiChanger() {
        
        if (accent == true) {
            accentColor = Color.blue
            
        }
        else {
            accentColor = Color.gray
            accentColorAlt = Color.white
        }
    }
    
    func sendNotification() {
        let content = UNMutableNotificationContent()
        content.title = "New Quote!"
        content.body = "\"\(Quote)\" - \(Author)"
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false)
        let request = UNNotificationRequest(identifier: "DataChangeNotification", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error sending notification: \(error.localizedDescription)")
            }
        }
    }
    
//    func startDataChangeTimer() {
//        // Create a timer that fires every 10 seconds
//        Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true) { timer in
//            // Call the checkDataChanges function to check for changes in data
//            refreshData()
//            checkDataChanges()
//            // Refresh data after checking changes
//            refreshData()
//            print("Data: " + Quote)
//        }
//    }
//
//    func checkDataChanges() {
//        print("CheckData " + Quote)
//
//        // Store the current output of the refreshData() function
//        let currentData:String = Quote
//
//        // Check if the current data is different from the previous data
//        if currentData != UserDefaults.standard.string(forKey: "previousData") {
//
//            // Create a new notification content object with the updated data
//            let content = UNMutableNotificationContent()
//            content.title = "New Quote!"
//            content.body = "\"\(Quote)\" - \(Author)"
//
//            // Configure the notification trigger to fire immediately
//            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false)
//
//            // Create a new notification request with the updated content and trigger
//            let request = UNNotificationRequest(identifier: "DataChangeNotification", content: content, trigger: trigger)
//
//            // Add the request to the notification center
//            UNUserNotificationCenter.current().add(request) { error in
//                if let error = error {
//                    print("Error sending notification: \(error.localizedDescription)")
//                }
//            }
//
//            // Store the new data in UserDefaults for comparison in the future
//            UserDefaults.standard.set(currentData, forKey: "previousData")
//        }
//    }

    init() {
        
        let look = UINavigationBarAppearance()
        
//        look.backgroundColor = UIColor.black
        
        look.titleTextAttributes = [.foregroundColor: UIColor.white]
        look.largeTitleTextAttributes = [.foregroundColor: UIColor(accentColor)]
        
        UINavigationBar.appearance().standardAppearance = look
        UINavigationBar.appearance().compactAppearance = look
        
        UINavigationBar.appearance().tintColor = .white
//        UITabBar.appearance().backgroundColor = UIColor.white
        
        
    }
    
    var body: some View {
        
        NavigationView {
            GeometryReader { geometry in
                
                ZStack (alignment: .bottomLeading) {
                    TabView {
                        
                        HStack {
                            Spacer()
                            
                                .frame(width: 25)
                            VStack {
//                                HStack {
//                                    Spacer()
//                                    Button(action:  {
//                                        print("test")
//                                    })
//                                    {
//                                    Text("More information")
//                                    Image(systemName: "chevron.forward")
//                                        .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
//                                    }
//
////                                        .foregroundColor(Color.blue)
//                                }
////                                Spacer()
////                                    .frame(height: 20)
//                                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 25, trailing: 0))
                                Text("\"" + Quote + "\"")
                                    .bold()
                                    .font(.system(size: 20))
                                    .foregroundColor(Color.white)
                                Spacer()
                                    .frame(height: 30)
                                HStack {
                                    Spacer()
                                    Text("~" + Author)
                                        .foregroundColor(Color(UIColor.lightGray))
                                        .italic()
                                        .font(.system(size: 18))
                                        .foregroundColor(accentColor)
                                }
                            }
                            .padding(40)
                            .background(.ultraThinMaterial, in:
                                            RoundedRectangle(cornerRadius: 13.0))
                            .shadow(color: Color.white, radius: 50)
                            .cornerRadius(13)
                            Spacer()
                                .frame(width: 25)
                        }
                        
                        
                        .tabItem {
                            Image(systemName: "house.fill")
                            Text("Home")
                        }
                        .tag(0)
                        
                        VStack {
                            Spacer()
                            Toggle(isOn: $ads, label: {
                                Text("Ads (for the memes)")
                            })
                            .padding()
                            .toggleStyle(SwitchToggleStyle(tint: accentColor))
                            .background(.ultraThinMaterial)
                            .cornerRadius(13)
                            .disabled(true)
                            
                            Toggle(isOn: $noti, label: {
                                Text("Notifications")
                                let _ = self.notiPermission()
                            })
                            .padding()
                            .toggleStyle(SwitchToggleStyle(tint: accentColor))
                            .background(.ultraThinMaterial)
                            .cornerRadius(13)
                            
                            Toggle(isOn: $accent, label: {
                                Text("Accent Color (Demo)")
                                let _ = self.uiChanger()
                                
                            })
                            .padding()
                            .toggleStyle(SwitchToggleStyle(tint: accentColor))
                            .background(.ultraThinMaterial)
                            .cornerRadius(13)
                            
                            
                            VStack {
                                
                                HStack {
                                    Spacer()
                                    Link(destination: URL(string: "https://github.com/shadoweG")!) {
                                        VStack {
                                            Text("GitHub")
                                                .foregroundColor(accentColor)
                                        }
                                        
                                    }
                                    Spacer()
                                }
                                .font(.system(size: 22))
                                .padding(16)
                                .background(.ultraThinMaterial)
                                .cornerRadius(13)
                                
                                HStack {
                                    Spacer()
                                    Link(destination: URL(string: "https://jacobb.net")!) {
                                        VStack {
                                            Text("Website")
                                                .foregroundColor(accentColor)
                                        }
                                    }
                                    Spacer()
                                }
                                .font(.system(size: 22))
                                .padding(16)
                                .background(.ultraThinMaterial)
                                .cornerRadius(13)
                                
                                
                                HStack {
                                    Spacer()
                                    Link(destination: URL(string: "https://paypal.me/jacobbvfx")!) {
                                        VStack {
                                            Text("Donate")
                                                .foregroundColor(accentColor)
                                        }
                                    }
                                    Spacer()
                                }
                                .font(.system(size: 22))
                                .padding(16)
                                .background(.ultraThinMaterial)
                                .cornerRadius(13)
                                Spacer()

                            }
                            
                        }
                        .padding(25)
                        .tabItem {
                            Image(systemName: "shippingbox")
                            Text("Configuration")
                        }
                        .tag(1)
                        .navigationTitle("Settings")
                        
                    }
                    
                }
            }
//            .accentColor(accentColorAlt)
            .navigationTitle("Moteno")
            .onReceive(NotificationCenter.default.publisher(for: UserDefaults.didChangeNotification)) { _ in
                isAccentEnabled = accent
                isAccentDisabled = accent
                
                isNotiEnabled = noti
                isNotiDisabled = noti
                
            }
            
//            .toolbarBackground(.visible, for: .navigationBar)
//            .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
            
            .onAppear {
                refreshData()
//                startDataChangeTimer()
                Timer.scheduledTimer(withTimeInterval: 60, repeats: true) {
                    timer in
                }
            }
            .onReceive(timer) {
                _ in
                refreshData()
            }
            
            
            
        }
        
    }
    func refreshData() {
        JsonQuote { quote in
            self.Quote = quote
        }
        JsonAuthor { author in
            self.Author = author
        }
    }
    
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
            .preferredColorScheme(.dark)
        
    }
}
