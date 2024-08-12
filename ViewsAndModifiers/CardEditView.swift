//
//  CardEditView.swift
//  ViewsAndModifiers
//
//  Created by Seungyoo Kim-Jung on 7/4/24.
//


import SwiftData
import SwiftUI
import PencilKit


struct CardEditView: View {
    @State private var path = NavigationPath()
    @Environment(\.modelContext) var modelContext
    @Bindable var card: Card
    @State private var newTagName = ""
    @State private var disableScroll: Bool = false
    
    @Query(sort: [SortDescriptor(\Tag.tagName)]) var tags: [Tag]
    @Query(sort: [SortDescriptor(\Deck.name)]) var decks: [Deck]
    
    @State private var duplicateTagAlert: Bool = false
    
    var body: some View {
        Form {
            TextField("Name", text: $card.front)
            TextField("Details", text: $card.back, axis: .vertical)
            
            //            Section("Level") {
            //                Picker("Level", selection: $card.priority) {
            //                    Text("Super ez").tag(1)
            //                    Text("ez").tag(2)
            //                    Text("difficult").tag(3)
            //                    Text("Super difficult").tag(4)
            //                }
            //                .pickerStyle(.segmented)
            //            }
            
            
            NavigationLink(destination:DeckChooseView(decks: decks, card: card)) {
                Text("Choose your deck (required)")
            }
            
            VStack{
                Button("\(disableScroll ? "Enable" : "Disable") Scroll") {
                    disableScroll.toggle()
                }
                HStack{
                    FreeFormDrawingView(card: card, isFront: true)
                    //.gesture(DragGesture(minimumDistance: 0))
                    Image("Divider")
                    FreeFormDrawingView(card: card, isFront: false)
                }//.scrollDisabled(true)
            }
            
            Section("Tags") {
                
                ForEach(card.tags) { tag in
                    Text(tag.tagName)
                }
                .onDelete(perform: removeTags)
                
                HStack {
                    TextField("Put a tag on \(card.front)", text: $newTagName)
                    
                    Button("Add", action: addTag)
                }
            }
            //.navigationTitle("Edit Card")
            //.navigationBarTitleDisplayMode(.inline)
            .alert("Duplicate Tag", isPresented: $duplicateTagAlert){
                Button("I understand", role: .cancel) {}
            } message: {
                Text("You tried to add a tag that is already tagged on this card")
            }
            
        }
        .scrollDisabled(disableScroll)
        
    }
    
    init(card: Card) {
        self.card = card
        _tags = Query()
    }
    
    func addTag() {
        guard newTagName.isEmpty == false else { return }
        for tag in card.tags {
            if tag.tagName == newTagName
            {
                duplicateTagAlert = true
                return
            }
        }
        
        var t: Tag?
        
        for tag in tags
        {
            if tag.tagName == newTagName
            {
                t = tag
                break
            }
            t = nil
        }
        
        withAnimation {
            
            let tag = t ?? Tag(tagName: newTagName)
            card.tags.append(tag)
            
        }
        newTagName = ""
        try? modelContext.save()
    }
    
    func removeTags(_ indexSet: IndexSet) {
        for index in indexSet {
            //let tag = card.tags[index]
            card.tags.remove(at: index)
            // modelContext.delete(tag)
            try? modelContext.save()
            for tag in tags {
                print(tag.tagName)
            }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Card.self, configurations: config)
        let example = Card()
        
        return CardEditView(card: example)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}


struct DeckChooseView: View {
    var decks: [Deck]
    @Bindable var card: Card
    
    var body: some View {
        if decks.isEmpty {
            Text("Hello!, please don't be sad, but you haven't created a deck yet. Please go to the decks tab to create your deck.")
        } else {
            Picker("Deck Choose", selection: $card.deck) {
                ForEach(decks) {
                    deck in
                    Text(deck.name)
                }
            }
        }
    }
}


struct FreeFormDrawingView: View {
    @State private var canvas = PKCanvasView()
    @State private var isDrawing = true
    @State private var color: Color = .black
    @State private var pencilType: PKInkingTool.InkType = .pen
    @State private var colorPicker = false
    @Environment(\.undoManager) private var undoManager
    
    @State private var clearCanvas = false
    
    @Bindable var card: Card
    
    @State private var isFront: Bool
    
    
    
    var body: some View {
        DrawingView(canvas: $canvas, isDrawing: $isDrawing, pencilType: $pencilType, color: $color)
            .toolbar{
                ToolbarItemGroup(placement: .automatic){
                    
                    Button {
                        isDrawing = true
                        pencilType = .pen
                    } label: {
                        Image(systemName: "pencil")
                    }
                    
                    Button {
                        undoManager?.undo()
                    } label: {
                        Image(systemName: "arrow.uturn.backward")
                    }
                    
                    Button {
                        undoManager?.redo()
                    } label: {
                        Image(systemName: "arrow.uturn.forward")
                    }
                    
                    Button {
                        isDrawing = false
                    } label: {
                        Image(systemName: "eraser.line.dashed")
                    }
                    
//                        Divider()
//                            .rotationEffect(.degrees(90))
                    
                    Button (role: .destructive) {
                        clearCanvas = true
                    } label: {
                        Image(systemName: "trash")
                    }
                    .foregroundStyle(.red)
                    
//                        Divider()
//                            .rotationEffect(.degrees(90))
                    
                    
                    Button {
                        saveDrawing()
                    } label: {
                        Image(systemName: "square.and.arrow.down.on.square")
                    }
                    
                }
            }
        .alert("WARNING", isPresented: $clearCanvas) {
            Button("Delete", role: .destructive, action: newCanvas)
                .fontWeight(.bold)
        } message: {
            Text("Are you sure you want to clear canvas?")
        }
    }
    
    
    init(card: Card, isFront: Bool) {
        self.card = card
        self.isFront = isFront

        do {
            if self.isFront {
                if let ddd = card.drawingFront {
                    print("before try front")
                    print(ddd)
                    canvas.drawing = try PKDrawing.init(data: ddd)
                    print("after try front")
                } else {
                    print("why is front nil????")
                }
            } else {
                if let ddd = card.drawingBack {
                    print("before try back")
                    print(ddd)
                    canvas.drawing = try PKDrawing(data: ddd)
                    print("after try back")
                } else {
                    print("why is back nil????")
                }
            }
        }
        catch {
            print("Something went wrong")
            print(self.isFront)
            print(card.drawingFront)
            print(card.drawingBack)

        }
        
    }
    
    
    func newCanvas() {
        canvas.drawing = PKDrawing()
        clearCanvas = false
    }
    
    func saveDrawing() {
        //let drawingImage = canvas.drawing.image(from: canvas.drawing.bounds, scale: 1.0)
        let drawingImage = canvas.drawing.dataRepresentation()

        if isFront {
            //card.drawingFront = drawingImage.pngData()
            card.drawingFront = drawingImage
        } else {
            card.drawingBack = drawingImage
        }
    }
}

struct DrawingView: UIViewRepresentable {
    @Binding var canvas: PKCanvasView
    @Binding var isDrawing: Bool
    @Binding var pencilType: PKInkingTool.InkType
    @Binding var color: Color
    
    var ink: PKInkingTool {
        PKInkingTool(pencilType, color: UIColor(color))
    }
    
    let eraser = PKEraserTool(.bitmap)
    
    
    
    func makeUIView(context: Context) -> PKCanvasView {
        canvas.drawingPolicy = .anyInput
        canvas.tool = isDrawing ? ink: eraser
        canvas.alwaysBounceVertical = true
        
        let toolPicker = PKToolPicker.init()
        toolPicker.setVisible(true, forFirstResponder: canvas)
        toolPicker.addObserver(canvas)
        canvas.becomeFirstResponder()
        return canvas
        
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        uiView.tool = isDrawing ? ink : eraser
    }
}


