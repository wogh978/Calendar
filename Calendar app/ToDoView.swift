//
//  ToDoView.swift
//  Calendar app
//
//  Created by 유선영 on 2022/02/28.
//

import SwiftUI

struct ToDoView: View {
    @State var userInput = ""
    var body: some View {
        
        VStack{
        TextField("+ 일정을 추가하세요", text: $userInput)
                .padding(.leading, 10)

                .padding(.bottom, 200)

            Spacer()
            
            HStack{

            Button {
                
            } label: {
                Text("수정")
                    .foregroundColor(.white)
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue,in: Capsule())
            }
            Button {
                
            } label: {
                Text("완료")
                    .foregroundColor(.white)
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue,in: Capsule())
            }

            }
               

            
        }
        
    }
}

struct ToDoView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoView()
    }
}
