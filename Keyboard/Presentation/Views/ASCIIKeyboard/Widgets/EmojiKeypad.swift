import SwiftUI
import EmojiKit

struct EmojiKeypad: View {
    
    let showAlphabetKeyboard: () -> Void
    let insertText: (String) -> Void
    let backSpace: () -> Void
    
    let emojis = EmojiManager.getAvailableEmojis()
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @State private var currentIndex: Int = 0
    
    var body: some View {
        VStack(spacing: 2){
            Spacer().frame(height: 10)
            HStack(spacing: 0){
                Text(emojis[currentIndex].name.rawValue)
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                    .padding(.leading, 12)
                Spacer()
            }
                
            TabView(selection: $currentIndex)  {
               
                ForEach(emojis, id: \.self) { emojiCategory in
                    ScrollView(.vertical) {
                        LazyVGrid(columns: columns, spacing: 10) {
                            ForEach(emojiCategory.values, id: \.self) { emoji in
                                Button(action:{
                                    insertText(emoji)
                                }){
                                    Text(emoji)
                                        .font(.system(size: 30))
                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                }
                            }
                        }
                        .padding()
                        
                        
                    }
                    .tag(emojis.firstIndex(of: emojiCategory)!)

                }
            }
            
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            HStack{
                Text("ABC")
                    .onTapGesture {
                        showAlphabetKeyboard()
                    }
                Spacer()
                EmojiTab(image: "emoji_face", systemImage: nil, isSelected: currentIndex == 0)
                    .onTapGesture {
                        currentIndex = 0
                    }
                Spacer()
                EmojiTab(image: nil, systemImage: "pawprint.fill", isSelected: currentIndex == 1)
                    .onTapGesture {
                        currentIndex = 1
                    }
                Spacer()
                EmojiTab(image: nil, systemImage: "birthday.cake", isSelected: currentIndex == 2)
                    .onTapGesture {
                        currentIndex = 2
                    }
                Spacer()
                EmojiTab(image: nil, systemImage: "soccerball", isSelected: currentIndex == 3)
                    .onTapGesture {
                        currentIndex = 3
                    }
                Spacer()
                EmojiTab(image: nil, systemImage: "car", isSelected: currentIndex == 4)
                    .onTapGesture {
                        currentIndex = 4
                    }
                Spacer()
                EmojiTab(image: nil, systemImage: "lightbulb", isSelected: currentIndex == 5)
                    .onTapGesture {
                        currentIndex = 5
                    }
                Spacer()
                EmojiTab(image: nil, systemImage: "music.note", isSelected: currentIndex == 6)
                    .onTapGesture {
                        currentIndex = 6
                    }
                Spacer()
                EmojiTab(image: nil, systemImage: "flag", isSelected: currentIndex == 7)
                    .onTapGesture {
                        currentIndex = 7
                    }
                Spacer()
                Image(systemName:"delete.backward")
                    .onTapGesture {
                        backSpace()
                    }
                
            }
            .padding(.horizontal, 12)
        }
        
    }
}

struct EmojiTab: View {
    let image : String?
    let systemImage : String?
    let isSelected : Bool
    
    var body: some View {
        if(image != nil){
            Image(image!)
                .resizable()
                .frame(width: 22, height: 22)
                .foregroundStyle(isSelected ? .black : .gray)
            
        } else if (systemImage != nil){
            Image(systemName: systemImage!)
                .foregroundStyle(isSelected ? .black : .gray)
        }else {
            EmptyView()
        }
    }
    
}

extension EmojiCategory : Hashable {
    public static func == (lhs: EmojiKit.AppleEmojiCategory, rhs: EmojiKit.AppleEmojiCategory) -> Bool {
        return lhs.name == rhs.name && lhs.values == rhs.values
    }
    
    public func hash(into hasher: inout Hasher) {
            hasher.combine(name)
            hasher.combine(values)
        }
    
}

#Preview {
    EmojiKeypad(showAlphabetKeyboard: {}, insertText: {_ in}, backSpace: {})
}

