//
//  TestView.swift
//  XClient
//
//  Created by 李浩安 on 2023/3/21.
//  this a file to test the struct not updating issue

import SwiftUI
import Network

struct testObj {
    let id = UUID()
    var tag: String
    var changed: Bool
    var sendThrough: IPAddress?
    var streamSettings: StreamSettingsObject
    //var proxySettings: ProxySettings
}

extension testObj: Identifiable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.tag == rhs.tag
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(tag)
    }
    
    //var id: Self { self }
    // the user edits Outbound.Data; Outbound gets updated only when "ok" is pressed
    struct Data {
        var changed: Bool = true
        var tag = "world"
        var sendThrough: IPAddress? = IPv4Address("0.0.0.0")
        var streamSettings: StreamSettingsObject = StreamSettingsObject()
        /*
        var proxyProtocol: Proxy = Proxy.vless
        var allProxySettings: AllProxySettings = AllProxySettings()
         */
    }
    
    // `data` struct and the stored struct is different. The conversion is done here
    var data: Data {
        /*
        var allProxySettings = AllProxySettings()
        switch proxySettings.proxyProtocol {
        case .vless:
            allProxySettings.vlessSettings = proxySettings as! VlessSettingsObject
        case .vmess:
            allProxySettings.vmessSettings = proxySettings as! VmessSettingsObject
        default:
            break
        }
         */
        return Data(tag: tag, sendThrough: sendThrough, streamSettings: streamSettings)//, proxyProtocol: proxySettings.proxyProtocol, allProxySettings: allProxySettings)
    }
    
    mutating func update(from data: Data) {
        changed = data.changed
        tag = data.tag
        sendThrough = data.sendThrough
        streamSettings = data.streamSettings
        /*
        switch data.proxyProtocol {
        case .vless:
            proxySettings = data.allProxySettings.vlessSettings as ProxySettings
        case .vmess:
            proxySettings = data.allProxySettings.vmessSettings
        default:
            break
        }
         */
    }
}

struct TestView: View {
    @State var obj: testObj
    @State private var objData = testObj.Data()
    var body: some View {
        HStack {
            VStack {
                Text(obj.changed ? "hello" : "world")
                Text(objData.changed ? "hello" : "world")
                Button("hello") {
                    objData.changed = true
                }
                Button("world") {
                    objData.changed = false
                }
            }
            .frame(width: 100, height: 200)
            VStack {
                Text(obj.streamSettings.network.rawValue)
                Text(objData.streamSettings.network.rawValue)
                Button("tcp") {
                    objData.streamSettings.network = StreamNetwork.tcp
                }
                Button("kcp") {
                    objData.streamSettings.network = StreamNetwork.kcp
                }
            }
            Button("flush") {
                objData = obj.data
            }
            Button("save") {
                obj.update(from: objData)
            }
            .frame(width: 100, height: 200)
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView(obj: testObj(tag: "hello", changed: false, streamSettings: StreamSettingsObject()))
    }
}
