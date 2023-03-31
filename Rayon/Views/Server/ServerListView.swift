//
//  TestView.swift
//  XClient
//
//  Created by 李浩安 on 2023/3/21.
//

import SwiftUI

struct ServerListView: View {
    @Binding var serverList: [OutboundObject]
    @Binding var selectedIndex: Int?
    @State private var selectedServer: OutboundObject.ID?
    @State private var sharePresented: Bool = false
    
    var index: Int? {
        serverList.firstIndex(where: { $0.id == selectedServer })
    }

    var body: some View {
        List(selection: $selectedServer) {
            Section("Servers") {
                ForEach($serverList) { $selected in
                    TextField("", text: $selected.tag)
                        .textFieldStyle(.plain)
                        .tag(selected.id)
                }
                .onDelete(perform: deleteRow)
                .onMove(perform: moveRows)
                // TODO: allow edit tag
                // TODO: implement drag & drop
            }
        }
        .listStyle(.bordered(alternatesRowBackgrounds: true))
        .safeAreaInset(edge: .bottom) {
            HStack {
                Button(action: addRow) {
                    Image(systemName: "plus")
                }
                .help("Add")
                //Button(action: deleteRow) {
                //Image(systemName: "minus")
                //}
                
                Button(action: duplicateRow) {
                    Image(systemName: "square.on.square")
                }
                .help("Clone")
                .disabled(selectedServer == nil)
                
                Button(action: { sharePresented.toggle() }) {
                    Image(systemName: "square.and.arrow.up")
                }
                .popover(isPresented: $sharePresented, content: shareView)
                .help("Share")
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
    
    func shareView() -> some View {
        Text("not implemented").frame(width: 100, height: 100)
    }
    
    func addRow() {
        let newServer = OutboundObject(tag: "new", proxySettings: VlessSettingsObject(), streamSettings: StreamSettingsObject())
        selectedServer = newServer.id
        serverList.append(newServer)
    }
    
    func duplicateRow() {
        /*
        if let server = selectedServer {
            serverList.append(server)
        }
         */
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
