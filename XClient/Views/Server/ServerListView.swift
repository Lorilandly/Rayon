//
//  TestView.swift
//  XClient
//
//  Created by 李浩安 on 2023/3/21.
//

import SwiftUI

struct ServerListView: View {
    @Binding var serverList: [OutboundObject]
    @State private var selectedServer: OutboundObject?
    @Binding var selectedIndex: Int?
    
    var index: Int? {
        serverList.firstIndex(where: { $0.id == selectedServer?.id })
    }

    var body: some View {
        List(selection: $selectedServer) {
            Section("Servers") {
                ForEach(serverList) { selected in
                    Text(selected.tag)
                        .tag(selected)
                }
                .onDelete(perform: deleteRow)
                .onMove(perform: moveRows)
                // TODO: implement drag & drop
                //.onInsert(of: <#T##[UTType]#>, perform: <#T##(Int, [NSItemProvider]) -> Void#>)
            }
        }
        .listStyle(.bordered(alternatesRowBackgrounds: true))
        .safeAreaInset(edge: .bottom) {
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
                .disabled(selectedServer == nil)
                Spacer()
            }
            .buttonStyle(.plain)
            .padding(5)
            .background(.background)
            .border(.tertiary)
        }
        .frame(width: 100.0)
        .onChange(of: selectedServer) { _ in
            selectedIndex = index
        }
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
        ServerListView(serverList: .constant(outboundExample), selectedIndex: .constant(nil))
    }
}
