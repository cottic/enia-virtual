// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ru';

  static m0(username) => "${username} принял(а) приглашение войти в чат";

  static m1(username) => "${username} активировал(а) сквозное шифрование";

  static m2(username) => "Принять этот запрос подтверждения от ${username}?";

  static m3(username, targetName) =>
      "${username} заблокировал(а) ${targetName}";

  static m4(homeserver) => "По умолчанию вы будете подключены к ${homeserver}";

  static m5(username) => "${username} изменил(а) аватар чата";

  static m6(username, description) =>
      "${username} изменил(а) описание чата на: \"${description}\"";

  static m7(username, chatname) =>
      "${username} изменил(а) имя чата на: \"${chatname}\"";

  static m8(username) => "${username} изменил(а) права доступа к чату";

  static m9(username, displayname) =>
      "${username} изменил(а) отображаемое имя на: ${displayname}";

  static m10(username) => "${username} изменил(а) правила гостевого доступа";

  static m11(username, rules) =>
      "${username} изменил(а) правила гостевого доступа на: ${rules}";

  static m12(username) => "${username} изменил(а) видимость истории";

  static m13(username, rules) =>
      "${username} изменил(а) видимость истории на: ${rules}";

  static m14(username) => "${username} изменил(а) правила присоединения";

  static m15(username, joinRules) =>
      "${username} изменил(а) правила присоединения на: ${joinRules}";

  static m16(username) => "${username} изменил(а) аватар";

  static m17(username) => "${username} изменил(а) псевдонимы комнаты";

  static m18(username) => "${username} изменил(а) ссылку для приглашения";

  static m19(error) => "Не удалось расшифровать сообщение: ${error}";

  static m20(count) => "${count} участника(ов)";

  static m21(username) => "${username} создал(а) чат";

  static m22(date, timeOfDay) => "${date}, ${timeOfDay}";

  static m23(year, month, day) => "${day}.${month}.${year}";

  static m24(month, day) => "${day}.${month}";

  static m25(displayname) => "Группа с ${displayname}";

  static m26(username, targetName) =>
      "${username} отозвал(а) приглашение для ${targetName}";

  static m27(groupName) => "Пригласить контакт в ${groupName}";

  static m28(username, link) =>
      "${username} пригласил(а) вас в FluffyChat. \n1. Установите FluffyChat: http://fluffychat.im \n2. Зарегистрируйтесь или войдите \n3. Откройте ссылку приглашения: ${link}";

  static m29(username, targetName) => "${username} пригласил(а) ${targetName}";

  static m30(username) => "${username} присоединился(ась) к чату";

  static m31(username, targetName) => "${username} исключил(а) ${targetName}";

  static m32(username, targetName) =>
      "${username} исключил(а) и заблокировал(а) ${targetName}";

  static m33(localizedTimeShort) =>
      "Последнее посещение: ${localizedTimeShort}";

  static m34(count) => "Загрузить еще ${count} участника(ов)";

  static m35(homeserver) => "Войти в ${homeserver}";

  static m36(number) => "${number} выбран(о)";

  static m37(fileName) => "Проиграть ${fileName}";

  static m38(username) => "${username} отредактировал(а) событие";

  static m39(username) => "${username} отклонил(а) приглашение";

  static m40(username) => "Удалено пользователем ${username}";

  static m41(username) => "Просмотрено пользователем ${username}";

  static m42(username, count) =>
      "Просмотрено пользователями ${username} и ${count} другими";

  static m43(username, username2) =>
      "Просмотрено пользователями ${username} и ${username2}";

  static m44(username) => "${username} отправил(а) файл";

  static m45(username) => "${username} отправил(а) изображение";

  static m46(username) => "${username} отправил(а) стикер";

  static m47(username) => "${username} отправил(а) видео";

  static m48(username) => "${username} отправил(а) аудио";

  static m49(username) => "${username} поделился(ась) местоположением";

  static m50(hours12, hours24, minutes, suffix) => "${hours24}:${minutes}";

  static m51(username, targetName) =>
      "${username} разблокировал(а) ${targetName}";

  static m52(type) => "Неизвестное событие \"${type}\"";

  static m53(unreadCount) => "${unreadCount} непрочитанных чата(ов)";

  static m54(unreadEvents) => "${unreadEvents} непрочитанных сообщения(ий)";

  static m55(unreadEvents, unreadChats) =>
      "${unreadEvents} непрочитанное(ых) сообщение(ий) в ${unreadChats} чате(ах)";

  static m56(username, count) =>
      "${username} и ${count} других участников печатают...";

  static m57(username, username2) => "${username} и ${username2} печатают...";

  static m58(username) => "${username} печатает...";

  static m59(username) => "${username} покинул(а) чат";

  static m60(username, type) =>
      "${username} отправил(а) событие типа \"${type}\"";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function>{
        "(Optional) Group name": MessageLookupByLibrary.simpleMessage(
            "(необязательно) Название группы"),
        "About": MessageLookupByLibrary.simpleMessage("О приложении"),
        "Accept": MessageLookupByLibrary.simpleMessage("Принять"),
        "Account": MessageLookupByLibrary.simpleMessage("Учётная запись"),
        "Account informations":
            MessageLookupByLibrary.simpleMessage("Сведения об учётной записи"),
        "Add a group description":
            MessageLookupByLibrary.simpleMessage("Добавить описание группы"),
        "Admin": MessageLookupByLibrary.simpleMessage("Администратор"),
        "Already have an account?":
            MessageLookupByLibrary.simpleMessage("Уже есть учётная запись?"),
        "Anyone can join":
            MessageLookupByLibrary.simpleMessage("Каждый может присоединиться"),
        "Archive": MessageLookupByLibrary.simpleMessage("Архив"),
        "Archived Room":
            MessageLookupByLibrary.simpleMessage("Архивированная комната"),
        "Are guest users allowed to join": MessageLookupByLibrary.simpleMessage(
            "Разрешено ли гостям присоединяться"),
        "Are you sure?": MessageLookupByLibrary.simpleMessage("Вы уверены?"),
        "Authentication":
            MessageLookupByLibrary.simpleMessage("Аутентификация"),
        "Avatar has been changed":
            MessageLookupByLibrary.simpleMessage("Аватар был изменён"),
        "Ban from chat":
            MessageLookupByLibrary.simpleMessage("Заблокировать в чате"),
        "Banned": MessageLookupByLibrary.simpleMessage("Заблокирован(а)"),
        "Block Device":
            MessageLookupByLibrary.simpleMessage("Заблокировать устройство"),
        "Cancel": MessageLookupByLibrary.simpleMessage("Отмена"),
        "Change the homeserver":
            MessageLookupByLibrary.simpleMessage("Изменить сервер Matrix"),
        "Change the name of the group":
            MessageLookupByLibrary.simpleMessage("Изменить название группы"),
        "Change the server":
            MessageLookupByLibrary.simpleMessage("Изменить сервер"),
        "Change wallpaper":
            MessageLookupByLibrary.simpleMessage("Изменить фон чатов"),
        "Change your style": MessageLookupByLibrary.simpleMessage("Тема"),
        "Changelog": MessageLookupByLibrary.simpleMessage("Журнал изменений"),
        "Chat": MessageLookupByLibrary.simpleMessage("Чат"),
        "Chat details": MessageLookupByLibrary.simpleMessage("Детали чата"),
        "Choose a strong password":
            MessageLookupByLibrary.simpleMessage("Выберите надёжный пароль"),
        "Choose a username":
            MessageLookupByLibrary.simpleMessage("Выберите имя пользователя"),
        "Close": MessageLookupByLibrary.simpleMessage("Закрыть"),
        "Confirm": MessageLookupByLibrary.simpleMessage("Подтвердить"),
        "Connect": MessageLookupByLibrary.simpleMessage("Присоединиться"),
        "Connection attempt failed": MessageLookupByLibrary.simpleMessage(
            "Попытка подключения не удалась"),
        "Contact has been invited to the group":
            MessageLookupByLibrary.simpleMessage(
                "Контакт был приглашен в группу"),
        "Content viewer":
            MessageLookupByLibrary.simpleMessage("Просмотр содержимого"),
        "Copied to clipboard":
            MessageLookupByLibrary.simpleMessage("Скопировано в буфер обмена"),
        "Copy": MessageLookupByLibrary.simpleMessage("Скопировать"),
        "Could not set avatar": MessageLookupByLibrary.simpleMessage(
            "Не удалось установить аватар"),
        "Could not set displayname": MessageLookupByLibrary.simpleMessage(
            "Не удалось установить отображаемое имя"),
        "Create": MessageLookupByLibrary.simpleMessage("Создать"),
        "Create account now": MessageLookupByLibrary.simpleMessage(
            "Создать учётную запись сейчас"),
        "Create new group":
            MessageLookupByLibrary.simpleMessage("Новая группа"),
        "Currently active": MessageLookupByLibrary.simpleMessage(
            "В настоящее время активен(а)"),
        "Dark": MessageLookupByLibrary.simpleMessage("Тёмная"),
        "Delete": MessageLookupByLibrary.simpleMessage("Удалить"),
        "Delete message":
            MessageLookupByLibrary.simpleMessage("Удалить сообщение"),
        "Deny": MessageLookupByLibrary.simpleMessage("Отклонить"),
        "Device": MessageLookupByLibrary.simpleMessage("Устройство"),
        "Devices": MessageLookupByLibrary.simpleMessage("Устройства"),
        "Discard picture":
            MessageLookupByLibrary.simpleMessage("Удалить изображение"),
        "Displayname has been changed": MessageLookupByLibrary.simpleMessage(
            "Отображаемое имя было изменено"),
        "Donate": MessageLookupByLibrary.simpleMessage("Пожертвовать"),
        "Download file": MessageLookupByLibrary.simpleMessage("Скачать файл"),
        "Edit Jitsi instance":
            MessageLookupByLibrary.simpleMessage("Сервер Jitsi"),
        "Edit displayname":
            MessageLookupByLibrary.simpleMessage("Отображаемое имя"),
        "Emote Settings":
            MessageLookupByLibrary.simpleMessage("Настройки эмодзи"),
        "Emote shortcode":
            MessageLookupByLibrary.simpleMessage("Краткий код для эмодзи"),
        "Empty chat": MessageLookupByLibrary.simpleMessage("Пустой чат"),
        "Encryption": MessageLookupByLibrary.simpleMessage("Шифрование"),
        "Encryption algorithm":
            MessageLookupByLibrary.simpleMessage("Алгоритм шифрования"),
        "Encryption is not enabled":
            MessageLookupByLibrary.simpleMessage("Шифрование не включено"),
        "End to end encryption is currently in Beta! Use at your own risk!":
            MessageLookupByLibrary.simpleMessage(
                "Сквозное шифрование в настоящее время в бета-версии! Используйте на свой риск!"),
        "End-to-end encryption settings": MessageLookupByLibrary.simpleMessage(
            "Настройки сквозного шифрования"),
        "Enter a group name":
            MessageLookupByLibrary.simpleMessage("Введите название группы"),
        "Enter a username":
            MessageLookupByLibrary.simpleMessage("Введите имя пользователя"),
        "Enter your homeserver": MessageLookupByLibrary.simpleMessage(
            "Введите адрес вашего сервера Matrix"),
        "File name": MessageLookupByLibrary.simpleMessage("Имя файла"),
        "File size": MessageLookupByLibrary.simpleMessage("Размер файла"),
        "FluffyChat": MessageLookupByLibrary.simpleMessage("FluffyChat"),
        "Forward": MessageLookupByLibrary.simpleMessage("Переслать"),
        "Friday": MessageLookupByLibrary.simpleMessage("Пятница"),
        "From joining":
            MessageLookupByLibrary.simpleMessage("С момента присоединения"),
        "From the invitation":
            MessageLookupByLibrary.simpleMessage("С момента приглашения"),
        "Group": MessageLookupByLibrary.simpleMessage("Группа"),
        "Group description":
            MessageLookupByLibrary.simpleMessage("Описание группы"),
        "Group description has been changed":
            MessageLookupByLibrary.simpleMessage(
                "Описание группы было изменено"),
        "Group is public":
            MessageLookupByLibrary.simpleMessage("Публичная группа"),
        "Guests are forbidden":
            MessageLookupByLibrary.simpleMessage("Гости запрещены"),
        "Guests can join":
            MessageLookupByLibrary.simpleMessage("Гости могут присоединиться"),
        "Help": MessageLookupByLibrary.simpleMessage("Помощь"),
        "Homeserver is not compatible":
            MessageLookupByLibrary.simpleMessage("Несовместимый сервер Matrix"),
        "How are you today?":
            MessageLookupByLibrary.simpleMessage("Как у вас сегодня дела?"),
        "ID": MessageLookupByLibrary.simpleMessage("ID"),
        "Identity": MessageLookupByLibrary.simpleMessage("Идентификация"),
        "Invite contact":
            MessageLookupByLibrary.simpleMessage("Пригласить контакт"),
        "Invited": MessageLookupByLibrary.simpleMessage("Приглашён"),
        "Invited users only": MessageLookupByLibrary.simpleMessage(
            "Только приглашённым пользователям"),
        "It seems that you have no google services on your phone. That\'s a good decision for your privacy! To receive push notifications in FluffyChat we recommend using microG: https://microg.org/":
            MessageLookupByLibrary.simpleMessage(
                "Похоже, у вас нет служб Google на вашем телефоне. Это хорошее решение для вашей конфиденциальности! Для получения push-уведомлений во FluffyChat мы рекомендуем использовать microG: https://microg.org/"),
        "Kick from chat":
            MessageLookupByLibrary.simpleMessage("Исключить из чата"),
        "Last seen IP": MessageLookupByLibrary.simpleMessage(
            "Последний IP, с которого заходили"),
        "Leave": MessageLookupByLibrary.simpleMessage("Покинуть"),
        "Left the chat": MessageLookupByLibrary.simpleMessage("Покинуть чат"),
        "License": MessageLookupByLibrary.simpleMessage("Лицензия"),
        "Light": MessageLookupByLibrary.simpleMessage("Светлая"),
        "Load more...":
            MessageLookupByLibrary.simpleMessage("Загрузить больше..."),
        "Loading... Please wait":
            MessageLookupByLibrary.simpleMessage("Пожалуйста, подождите..."),
        "Login": MessageLookupByLibrary.simpleMessage("Вход"),
        "Logout": MessageLookupByLibrary.simpleMessage("Выйти"),
        "Make a moderator":
            MessageLookupByLibrary.simpleMessage("Сделать модератором"),
        "Make an admin":
            MessageLookupByLibrary.simpleMessage("Сделать администратором"),
        "Make sure the identifier is valid":
            MessageLookupByLibrary.simpleMessage(
                "Убедитесь, что идентификатор действителен"),
        "Message will be removed for all participants":
            MessageLookupByLibrary.simpleMessage(
                "Сообщение будет удалено для всех участников"),
        "Moderator": MessageLookupByLibrary.simpleMessage("Модератор"),
        "Monday": MessageLookupByLibrary.simpleMessage("Понедельник"),
        "Mute chat":
            MessageLookupByLibrary.simpleMessage("Отключить уведомления"),
        "New message in FluffyChat": MessageLookupByLibrary.simpleMessage(
            "Новое сообщение во FluffyChat"),
        "New private chat":
            MessageLookupByLibrary.simpleMessage("Новый приватный чат"),
        "No emotes found. 😕":
            MessageLookupByLibrary.simpleMessage("Эмодзи не найдены 😕"),
        "No permission":
            MessageLookupByLibrary.simpleMessage("Нет прав доступа"),
        "No rooms found...":
            MessageLookupByLibrary.simpleMessage("Комнаты не найдены..."),
        "None": MessageLookupByLibrary.simpleMessage("Ничего"),
        "Not supported in web": MessageLookupByLibrary.simpleMessage(
            "Не поддерживается в веб-версии"),
        "Oops something went wrong...":
            MessageLookupByLibrary.simpleMessage("Упс! Что-то пошло не так..."),
        "Open app to read messages": MessageLookupByLibrary.simpleMessage(
            "Откройте приложение для чтения сообщений"),
        "Open camera": MessageLookupByLibrary.simpleMessage("Открыть камеру"),
        "Participating user devices":
            MessageLookupByLibrary.simpleMessage("Участвующие устройства"),
        "Password": MessageLookupByLibrary.simpleMessage("Пароль"),
        "Pick image":
            MessageLookupByLibrary.simpleMessage("Выбрать изображение"),
        "Please be aware that you need Pantalaimon to use end-to-end encryption for now.":
            MessageLookupByLibrary.simpleMessage(
                "Помните, что вам нужен Pantalaimon для использования сквозного шифрования."),
        "Please choose a username": MessageLookupByLibrary.simpleMessage(
            "Пожалуйста, выберите имя пользователя"),
        "Please enter a matrix identifier":
            MessageLookupByLibrary.simpleMessage(
                "Пожалуйста, введите идентификатор Matrix"),
        "Please enter your password": MessageLookupByLibrary.simpleMessage(
            "Пожалуйста, введите ваш пароль"),
        "Please enter your username": MessageLookupByLibrary.simpleMessage(
            "Пожалуйста, введите имя пользователя"),
        "Public Rooms":
            MessageLookupByLibrary.simpleMessage("Публичные комнаты"),
        "Recording": MessageLookupByLibrary.simpleMessage("Запись"),
        "Reject": MessageLookupByLibrary.simpleMessage("Отклонить"),
        "Rejoin": MessageLookupByLibrary.simpleMessage("Зайти повторно"),
        "Remove": MessageLookupByLibrary.simpleMessage("Удалить"),
        "Remove all other devices": MessageLookupByLibrary.simpleMessage(
            "Удалить все другие устройства"),
        "Remove device":
            MessageLookupByLibrary.simpleMessage("Удалить устройство"),
        "Remove exile":
            MessageLookupByLibrary.simpleMessage("Разблокировать в чате"),
        "Remove message":
            MessageLookupByLibrary.simpleMessage("Удалить сообщение"),
        "Render rich message content": MessageLookupByLibrary.simpleMessage(
            "Показывать текст с форматированием"),
        "Reply": MessageLookupByLibrary.simpleMessage("Ответить"),
        "Request permission":
            MessageLookupByLibrary.simpleMessage("Запросить разрешение"),
        "Request to read older messages": MessageLookupByLibrary.simpleMessage(
            "Запросить доступ к предыдущим сообщениям"),
        "Revoke all permissions":
            MessageLookupByLibrary.simpleMessage("Отменить все права доступа"),
        "Room has been upgraded":
            MessageLookupByLibrary.simpleMessage("Комната обновлена"),
        "Saturday": MessageLookupByLibrary.simpleMessage("Суббота"),
        "Search for a chat": MessageLookupByLibrary.simpleMessage("Поиск чата"),
        "Seen a long time ago":
            MessageLookupByLibrary.simpleMessage("Был(а) в сети давно"),
        "Send": MessageLookupByLibrary.simpleMessage("Отправить"),
        "Send a message":
            MessageLookupByLibrary.simpleMessage("Отправить сообщение"),
        "Send file": MessageLookupByLibrary.simpleMessage("Отправить файл"),
        "Send image":
            MessageLookupByLibrary.simpleMessage("Отправить изображение"),
        "Set a profile picture": MessageLookupByLibrary.simpleMessage(
            "Установить изображение профиля"),
        "Set group description":
            MessageLookupByLibrary.simpleMessage("Задать описание группы"),
        "Set invitation link": MessageLookupByLibrary.simpleMessage(
            "Установить ссылку для приглашения"),
        "Set status": MessageLookupByLibrary.simpleMessage("Задать статус"),
        "Settings": MessageLookupByLibrary.simpleMessage("Настройки"),
        "Share": MessageLookupByLibrary.simpleMessage("Поделиться"),
        "Sign up": MessageLookupByLibrary.simpleMessage("Зарегистрироваться"),
        "Skip": MessageLookupByLibrary.simpleMessage("Пропустить"),
        "Source code": MessageLookupByLibrary.simpleMessage("Исходный код"),
        "Start your first chat :-)":
            MessageLookupByLibrary.simpleMessage("Начните свой первый чат :-)"),
        "Submit": MessageLookupByLibrary.simpleMessage("Отправить"),
        "Sunday": MessageLookupByLibrary.simpleMessage("Воскресенье"),
        "System": MessageLookupByLibrary.simpleMessage("Системная"),
        "Tap to show menu": MessageLookupByLibrary.simpleMessage(
            "Нажмите, чтобы показать меню"),
        "The encryption has been corrupted":
            MessageLookupByLibrary.simpleMessage("Шифрование было повреждено"),
        "They Don\'t Match":
            MessageLookupByLibrary.simpleMessage("Они не совпадают"),
        "They Match": MessageLookupByLibrary.simpleMessage("Они совпадают"),
        "This room has been archived.": MessageLookupByLibrary.simpleMessage(
            "Эта комната была заархивирована."),
        "Thursday": MessageLookupByLibrary.simpleMessage("Четверг"),
        "Try to send again": MessageLookupByLibrary.simpleMessage(
            "Попробуйте отправить еще раз"),
        "Tuesday": MessageLookupByLibrary.simpleMessage("Вторник"),
        "Unblock Device":
            MessageLookupByLibrary.simpleMessage("Разблокировать устройство"),
        "Unknown device":
            MessageLookupByLibrary.simpleMessage("Неизвестное устройство"),
        "Unknown encryption algorithm": MessageLookupByLibrary.simpleMessage(
            "Неизвестный алгоритм шифрования"),
        "Unmute chat":
            MessageLookupByLibrary.simpleMessage("Включить уведомления"),
        "Use Amoled compatible colors?":
            MessageLookupByLibrary.simpleMessage("AMOLED-совместимые цвета"),
        "Username": MessageLookupByLibrary.simpleMessage("Имя пользователя"),
        "Verify": MessageLookupByLibrary.simpleMessage("Проверить"),
        "Verify User":
            MessageLookupByLibrary.simpleMessage("Проверить пользователя"),
        "Video call": MessageLookupByLibrary.simpleMessage("Видеозвонок"),
        "Visibility of the chat history":
            MessageLookupByLibrary.simpleMessage("Видимость истории чата"),
        "Visible for all participants":
            MessageLookupByLibrary.simpleMessage("Видима для всех участников"),
        "Visible for everyone":
            MessageLookupByLibrary.simpleMessage("Видна всем"),
        "Voice message": MessageLookupByLibrary.simpleMessage(
            "Отправить голосовое сообщение"),
        "Wallpaper": MessageLookupByLibrary.simpleMessage("Обои"),
        "Wednesday": MessageLookupByLibrary.simpleMessage("Среда"),
        "Welcome to the cutest instant messenger in the matrix network.":
            MessageLookupByLibrary.simpleMessage(
                "Добро пожаловать в самый симпатичный мессенджер в сети Matrix."),
        "Who is allowed to join this group":
            MessageLookupByLibrary.simpleMessage(
                "Кому разрешено вступать в эту группу"),
        "Write a message...":
            MessageLookupByLibrary.simpleMessage("Напишите сообщение..."),
        "Yes": MessageLookupByLibrary.simpleMessage("Да"),
        "You": MessageLookupByLibrary.simpleMessage("Вы"),
        "You are invited to this chat":
            MessageLookupByLibrary.simpleMessage("Вы приглашены в этот чат"),
        "You are no longer participating in this chat":
            MessageLookupByLibrary.simpleMessage(
                "Вы больше не участвуете в этом чате"),
        "You cannot invite yourself": MessageLookupByLibrary.simpleMessage(
            "Вы не можете пригласить себя"),
        "You have been banned from this chat":
            MessageLookupByLibrary.simpleMessage(
                "Вы были заблокированы в этом чате"),
        "You won\'t be able to disable the encryption anymore. Are you sure?":
            MessageLookupByLibrary.simpleMessage(
                "Вы больше не сможете отключить шифрование. Вы уверены?"),
        "Your own username":
            MessageLookupByLibrary.simpleMessage("Ваше имя пользователя"),
        "acceptedTheInvitation": m0,
        "activatedEndToEndEncryption": m1,
        "alias": MessageLookupByLibrary.simpleMessage("псевдоним"),
        "askSSSSCache": MessageLookupByLibrary.simpleMessage(
            "Пожалуйста, введите вашу парольную фразу или ключ восстановления для кэширования ключей."),
        "askSSSSSign": MessageLookupByLibrary.simpleMessage(
            "Для подписи ключа другого пользователя, пожалуйста, введите вашу парольную фразу или ключ восстановления."),
        "askSSSSVerify": MessageLookupByLibrary.simpleMessage(
            "Пожалуйста, введите вашу парольную фразу или ключ восстановления для подтвердждения сессии."),
        "askVerificationRequest": m2,
        "bannedUser": m3,
        "byDefaultYouWillBeConnectedTo": m4,
        "cachedKeys":
            MessageLookupByLibrary.simpleMessage("Ключи успешно кэшированы"),
        "changedTheChatAvatar": m5,
        "changedTheChatDescriptionTo": m6,
        "changedTheChatNameTo": m7,
        "changedTheChatPermissions": m8,
        "changedTheDisplaynameTo": m9,
        "changedTheGuestAccessRules": m10,
        "changedTheGuestAccessRulesTo": m11,
        "changedTheHistoryVisibility": m12,
        "changedTheHistoryVisibilityTo": m13,
        "changedTheJoinRules": m14,
        "changedTheJoinRulesTo": m15,
        "changedTheProfileAvatar": m16,
        "changedTheRoomAliases": m17,
        "changedTheRoomInvitationLink": m18,
        "compareEmojiMatch": MessageLookupByLibrary.simpleMessage(
            "Сравните и убедитесь, что следующие эмодзи соответствуют эмодзи на другом устройстве:"),
        "compareNumbersMatch": MessageLookupByLibrary.simpleMessage(
            "Сравните и убедитесь, что следующие числа соответствуют числам на другом устройстве:"),
        "couldNotDecryptMessage": m19,
        "countParticipants": m20,
        "createdTheChat": m21,
        "crossSigningDisabled":
            MessageLookupByLibrary.simpleMessage("Кросс-подпись отключена"),
        "crossSigningEnabled":
            MessageLookupByLibrary.simpleMessage("Кросс-подпись включена"),
        "dateAndTimeOfDay": m22,
        "dateWithYear": m23,
        "dateWithoutYear": m24,
        "emoteExists":
            MessageLookupByLibrary.simpleMessage("Эмодзи уже существует"),
        "emoteInvalid": MessageLookupByLibrary.simpleMessage(
            "Недопустимый краткий код эмодзи"),
        "emoteWarnNeedToPick": MessageLookupByLibrary.simpleMessage(
            "Выберите краткий код эмодзи и изображение"),
        "groupWith": m25,
        "hasWithdrawnTheInvitationFor": m26,
        "incorrectPassphraseOrKey": MessageLookupByLibrary.simpleMessage(
            "Неверный пароль или ключ восстановления"),
        "inviteContactToGroup": m27,
        "inviteText": m28,
        "invitedUser": m29,
        "is typing...": MessageLookupByLibrary.simpleMessage("Печатает..."),
        "isDeviceKeyCorrect": MessageLookupByLibrary.simpleMessage(
            "Правильно ли указан следующий ключ устройства?"),
        "joinedTheChat": m30,
        "keysCached":
            MessageLookupByLibrary.simpleMessage("Ключи сохранены в кэше"),
        "keysMissing":
            MessageLookupByLibrary.simpleMessage("Ключи отсутствуют"),
        "kicked": m31,
        "kickedAndBanned": m32,
        "lastActiveAgo": m33,
        "loadCountMoreParticipants": m34,
        "logInTo": m35,
        "newVerificationRequest": MessageLookupByLibrary.simpleMessage(
            "Новый запрос на подтверждение"),
        "noCrossSignBootstrap": MessageLookupByLibrary.simpleMessage(
            "FluffyChat в настоящее время не поддерживает включение кросс-подписи. Пожалуйста, включите его в Element."),
        "noMegolmBootstrap": MessageLookupByLibrary.simpleMessage(
            "В настоящее время FluffyChat не поддерживает функцию резервного копирования онлайн-ключей. Пожалуйста, включите её в Element."),
        "numberSelected": m36,
        "ok": MessageLookupByLibrary.simpleMessage("ok"),
        "onlineKeyBackupDisabled": MessageLookupByLibrary.simpleMessage(
            "Резервное копирование ключей на сервере отключено"),
        "onlineKeyBackupEnabled": MessageLookupByLibrary.simpleMessage(
            "Резервное копирование ключей на сервере включено"),
        "passphraseOrKey": MessageLookupByLibrary.simpleMessage(
            "пароль или ключ восстановления"),
        "play": m37,
        "redactedAnEvent": m38,
        "rejectedTheInvitation": m39,
        "removedBy": m40,
        "seenByUser": m41,
        "seenByUserAndCountOthers": m42,
        "seenByUserAndUser": m43,
        "sentAFile": m44,
        "sentAPicture": m45,
        "sentASticker": m46,
        "sentAVideo": m47,
        "sentAnAudio": m48,
        "sessionVerified":
            MessageLookupByLibrary.simpleMessage("Сессия подтверждена"),
        "sharedTheLocation": m49,
        "timeOfDay": m50,
        "title": MessageLookupByLibrary.simpleMessage("FluffyChat"),
        "unbannedUser": m51,
        "unknownEvent": m52,
        "unknownSessionVerify": MessageLookupByLibrary.simpleMessage(
            "Неизвестная сессия, пожалуйста, проверьте"),
        "unreadChats": m53,
        "unreadMessages": m54,
        "unreadMessagesInChats": m55,
        "userAndOthersAreTyping": m56,
        "userAndUserAreTyping": m57,
        "userIsTyping": m58,
        "userLeftTheChat": m59,
        "userSentUnknownEvent": m60,
        "verifiedSession":
            MessageLookupByLibrary.simpleMessage("Сессия успешно проверена"),
        "verifyManual":
            MessageLookupByLibrary.simpleMessage("Проверить вручную"),
        "verifyStart": MessageLookupByLibrary.simpleMessage("Начать проверку"),
        "verifySuccess":
            MessageLookupByLibrary.simpleMessage("Проверка успешно завершена"),
        "verifyTitle": MessageLookupByLibrary.simpleMessage(
            "Проверка другой учётной записи"),
        "waitingPartnerAcceptRequest": MessageLookupByLibrary.simpleMessage(
            "В ожидании партнёра, чтобы принять запрос..."),
        "waitingPartnerEmoji": MessageLookupByLibrary.simpleMessage(
            "В ожидании партнёра, чтобы принять эмодзи..."),
        "waitingPartnerNumbers": MessageLookupByLibrary.simpleMessage(
            "В ожидании партнёра, чтобы принять числа...")
      };
}
