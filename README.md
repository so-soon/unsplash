# Unsplash

**Unsplash API를 이용한 Unsplash Clone Application**

<img src="https://user-images.githubusercontent.com/59683503/112339901-6bec5200-8d03-11eb-9be8-1b6b1f67307d.png" width="375" height="667">

<img src="https://user-images.githubusercontent.com/59683503/112339943-73abf680-8d03-11eb-9e4e-926c99a9371a.png" width="375" height="667">

<img src="https://user-images.githubusercontent.com/59683503/112339957-76a6e700-8d03-11eb-996f-3394e9eb9eb9.png" width="375" height="667">

[0.Environment](#"env")

[1.Architecture](#"arch")

[2.Unit Test](#"unit")



<h2><div id="env">0. Environment</div></h2>

- Xcode 12.2

- iOS 12.0 or above

  

<div id="arch"><h2>1. Architecture</h2></div>

<img width="1001" alt="스크린샷 2021-03-24 오후 7 31 14" src="https://user-images.githubusercontent.com/59683503/112340313-c5ed1780-8d03-11eb-9b38-7f0491f4d3b2.png">


- Presentation Layer
  - View : Presenter에게 User interaction events 전송, Presenter에게 전달받은 데이터 표시(Passive,dumb), **UIKit 의존성**
  - Presenter : Usecase를 이용한 Presentation Logic, **Unit Test에 포함**
  - IoC Container : DI(Dependency injection) 수행
  - Router : View Navigation logic
- Domain Layer
  - UseCase : 특정 사용자 시나리오의 business logic, 사용자 흐름을 Repository와 연결, **Unit Test에 포함**
  - Model : View를 위한 Model, Presentation Layer와 Domain Layer에서만 사용
- Repository
  - Domain Layer와 Data Layer 사이의 Gateway, DTO(Data Transfer Object)를 통해 Request,Response관리. presenter가 데이터 출처(url,local 등)에 관여하지 않게 함, **Unit Test에 포함**
- Data Layer
  - APIService : Unsplash API와 URLSession을 통해 연결
  - CacheService : NSCache를 통한 이미지 캐싱 , **Unit Test에 포함**





<div id="unit"><h2>2. Unit Test</h2></div>

- Unit Test
  - Presenter,UseCase,Repository,CacheService 대상
  - 총 56개
  - 테스트 함수명 : Given조건 _When테스트대상 _Then기대결과
  - APIService는 Unsplash API request limit(50 per hour) 관계로 생략

- Code Coverage

<img width="854" alt="스크린샷 2021-03-24 오후 7 48 41" src="https://user-images.githubusercontent.com/59683503/112340393-d69d8d80-8d03-11eb-8a6b-216064b8ea9c.png">














