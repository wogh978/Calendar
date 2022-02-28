//
//  ContentView.swift
//  ReminderUI_SwiftUI
//
//  Created by 유선영 on 2022/02/26.
//

import SwiftUI

struct ContentView: View {
    @State var currentDate: Date = Date()
    @State var userInput = ""
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 20){
                DatePicker(currentDate: $currentDate)
            }
            .padding(.vertical)
        }

    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
            ContentView()

    }
}

struct DateValue: Identifiable{
    var id = UUID().uuidString
    var day: Int
    var date: Date
}

struct DatePicker: View {
    @Binding var currentDate: Date
    @State var currentMonth: Int = 0
    
    var body: some View {
        VStack(spacing: 35){
            let days: [String] = ["Sun","Mon","Tue","Wed","Thu","Fri","Sat"]
            
            HStack(spacing: 20){
                Button {
                    withAnimation{
                        currentMonth -= 1
                    }
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundColor(.black)
                }
                Spacer()
                VStack(alignment: .center, spacing: 2) {
                    Text(extraDate()[0])
                        .font(Font.system(size: 20))
                        .fontWeight(.semibold)
                    Text(extraDate()[1])
                        .font(.title.bold())
                }

                Spacer()
               
                Button {
                    
                    withAnimation{
                        currentMonth += 1
                    }
                    
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.title2)
                        .foregroundColor(.black)
                }
            }
            .padding(.horizontal)
            
            HStack(spacing: 0){
                ForEach(days,id: \.self) { day in
                    Text(day)
                        .font(.callout)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                }
            }
            let columns = Array(repeating: GridItem(.flexible()), count: 7)
            
            LazyVGrid(columns: columns,spacing: 15) {
                ForEach(extractDate()) { value in
                    
                    CardView(value: value)
                        .onTapGesture {
                            currentDate = value.date
                    }
                }
            }

           
        }
        .padding()
        .onChange(of: currentMonth) { newValue in
            currentDate = getCurrentMonth()
        }
    }
    @ViewBuilder
    func CardView(value: DateValue)->some View{
        
        VStack{
            
            if value.day == -1{
                Text("")
                }else{
                    Text("\(value.day)")
                        .font(.title3.bold())
                        .frame(maxWidth: .infinity)
                    Spacer()
                }
            }
        }
     
    
    func isSameDay(date1: Date,date2: Date)->Bool{
        let calendar = Calendar.current
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    func extraDate()->[String]{
        let calendar = Calendar.current
        let month = calendar.component(.month, from: currentDate) - 1
        let year = calendar.component(.year, from: currentDate)
        
        return ["\(year)",calendar.monthSymbols[month]]
    }
    func getCurrentMonth()->Date {
        let calendar = Calendar.current
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date()) else{
            return Date()
        }
        return currentMonth
    }
    func extractDate()->[DateValue] {
        let calendar = Calendar.current
        let currentMonth = getCurrentMonth()
        var days = currentMonth.getAllDates().compactMap { date -> DateValue in
            let day = calendar.component(.day, from: date)
            return DateValue(day: day, date: date)
        }
        let firstWeekday = calendar.component(.weekday, from: days.first!.date)
        
        for _ in 0..<firstWeekday - 1{
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        
        return days
    }
}

extension Date {
    
    func getAllDates()->[Date] {
        let calendar = Calendar.current
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year,.month], from: self))!
        let range = calendar.range(of: .day, in: .month, for: startDate)!
        return range.compactMap { day -> Date in
            return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
        }
    }
}


