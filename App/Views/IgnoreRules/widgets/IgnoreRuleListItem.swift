import SwiftUI

struct IgnoreRuleListItem: View {
    
    let ignoreRule : IgnoreRule
    var onRemove : () -> Void
    
    var body: some View {
        
        HStack {
            Text(ignoreRule.displayTitle)
                .font(.custom("Poppins-SemiBold", size: 14))
                .foregroundColor(Color(hex: "747474"))
                .frame( alignment: .leading)
            
            Spacer()
                .frame(width: 10)
            
            Text( String(describing:  ignoreRule.ruleType))
                .font(.custom("Poppins-SemiBold", size: 14))
                .padding(.horizontal, 4)
                .padding(.vertical, 4)
                .foregroundColor(AppColors.primary)
                .background(AppColors.primaryLight)
                .overlay(RoundedCornersShape(corners: [.allCorners], radius: 0)
                    .stroke(AppColors.primary , lineWidth: 1))
            
            Spacer()
            
            Button(action: onRemove, label: {
                Image(systemName: "xmark")
                    .foregroundColor(.black)
            })
            
        }
    }
}

#Preview {
    IgnoreRuleListItem(ignoreRule: IgnoreRule(id: "CAPITALIZATION", ruleType: IgnoreRuleType.category, displayTitle: "Your First alphabet should be capital", dateTime: Date())){
        
    }
}
