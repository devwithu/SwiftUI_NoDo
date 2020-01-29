//
//  ContentView.swift
//  NoDo
//
//  Created by jdj on 2020/01/27.
//  Copyright © 2020 jdj. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var nodo: String = ""
    @State var nodoList = [String]()
    @State var timeAgo: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                HStack(spacing: 5) {
                    Image(systemName: "plus.circle")
                        .padding(.leading)
                    Group {
                        TextField("What Will You Not Do Today?", text: $nodo, onEditingChanged: {
                            (changed) in
                            print(changed)
                        }, onCommit: {
                            //print("onCommit")
                            self.timeAgo = self.timeAgoSinceDate(Date())
                            
                            self.nodoList.insert(self.nodo, at: 0)
                            print("Added item: \(self.nodoList)")
                            //UIApplication.shared.keyWindow?.endEditing(true)
                            self.nodo = ""
                        }).padding(.all, 12)
                    }.background(Color.green)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .shadow(radius: 5)
                        .padding(.trailing, 8)
                }
                
//                List{
//                    ForEach(self.nodoList.identified , id: \.self){ item in
//                        NoDoRow(noDoItem: item, isDone: false, timeAgo: self.timeAgo)
//                    }
//                }
                

                List{
                     ForEach(self.nodoList, id: \.self){ item in
                         NoDoRow(noDoItem: item, isDone: false, timeAgo: self.timeAgo)
                     }.onDelete(perform: deleteItem)
                }
                    
//                List(self.nodoList, id: \.self) { item in
//                    NoDoRow(noDoItem: item, isDone: false, timeAgo: self.timeAgo)
//                }.onDelete(perform: deleteItem)
            }.navigationBarTitle(Text("NoDo"))
            
            Text(nodo)
        }
    }
    func deleteItem(at offsets: IndexSet){
        guard let index = Array (offsets).first else {return}
        print("remove: \(self.nodoList[index])")
        self.nodoList.remove(at: index)
    }
    
    func timeAgoSinceDate(_ date:Date, numericDates:Bool = false) -> String{
        let calender = NSCalendar.current
        let unitFlags: Set<Calendar.Component> = [.minute, .hour, .day, .weekOfYear, .month, .year, .second]
        let now = Date()
        let earliest = now < date ? now : date
        let latest = (earliest == now) ? date : now
        let components = calender.dateComponents(unitFlags, from: earliest, to: latest)
        
        if (components.year! >= 2){
            return "\(components.year!) years ago"
        }else if (components.year! >= 1){
            if (numericDates){
                return "1 year ago"
            }else {
                return "Last Year"
            }
        }else if(components.month! >= 2){
            return "\(components.month!) months ago"
        }else if(components.month! >= 1){
            if (numericDates){
                return "1 month ago"
            }else {
                return "Last Month"
            }
        }else if(components.weekOfYear! >= 2){
            return "\(components.weekOfYear!) weeks ago"
        }else if(components.weekOfYear! >= 1){
            if (numericDates){
                return "1 week ago"
            }else {
                return "Last week"
            }
            
        }else if(components.day! >= 2){
            return "\(components.day!) days ago"
        }else if(components.day! >= 1){
            if (numericDates){
                return "1 day ago"
            }else {
                return "yesterday"
            }
        }else if(components.hour! >= 2){
            return "\(components.hour!) hours ago"
        }else if(components.hour! >= 1){
            if (numericDates){
                return "1 hour ago"
            }else {
                return "an hour ago"
            }
        }else if(components.minute! >= 2){
            return "\(components.minute!) minutes ago"
        }else if(components.minute! >= 1){
            if (numericDates){
                return "1 minute ago"
            }else {
                return "a minute ago"
            }
        }else if(components.second! >= 3){
            return "\(components.second!) seconds ago"
        }else {
            return "Just now"
        }
    }
}

struct NoDoRow: View {
    @State var noDoItem: String = ""
    @State var isDone: Bool = false
    @State var timeAgo : String
    
    var body: some View {
        VStack(alignment: .center, spacing: 2) {
            Group {
                HStack {
                    Text(noDoItem)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    
                    Spacer()
                    Image(systemName:  (self.isDone) ? "checkmark" : "square")
                    .padding()
                }
                
                HStack(alignment: .center, spacing: 3) {
                    Spacer()
                    Text("Added : \(self.timeAgo)")
                        .foregroundColor(.white)
                    .italic()
                        .padding(.all,4)
                }.padding(.bottom,5)
            }.padding(.all, 4)
        }.background( (self.isDone) ? Color.gray : Color.pink)
            .opacity((self.isDone) ? 0.3 : 1)
        .clipShape(RoundedRectangle(cornerRadius: 5))
            .onTapGesture {
                
                self.isDone.toggle()
                print("Tapped \(self.isDone)")
        }
    }
    

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
