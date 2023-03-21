//
//  TestView.swift
//  XClient
//
//  Created by 李浩安 on 2023/3/21.
//

import SwiftUI

struct ServerListView: View {
    @Binding var serverList: [OutboundObject]
    @Binding var selectedServerIndex: Int?
    
    var body: some View {
        VStack{
            List(selection: $selectedServerIndex) {
                ForEach(serverList.indices, id: \.self) { index in
                    Text(serverList[index].tag)
                        .onTapGesture {
                            selectedServerIndex = index
                        }
                }
                .onDelete(perform: deleteRow)
                .onMove(perform: moveRows)
                // TODO: implement drag & drop
                //.onInsert(of: <#T##[UTType]#>, perform: <#T##(Int, [NSItemProvider]) -> Void#>)
            }
            .listStyle(.bordered(alternatesRowBackgrounds: true))
            HStack {
                Button(action: addRow) {
                    Image(systemName: "plus")
                }
                //Button(action: deleteRow) {
                    //Image(systemName: "minus")
                //}
                Button(action: duplicateRow) {
                    Image(systemName: "square.on.square")
                }
                Spacer()
            }
        }
        .frame(width: 100.0)
        .padding()
    }
    
    func addRow() {
        serverList.append(OutboundObject(tag: "new", proxySettings: VlessSettingsObject(), streamSettings: StreamSettingsObject()))
    }
    
    func duplicateRow() {
        if let idx = selectedServerIndex {
            serverList.append(serverList[idx])
        }
    }
    
    func deleteRow(offset: IndexSet) {
        serverList.remove(atOffsets: offset)
        //selectedServerIndex = nil
    }
    
    func moveRows(from source: IndexSet, to destination: Int) {
        serverList.move(fromOffsets: source, toOffset: destination)
    }
}


struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        ServerListView(serverList: .constant(outboundExample), selectedServerIndex: .constant(0))
    }
}
