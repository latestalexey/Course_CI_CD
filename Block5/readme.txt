Надстройка над Jenkins - pipeline

представление сборочного процесса, как кода
все шаги пишутся в jenkinsfile на языке groovy (надстройка над java)
файл хранится в репозитории продукта
в jenkins создается задачи и указывается путь к этому файлу
за выполнением этапов следит отдельный сервис на мастер-узле
наглядная визуализация всего процесса сборки

jenkinsfile кладем в репозиторий, чтобы его версия была связана с версией репозитория.
репозиторий здесь: e:\workspace\git\trade\

сервер 1С установлен версии 8.3.10.2639, порты 2540, 2541, 2560-2591

Создаем сервер RAS
В командной строке (запущенной от администратора) пишем
sc create "1C:Enterprise RAS" binpath="\"c:\Program Files (x86)\1cv8\8.3.10.2639\bin\ras.exe\" cluster --service --port=2545 localhost:2540"
Должны получить:
[SC] CreateService: успех
Потом заходим в services.msc и запускаем службу. Также можно поменять запуск на Автоматический.
Проверяем, что сервер администрирования запущен
"c:\Program Files (x86)\1cv8\8.3.10.2639\bin\rac.exe" localhost:2545 cluster list
Если все хорошо, то получим ответ:
cluster                       : 435385a9-661f-4906-936a-53e44b41d0c6
host                          : DESKTOP-5TC1CV4
port                          : 2541
name                          : "Локальный кластер"
expiration-timeout            : 0
lifetime-limit                : 0
max-memory-size               : 0
max-memory-time-limit         : 0
security-level                : 0
session-fault-tolerance-level : 0
load-balancing-mode           : performance
errors-count-threshold        : 0
kill-problem-processes        : 0



Блокировка базы
deployka session lock -ras localhost:2545 -db trade_test -lockmessage "base is blocked" -lockuccode 123

Ответ:
ИНФОРМАЦИЯ - Получаю список кластеров
ИНФОРМАЦИЯ - Получаю список баз кластера
ИНФОРМАЦИЯ - Получен УИД базы
ИНФОРМАЦИЯ - Сеансы запрещены

Закрытие соединений
deployka session kill -ras localhost:2545 -db trade_test -lockmessage "base is blocked" -lockuccode 123

Отмена блокировки базы
deployka session unlock -ras localhost:2545 -db trade_test -lockmessage "base is blocked" -lockuccode 123

Jenkinsfile храним в репозитории конфигурации. Рядом с /src/cf/, т.к. пути строятся относительно расположения файла.

В Jenkinsfile для паролей и адреса сервера будем использовать переменные среды


${env.ServerRAS} это localhost:2545 (сервер RAS)
${env.Database1C} это trade_test
${env.Server1C} это localhost:2541 (сервер 1C)
${env.StoragePath} это E:/workspace/storage_trade\


В учебном виде дается пример Jenkinsfile, который успешно компилируется дженкинсом , но у меня
этот файл не захотел работать с первого раза.
При сборке выдавалась ошибка

Started by an SCM change
Obtained Jenkinsfile from git http://10.0.75.1:10080/nikolai/trade
[Pipeline] End of Pipeline
groovy.lang.MissingPropertyException: No such property: connectionString for class: groovy.lang.Binding
	at groovy.lang.Binding.getVariable(Binding.java:63)
	...
	
подобный кейс описан здесь(1)
https://stackoverflow.com/questions/45514585/exception-while-executing-groovy-script-from-jenkinsfile-groovy-lang-missingprop
и здесь (2)
https://stackoverflow.com/questions/39256131/no-such-property-error-for-string-in-groovy

Я сделал, как в (1) и это помогло, объявил переменную без def:
connectionString = ""

цитата из (1): define it without def to make it global
