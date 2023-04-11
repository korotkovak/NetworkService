# NetworkService

Пример использования API marvel

## GET запрос

1. Подготовка модели.

```
struct ComicDataWrapper: Codable {
    var data: ComicDataContainer
}

struct ComicDataContainer: Codable {
    var count: Int?
    var results: [Comic]
}

struct Comic: Codable {
    var id: Int
    var title: String?
    var description: String?
    var pageCount: Int?
    var thumbnail: Image
    var creators: CreatorList
}

struct Image: Codable {
    var path: String?
    var format: String?

    enum CodingKeys: String, CodingKey {
        case format = "extension"
        case path
    }
}

struct CreatorList: Codable {
    var items: [CreatorSummary]?
}

struct CreatorSummary: Codable {
    var name: String?
    var role: String?
}
```

---
2. Определяем среду и домен для API.

```
import NetworkService

struct ComicsEnvironment: Environment {
    var scheme = "https"
    var host = "gateway.marvel.com"
}
```

---
3. Формируем конечную точку для API. Определяем путь, метод, параметры. Если нужно, можно опеределить header.

```
import CryptoKit
import NetworkService

enum ComicsEndpoint: Endpoint {

    case comics

    var path: String {
        switch self {
        case .comics:
            return "/v1/public/comics"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .comics:
            return .get
        }
    }

    var parameters: [String : Any] {
        switch self {
        case .comics:
            let publicKey = "7b8e485606503dda985b5811626331c2"
            let privateKey = "9f71fa61e8a9dec9e7904cd00c41ded68e76d4cf"
            let ts = String(Date().timeIntervalSince1970)
            let hash = "\(ts)\(privateKey)\(publicKey)".MD5()

            return ["limit": "100", "formatType": "comic", "ts": ts, "apikey": publicKey, "hash": hash]
        }
    }
}
```

---
4. Формируем get запрос: 
     - определяем Request.
     - создаем networkDispatcher и передаем в него созданный ComicsEnvironment.
     - создаем метод, через который загружаем данные в модель. В данном примере получаем массив комиксов. Метод обязан выбрасывать ошибки и работать асинронно, для этого добавляем async throws.
     - Перед вызовом request у networkDispatcher нужно добавить try await, потому что метод request выбрасывает ошибки.
     
```
import NetworkService

protocol ComicsService {
    func getData() async throws -> [Comic]?
}

final class ComicsServiceImpl: ComicsService {

    struct ComicsRequest: Request {
        var endpoint: Endpoint = ComicsEndpoint.comics
    }

    let networkDispatcher: NetworkDispatcher = NetworkDispatcherImpl(environment: ComicsEnvironment())

    func getData() async throws -> [Comic]? {
        let response: ComicDataWrapper = try await networkDispatcher.request(ComicsRequest())
        return response.data.results
    }
}
```

---
5. Загружаем данные в массив для дальнейшего использования.

```
var comics = [Comic]()

    func fetchData() {
        Task { [unowned self] in
            do {
                let data = try await networkService.getData() ?? []
                self.comics = data
                DispatchQueue.main.async {
                    self.view?.update(with: data)
                }

            } catch {
                DispatchQueue.main.async {
                    guard let error = error as? NetworkingError else {
                        self.view?.show(.unknownError)
                        return
                    }
                    self.view?.show(error)
                }
            }
        }
    }
```
