# NetworkService

Пример использования API marvel

## GET запрос

1. Подготовка модели.

![ScreenModel](https://github.com/korotkovak/NetworkService/blob/develop/Sources/IImages/Model.png)

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
