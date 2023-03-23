//
//  TestView.swift
//  XClient
//
//  Created by 李浩安 on 2023/3/21.
//

import SwiftUI

struct ServerListView: View {
    @Binding var serverList: [OutboundObject]
    @Binding var selectedServer: OutboundObject?
    //@Binding var selectedServerIndex: Int?
    
    var body: some View {
        VStack{
            List(selection: $selectedServer) {
                ForEach($serverList, id: \.self) { $selected in
                    Text(selected.tag)
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
        let newServer = OutboundObject(tag: "new", proxySettings: VlessSettingsObject(), streamSettings: StreamSettingsObject())
        selectedServer = newServer
        serverList.append(newServer)
    }
    
    func duplicateRow() {
        if let server = selectedServer {
            serverList.append(server)
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


struct ServerListView_Previews: PreviewProvider {
    static var previews: some View {
        //ServerListView(serverList: .constant(outboundExample), selectedServerIndex: .constant(0))
        ServerListView(serverList: .constant(outboundExample), selectedServer: .constant(outboundExample[0]))
    }
}
