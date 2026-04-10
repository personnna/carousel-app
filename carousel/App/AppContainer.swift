//
//  AppContainer.swift
//  carousel
//
//  Created by ellkaden on 10/04/26.
//

final class AppContainer {
    
    private let repository: CarouselRepository = CarouselRepositoryImpl()
    
    func makeMainViewModel() -> MainViewModel {
        MainViewModel(repository: repository)
    }
    
    func makeMainViewController() -> MainViewController {
        let vm = makeMainViewModel()
        
        Task {
            await vm.load()
        }
        
        return MainViewController(viewModel: vm)
    }
}
