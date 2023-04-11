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

![ScreenEnvironmetn](https://github.com/korotkovak/NetworkService/blob/develop/Sources/IImages/Environmetn.png)

---
3. Формируем конечную точку для API. Определяем путь, метод, параметры. Если нужно, можно опеределить header.

![ScreenEndpoint](https://github.com/korotkovak/NetworkService/blob/develop/Sources/IImages/Endpoint.png)

---
4. Формируем get запрос: 
     - определяем Request
     - создаем networkDispatcher и передаем в него созданный ComicsEnvironment
     - создаем метод, через который загружаем данные в модель. В данном примере получаем массив комиксов. Метод обязан выбрасывать ошибки и работать асинронно, для этого добавляем async throws.
     - Перед вызовом request у networkDispatcher нужно добавить try await, потому что метод request выбрасывает ошибки.
     
![ScreenService](https://github.com/korotkovak/NetworkService/blob/develop/Sources/IImages/Service.png)

---
5. Загружаем данные в массив для дальнейшего использования

![ScreenService](https://github.com/korotkovak/NetworkService/blob/develop/Sources/IImages/FetchData.png)
