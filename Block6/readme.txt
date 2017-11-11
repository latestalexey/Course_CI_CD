# Block 6

каталог с фичей берем из блока 4

установили vanessa-runner:
opm install vanessa-runner

написали файл настроек для runner - tools\VBParams.json

в репозиторий торговли добавили сабмодуль vanessa-behavior:
(запускать из каталога e:\workspace\git\trade\)
git submodule add https://github.com/silverbulleters/vanessa-behavior tools/vanessa-behavior
чтобы запускать по относительному пути

команда запуска runner - в файле start_vb.cmd


установили precommit1c в репозиторий торговли, как сабмодуль.

Подключаем Allure к Jenkins


Файл allure.groovy надо поместить по адресу e:\workspace\volumes\jenkins\init.groovy.d\
Этим мы разрешим дженкинсу выполнять скрипты, чтобы работала ссылка HTML-Report на странице задачи.
(требуется рестарт контейнера с Jenkins)
Строки в этом файле переносить нельзя! Иначе получим ошибку

WARNING: Failed to run script file:/var/jenkins_home/init.groovy.d/allure.groovy
org.codehaus.groovy.control.MultipleCompilationErrorsException: startup failed:
/var/jenkins_home/init.groovy.d/allure.groovy: 7: expecting anything but ''\n''; got it anyway @ line 7, column 50.
   irectoryBrowserSupport.CSP", "
                                 ^
2017-11-11T09:30:59.782508600Z 
1 error
2017-11-11T09:30:59.782513600Z 

Cucumber reports

Аллюр не позволяет анализироват успешность выполнения сценариев во времени.
Накопление статистики по выполнению сценариев предоставляет плагин cucumber reports
vanessa-behavior умеет предоставлять информацию в формате этого плагина

Его нужно вызывать через специальный шаг сборочной линии - step

синтаксис вызова шага: step([$class: 'GitHubSetCommitStatusBuilder'])

Заходим в pipeline syntax
В поле Sample step выбираем step: Generate build step
В поле Build step выбираем Cucumber reports
Нажимаем Generate pipeline script
Получаем результат, как в строке ниже.
cucumber fileIncludePattern: '**/*.json', sortingMethod: 'ALPHABETICAL'

## Публикация результатов cucumber reports в сборочной линии

в jenkinsfile добавили 
				step([
                    $class: 'CucumberReportPublisher',
                    fileIncludePattern: '*.json',
                    jsonReportDirectory: 'out/cucumber'
                ])

## Подключение Pickes

генерация живой документации.

Установка напрямую на slave-агент

идем на 
https://github.com/picklesdoc/pickles

Еще нужно установить плагин Cucumber Living Documentation
