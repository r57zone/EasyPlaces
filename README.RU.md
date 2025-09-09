[![EN](https://user-images.githubusercontent.com/9499881/33184537-7be87e86-d096-11e7-89bb-f3286f752bc6.png)](https://github.com/r57zone/EasyPlaces/) 
[![RU](https://user-images.githubusercontent.com/9499881/27683795-5b0fbac6-5cd8-11e7-929c-057833e01fb1.png)](https://github.com/r57zone/EasyPlaces/blob/master/README.RU.md) 
# EasyPlaces
![](https://github.com/user-attachments/assets/f728a53e-3050-46d7-b6ee-14b0071b0114)

Приложения простой навигации и записи координат для Android и Windows, с прямой локальной синхронизацией. Сервером выступает приложение для Windows (для синхронизации необходимо запускать его).

## Особенности
Поддерживаются следующие языки: английский, русский, китайский (упрощённый/традиционный), испанский, португальский (бразильский португальский), французкий, немецкий, японский, арабский, итальянский, корейский и турецкий.

![flag-united-kingdom](https://github.com/user-attachments/assets/8c03c9b8-d154-466f-b9c4-6ea60278d537)
![flag-russia](https://user-images.githubusercontent.com/9499881/27683795-5b0fbac6-5cd8-11e7-929c-057833e01fb1.png)
![flag-china](https://github.com/user-attachments/assets/16848591-2baf-4300-893b-b95d5249a34e)
![flag-spanish](https://github.com/user-attachments/assets/a892b7ce-d83f-4914-9c54-9ba16c9c9e38)
![flag-brazil](https://github.com/user-attachments/assets/f2544579-81df-43b4-94c5-59c569828182)
![flag-french](https://github.com/user-attachments/assets/57f54331-32a3-4146-823c-4aa85a4c6669)
![flag-germany](https://github.com/user-attachments/assets/11066aa3-7c0d-4507-9df1-cad00fe53fad)
![flag-japan](https://github.com/user-attachments/assets/37cfc183-4de7-4d5a-a698-0da1286a6ee1)
![flag-egypt](https://github.com/user-attachments/assets/44399d0f-f05f-4d44-a4ab-13b6d7ded087)
![flag-saudi-arabia](https://github.com/user-attachments/assets/07d7d133-5a21-4bde-8c37-c1ef3772ac91)
![flag-united-arab-emirates](https://github.com/user-attachments/assets/81d3b610-a2f4-44c9-b2ad-20e4d7cfb2b2)
![flag-italy](https://github.com/user-attachments/assets/692490d6-bc53-446f-99b8-bf2becb8ec0d)
![flag-north-korea](https://github.com/user-attachments/assets/5b315a3d-6ce0-4cbb-b7a3-133ef2bcb2c5)
![flag-south-korea](https://github.com/user-attachments/assets/ed3d3778-9193-444a-85fd-ac5dd7bc91c6)
![flag-turkey](https://github.com/user-attachments/assets/e18e5455-7321-4632-bf3f-19921b42a7ce)


Android приложение имеет тёмную тему и автоматическое переключение на неё в тёмное время суток.


Присутствует полная поддержка планшетов.


Если необходимо оставить старую дату, при редактировани места, то на мобильных телефонах нужно нажать на дату, а на ПК зажать клавишу `Shift`, при нажатии на кнопку готово.


Имеется ограничение на 5 мегабайт для заметок (кроме ПК), следить за объёмом доступной памяти можно в настройках приложения.


На Android есть поддержка устройств без компаса, вращение происходит на основе координат навигации. Если вы едете в общественном транспорте задом наперед переключите режим передвижения на обратный.


Переключайте режим передвижения, нажав на оставшееся время, чтобы отображаемое время соответствовало выбранному типу движения.

## Настройка
### Windows
Программа для Windows выступает в роли серверного приложения, с которым синхронизируется мобильное приложение.

### Android
Установите `EasyPlaces.apk`, выберите автопоиск IP адреса или введите зарезервированный постоянный IP вашего компьютера (об этом ниже). Если ваш маршрутизатор присваивает следующие IP адреса: `192.168.0.0/15`, `192.168.0.100/115`, `192.168.1.0/15`, `192.168.1.100/115`, `192.168.2.0/15`, `192.168.3.0/15`, то можно просто включить автопоиск IP адреса и приложение само найдет ваш компьютер.

### Синхронизация мобильных приложений по P2P (опционально, в случае проблем)
Проверьте брандмауэр Windows, разрешены ли входящие подключения у вашего типа сети (частной) и разрешите если отключены. 

Далее для приложений Windows, Android и iOS 13+ можно включить автопоиск IP-адреса, и попробовать синхронизироваться. Если синхронизация не работает или у вас более старая iOS, то попробуйте проделать следующее:
1. Зарезервируйте постоянный IP адрес компьютеру, с Windows приложением. Это делается в настройках Wi-Fi роутера, в разделе "DHCP".
2. Зарезервируйте постоянный IP адрес мобильного устройства и добавьте его, если он отсуствует, в настройках приложения для Windows. Также можно открыть доступ для всех IP адресов (небезопасно). При необходимости удалите ненужные IP адреса.

## Скриншоты
### Windows
[![](https://github.com/user-attachments/assets/1deeb29c-a13f-45e1-80bd-9e633adb4668)](https://github.com/user-attachments/assets/e93bf7c6-0659-435b-ad15-a689c5380dc5)

### Android
[![UI](https://github.com/user-attachments/assets/6717a9a0-11ba-42c2-ae28-0fc9b2901ea3)](https://github.com/user-attachments/assets/2450c0ef-e31e-40ef-b0ee-564720d56e0f)

## Загрузка
>Версии для Android 7.1+ и Windows 10+.

**[Загрузить](https://github.com/r57zone/EasyPlaces/releases)**

## Обратная связь
`r57zone[собака]gmail.com`