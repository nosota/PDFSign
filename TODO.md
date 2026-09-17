# TODO.md — My personal TODO list

Claude Code MUST NOT use the file TODO.md! It is not a list of features to implement. It is not a software requirements!
Claude Code MUST ignore this file!

## Road Map

* Сделать ресайз окна без моргания и дергания содержимого PDF плавно как в Preview.
* Сайт для проекта
* Переименование файла в заголовке с изменением его имени в Recent Open (только для Mac)
* Билд для windows
* Включить sandbox(?) и выложить в AppStore.
* [done] Z порядок: наверх, вниз, на самый верх и в самый низ для объктов вытаженных из правой панели и вставленных из буфера обмена (группа кнопок до поворота страниц). Кнопки акттвны когда выделен объект.
* [done] Поддержка PDF запароленных (save с оригинальным паролем, save as с оригинальным паролем, share с оригинальным паролем)
* [done] Не открывать все окна в одном месте при открытии нескольких файлов из Finder. Открывать их с небольшим смещением.
* [done] В меню Window нуна команда Close All (закрыть все окна). (Уже есть в меню File)
* [done] Syncfusion используется в проекте или нет? — используется
* [done] Добавить Undo / Redo + соотв кнопки на заголовке окна (группа кнопок до Z-порядка). Кнопки акттвны когда есть наприавление в соответсвующей истории действий
* [done] "Cmd + R" - Rote all pages left on 90 degrees including all images dragged to the PDF page from the right panel. Old version of the command must be deleted. Кнопка на заголовке окна.
* [done] Копирование объекта с одного PDF на другой с учетом размера и угла поворота.
* [done] Копироование любого изображения из буфера обмена на поверхность PDF (без предварительного добавления в правую панель).
* [done] Управление парольной защитой файла.
* [done] Печать документа.

## Future Releases

* Заменить белый цвет / цвет фона на прозрачность.
* Сфоткать через камеру лист бумаги и сделать из этого подпись с прозрачностью.
* Добавление надписей с выбором цвета и шрифта, вращение надписей.


Here is your Essential Studio® suite with a 7-day license key. This key can be used until your community license request is approved. 
We will send your long-term license key then.
Syncfusion Community License: Ngo9BigBOggjHTQxAR8/V1JGaF5cXGpCf0x0RHxbf1x2ZFBMYFRbRHNPMyBoS35RcEViWHtedXRdRmVbUk1xVEF

flutter clean
flutter build macos
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -f /Users/ivanvaganov/Projects/PDFSign/build/macos/Build/Products/Release/PDFSign.app
open macos/Runner.xcworkspace
