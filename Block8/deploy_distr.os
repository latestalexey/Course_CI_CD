// используем деплойку для разворачивания конфигурации из шаблона

ЗапуститьПриложение("deployka loadcfg /Fe:\workspace\trade1944fromTemplate\ d:\1C\1cv8\tmplts\SBCourse\trade19400\1.0.1.1\ /mode -load",,Истина);
ЗапуститьПриложение("deployka dbupdate /Fe:\workspace\trade1944fromTemplate\ -allow-warnings",,Истина);