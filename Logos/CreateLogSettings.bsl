Функция СоздатьНастройкуЛога() Экспорт
	
	ПутьККаталогуЛогирования = "e:\workspace\MicexTrader\DEV_Area\";
	мФайлы = НайтиФайлы(ПутьККаталогуЛогирования);
	Если мФайлы.Количество() = 0 Тогда
		ПутьККаталогуЛогирования = КаталогВременныхФайлов();
	КонецЕсли;
	Возврат "DEBUG, openbrokerfile, console
	|
	|appender.openbrokerfile=ВыводЛогаВФайл
	|appender.openbrokerfile.file="+ПутьККаталогуЛогирования+"openbrokerfile.log
	|appender.openbrokerfile.logName=ИмпортОтчетаБрокераОткрытие
	|
	|appender.console=ВыводЛогаВКонсоль
	|appender.console.logName=ИмпортОтчетаБрокераОткрытие";

	//TODO можно еще вывод в ЖР добавить в appender
	
КонецФункции
