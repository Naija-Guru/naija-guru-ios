import SwiftUI

struct NumbersAndSymbols: View {
    
    @State var isNumberLockOn = true
    
    var numberWidth: CGFloat = 33
    var specialButtonWidth: CGFloat = 33
    var spacing : CGFloat
    var verticalSpace : CGFloat
    let insertText: (String) -> Void
    let backSpace: () -> Void
    
    let numberAndSymbols: [[String]] = [
        ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"],
        ["-", "/", ":", ";", "(", ")", "₦", "&", "@", "\""],
        [".", ",", "?", "!", "'",]
    ]
    
    let moreSymbols: [[String]] = [
        ["[", "]", "{", "}", "#", "%", "^", "*", "+", "="],
        ["_", "\\", "|", "~", "<", ">", "€", "£", "$", "·"],
        [".", ",", "?", "!", "'",]
    ]

    
    var body: some View {
        VStack(spacing: verticalSpace) {
            HStack(spacing: spacing) {
                ForEach((isNumberLockOn ?numberAndSymbols : moreSymbols)[0], id: \.self) { key in
                    CharacterButton(title: key, width: numberWidth, insertText: insertText)
                }
            }

            HStack(spacing: spacing) {
                ForEach((isNumberLockOn ?numberAndSymbols : moreSymbols)[1], id: \.self) { key in
                    CharacterButton(title: key, width: numberWidth, insertText: insertText)
                }
            }

            let fullWidth = (numberWidth + spacing) * 10
            let remainingWidth = fullWidth - (specialButtonWidth) * 5
            let tSpecialWidth = (remainingWidth/2)-20

            HStack {
                Spacer().frame(width: spacing, height: 0)
                HStack(spacing: spacing) {
                    
                    SpecialButton(image: nil, title: isNumberLockOn ? "#+=" : "123", width: tSpecialWidth, isDark: true){
                        isNumberLockOn = !isNumberLockOn
                    }

                    ForEach((isNumberLockOn ?numberAndSymbols : moreSymbols)[2], id: \.self) { key in
                        CharacterButton(title: key, width: specialButtonWidth , insertText: insertText)
                    }

                    SpecialButton(image: "delete.backward", title: "", width: tSpecialWidth, isDark: true){
                        backSpace()
                    }
                    
                    
                }
                Spacer().frame(width: spacing, height: 0)
            }

        }
    }
}

#Preview {
    NumbersAndSymbols(spacing: 33, verticalSpace: 44, insertText: {_ in }, backSpace: {})
}
