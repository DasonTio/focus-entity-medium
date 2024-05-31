//
//  ContentView.swift
//  focus-entity-medium
//
//  Created by Dason Tiovino on 31/05/24.
//
import SwiftUI
import RealityKit
import ARKit
import FocusEntity

struct ContentView: View {

    var body: some View {
        ZStack {
            ARViewContainer().edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                HStack{
                    Button(action: {
                        NotificationCenter.default.post(name: .placeModel, object: nil)
                    }){
                        Image(systemName: "plus")
                            .font(.headline)
                            .foregroundStyle(.black)
                            .padding()
                            .background(.white)
                            .clipShape(Circle())
                            .padding()
                    }
                } 
            }
        }
    }
}

    

struct ARViewContainer: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
        // update here
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ARViewContainer>) -> ViewController {
        let viewController = ViewController()
        return viewController
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension Notification.Name {
    static let placeModel = Notification.Name("placeModel")
}
