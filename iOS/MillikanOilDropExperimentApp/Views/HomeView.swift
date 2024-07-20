import SwiftUI

struct HomeView: View {
    var body: some View {
        Spacer()
        VStack(spacing: 20) {
            Image("logo")
                .resizable()
                .frame(width: 80, height: 80)
            Text(NSLocalizedString("Millikan Oil Drop Experiments",comment: ""))
                .font(.title)
                .fontWeight(.bold)
            Text("(Apple Vision AR Demo)")
                .font(.caption)
            
            NavigationLink(destination: InfoView()) {
                Text(NSLocalizedString("Go to Info",comment: ""))
                    .frame(width: 200, height: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            NavigationLink(destination: DetailView()) {
                Text(NSLocalizedString("Go to Details",comment: ""))
                    .frame(width: 200, height: 50)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            NavigationLink(
                destination: SingleARView(modelName:"model02")
            ) {
                Text(NSLocalizedString("Enter AR View",comment: ""))
                    .frame(width: 200, height: 50)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        Spacer()
        
        HStack {
            Image("logo")
                .resizable()
                .frame(width: 40, height: 40)
            
            Spacer()
            
            VStack{
                Text(NSLocalizedString("authors",comment: "authors"))
                    .font(.caption)
                Text("V0.1.20240720B23")
                    .font(.caption)
            }
        }
        .padding(.horizontal)
    }
}

