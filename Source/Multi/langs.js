// Перевод, по умолчанию English
let IDS_MONTHS = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
let IDS_DAYOFWEEK = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
let IDS_TODAY = 'Today';
let IDS_YESTERDAY = 'Yesterday';
let IDS_DAYSAGO = 'days ago';
let IDS_NEW_PLACE = 'New place';
let IDS_PLACES = 'Places';
let IDS_SEARCH = 'Search...';

// Навигация
let IDS_ON = 'On';
let IDS_OFF = 'Off';
let IDS_DISTANCE = 'Distance:';
let IDS_TIME_LEFT = 'Time left:';
let IDS_COORDINATES = 'Coordinates:';
let IDS_DISTANCE_UNIT_LARGE = 'km.';
let IDS_DISTANCE_UNIT_SMALL = 'm.';
let IDS_RADIUS = 'Radius:';
let IDS_GET_COORDS = 'Get coordinates';
let IDS_START = 'Start';
let IDS_STOP = 'Stop';
let IDS_COMPASS_IMG = 'compass.png';

// Настройки
let IDS_SETTINGS = 'Settings';
let IDS_SYNC_ADDRESS = 'IP or domain';
let IDS_SYNC_PORT = 'Port';
let IDS_AUTOSEARCH_IP = 'Autosearch IP address';
let IDS_ABOUT_SYNC = 'IP and port or domain to sync places with your PC or web server.';
let IDS_AUTO_SYNC = 'Sync at startup';
let IDS_ABOUT_AUTO_SYNC = 'Automatically sync on app launch.';
let IDS_AUTOSTART_NAV = 'Auto-start navigation';
let IDS_USE_COMPASS = 'Use compass';
let IDS_ABOUT_USE_COMPASS = 'If your device supports a compass, enable this option; otherwise, disable it.';

// Для всех
let IDS_FULL_RESET = 'Full reset';
let IDS_CONFIRM_FULL_RESET = 'Do you really want to reset everything? All places and settings will be deleted.';
let IDS_DARK_THEME = 'Dark theme';
let IDS_THEME_TIME_DEPENDENT = 'Theme is time dependent';
let IDS_DARK_THEME_START = 'Dark theme start';
let IDS_DARK_THEME_END = 'Dark theme end';
let IDS_ABOUT_THEME_TIME = 'The dark theme is enabled automatically by time. Specify the time in 24-hour format.';
let IDS_CATEGORIES = 'Categories:';
let IDS_CATEGORIES_LIST = 'Places\nWork\nShopping\nFood\nLeisure\nTravel\nTemporary';
let IDS_CATEGORIES_AT_RUN = 'Categories at startup';
let IDS_LAST_UPDATE = 'Last update: ';
let IDS_LOCAL_STORAGE = 'Local storage: %s of 5000 KB';

// Уведомления
let IDS_DATE_UPDATE = 'Date will be update';
let IDS_DATE_NOT_UPDATE = 'Date will not be update';
let IDS_AUTH_REJECT = 'Authorization rejected';
let IDS_SYNC_SUCCESSFUL = 'Sync successful';
let IDS_SYNC_ERROR = 'Sync error';
//let // IDS_SYNC_NEED_CONNECT = 'Need connect to the network for sync'; // Больше не используется, может пригодится в будущем
let IDS_CONNECTION_FAILED = 'Connection failed';
//let // IDS_AUTH_MISSING = 'Authorization is missing,<br>save and reset your notes'; // Не используется, может пригодится

// Русский язык
//navigator.language.toLowerCase() == 'ru-ru' || navigator.language == 'ru' // В iOS языки прописными буквами, вторая проверка нужна для Edge
let lang = navigator.language.toLowerCase();
if (lang.startsWith('ru')) {
	IDS_MONTHS = ['янв.', 'фев.', 'мар.', 'апр.', 'май', 'июн.', 'июл.', 'авг.', 'сен.', 'окт.', 'ноя.', 'дек.'];
	IDS_DAYOFWEEK = ['Понедельник', 'Вторник', 'Среда', 'Четверг', 'Пятница', 'Суббота', 'Воскресенье'];
	IDS_TODAY = 'Сегодня';
	IDS_YESTERDAY = 'Вчера';
	IDS_DAYSAGO = 'дн. назад';
	IDS_NEW_PLACE = 'Новое место';
	IDS_PLACES = 'Места';
	IDS_SEARCH = 'Поиск...';
	
	// Навигация
	IDS_ON = 'Включено';
	IDS_OFF = 'Выключено';
	IDS_DISTANCE = 'Расстояние:';
	IDS_TIME_LEFT = 'Осталось времени:';
	IDS_COORDINATES = 'Координаты:';
	IDS_DISTANCE_UNIT_LARGE = 'км.';
	IDS_DISTANCE_UNIT_SMALL = 'м.';
	IDS_RADIUS = 'Радиус:';
	IDS_GET_COORDS = 'Получить координаты';
	IDS_START = 'Старт';
	IDS_STOP = 'Стоп';
	IDS_COMPASS_IMG = 'compass_ru.png';
	
	// Настройки
	IDS_SETTINGS = 'Настройки';
	IDS_SYNC_ADDRESS = 'IP или домен';
	IDS_SYNC_PORT = 'Порт';
	IDS_AUTOSEARCH_IP = 'Автопоиск IP адреса';
	IDS_ABOUT_SYNC = 'IP адрес и порт или домен для синхронизации мест, с вашим ПК или веб-сервером.';
	IDS_AUTO_SYNC = 'Синхронизация при запуске';
	IDS_ABOUT_AUTO_SYNC = 'Автоматическая синхронизация при запуске приложения.';
	IDS_AUTOSTART_NAV = 'Автозапуск навигации';
	IDS_USE_COMPASS = 'Использование компаса';
	IDS_ABOUT_USE_COMPASS = 'Если ваше устройство поддерживает компас, включите эту опцию, иначе выключите.';
	
	// Для всех
	IDS_FULL_RESET = 'Полный сброс';
	IDS_CONFIRM_FULL_RESET = 'Вы действительно хотите сбросить всё? Все места и настройки будут удалены.';
	IDS_DARK_THEME = 'Темная тема';
	IDS_THEME_TIME_DEPENDENT = 'Тема в зависимости от времени';
	IDS_DARK_THEME_START = 'Начало тёмной темы';
	IDS_DARK_THEME_END = 'Конец тёмной темы';
	IDS_ABOUT_THEME_TIME = 'Тёмная тема включается автоматически по времени. Укажите часы в 24-часовом формате.';
	IDS_CATEGORIES = 'Категории';
	IDS_CATEGORIES_LIST = 'Места\nРабота\nПокупки\nЕда\nОтдых\nПутешествия\nВременное';
	IDS_CATEGORIES_AT_RUN = 'Категории при запуске';
	IDS_LAST_UPDATE = 'Последнее обновление: ';
	IDS_LOCAL_STORAGE = 'Локальное хранилище: %s из 5000 Кб';
	
	// Уведомления
	IDS_DATE_UPDATE = 'Дата обновится';
	IDS_DATE_NOT_UPDATE = 'Дата не обновится';
	IDS_AUTH_REJECT = 'Авторизация отклонена';
	IDS_SYNC_SUCCESSFUL = 'Синхронизация успешно завершена';
	IDS_SYNC_ERROR = 'Ошибка синхронизации';
	// IDS_SYNC_NEED_CONNECT = 'Для синхронизации нужно<br>подключиться к сети';
	IDS_CONNECTION_FAILED = 'Cоединение не удалось';
	// IDS_AUTH_MISSING = 'Авторизация отсутствует,<br>сохраните и сбросьте заметки';

// Chinese
} else if (lang.startsWith('zh')) {
	// Chinese (Simplified)
	if (lang === 'zh' || lang === 'zh-cn' || lang === 'zh-sg' || lang.startsWith('zh-hans')) {
		IDS_MONTHS = ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月'];
		IDS_DAYOFWEEK = ['星期一', '星期二', '星期三', '星期四', '星期五', '星期六', '星期日'];
		IDS_TODAY = '今天';
		IDS_YESTERDAY = '昨天';
		IDS_DAYSAGO = '天前';
		IDS_NEW_PLACE = '新地点';
		IDS_PLACES = '地点';
		IDS_SEARCH = '搜索...';

		IDS_ON = '开启';
		IDS_OFF = '关闭';
		IDS_DISTANCE = '距离：';
		IDS_TIME_LEFT = '剩余时间：';
		IDS_COORDINATES = '坐标：';
		IDS_DISTANCE_UNIT_LARGE = '公里';
		IDS_DISTANCE_UNIT_SMALL = '米';
		IDS_RADIUS = '半径：';
		IDS_GET_COORDS = '获取坐标';
		IDS_START = '开始';
		IDS_STOP = '停止';
		IDS_COMPASS_IMG = 'compass.png';

		IDS_SETTINGS = '设置';
		IDS_SYNC_ADDRESS = 'IP或域名';
		IDS_SYNC_PORT = '端口';
		IDS_AUTOSEARCH_IP = '自动搜索IP地址';
		IDS_ABOUT_SYNC = '用于与您的电脑或网页服务器同步地点的IP地址和端口或域名。';
		IDS_AUTO_SYNC = '启动时同步';
		IDS_ABOUT_AUTO_SYNC = '应用启动时自动同步。';
		IDS_AUTOSTART_NAV = '自动启动导航';
		IDS_USE_COMPASS = '使用指南针';
		IDS_ABOUT_USE_COMPASS = '如果您的设备支持指南针，请开启此选项，否则关闭。';

		IDS_FULL_RESET = '完全重置';
		IDS_CONFIRM_FULL_RESET = '您确定要重置所有内容吗？所有地点和设置将被删除。';
		IDS_DARK_THEME = '深色模式';
		IDS_THEME_TIME_DEPENDENT = '根据时间切换主题';
		IDS_DARK_THEME_START = '深色模式开始时间';
		IDS_DARK_THEME_END = '深色模式结束时间';
		IDS_ABOUT_THEME_TIME = '深色模式会根据时间自动启用。请以24小时格式指定时间。';
		IDS_CATEGORIES = '类别';
		IDS_CATEGORIES_LIST = '地点\n工作\n购物\n饮食\n休闲\n旅行\n临时';
		IDS_CATEGORIES_AT_RUN = '启动时的类别';
		IDS_LAST_UPDATE = '最后更新：';
		IDS_LOCAL_STORAGE = '本地存储：%s / 5000 KB';

		IDS_DATE_UPDATE = '日期将更新';
		IDS_DATE_NOT_UPDATE = '日期不会更新';
		IDS_AUTH_REJECT = '授权被拒绝';
		IDS_SYNC_SUCCESSFUL = '同步成功完成';
		IDS_SYNC_ERROR = '同步错误';
		// IDS_SYNC_NEED_CONNECT = '同步需要<br>连接网络';
		IDS_CONNECTION_FAILED = '连接失败';
		// IDS_AUTH_MISSING = '授权缺失，<br>请保存并重置笔记';

	} else { // Chinese (Traditional)
		IDS_MONTHS = ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月'];
		IDS_DAYOFWEEK = ['星期一', '星期二', '星期三', '星期四', '星期五', '星期六', '星期日'];
		IDS_TODAY = '今天';
		IDS_YESTERDAY = '昨天';
		IDS_DAYSAGO = '天前';
		IDS_NEW_PLACE = '新地點';
		IDS_PLACES = '地點';
		IDS_SEARCH = '搜尋...';

		IDS_ON = '開啟';
		IDS_OFF = '關閉';
		IDS_DISTANCE = '距離：';
		IDS_TIME_LEFT = '剩餘時間：';
		IDS_COORDINATES = '座標：';
		IDS_DISTANCE_UNIT_LARGE = '公里';
		IDS_DISTANCE_UNIT_SMALL = '公尺';
		IDS_RADIUS = '半徑：';
		IDS_GET_COORDS = '取得座標';
		IDS_START = '開始';
		IDS_STOP = '停止';
		IDS_COMPASS_IMG = 'compass.png';

		IDS_SETTINGS = '設定';
		IDS_SYNC_ADDRESS = 'IP或網域';
		IDS_SYNC_PORT = '連接埠';
		IDS_AUTOSEARCH_IP = '自動搜尋IP位址';
		IDS_ABOUT_SYNC = '用於與您的電腦或網站伺服器同步地點的IP位址和連接埠或網域。';
		IDS_AUTO_SYNC = '啟動時同步';
		IDS_ABOUT_AUTO_SYNC = '應用程式啟動時自動同步。';
		IDS_AUTOSTART_NAV = '自動啟動導航';
		IDS_USE_COMPASS = '使用指南針';
		IDS_ABOUT_USE_COMPASS = '如果您的裝置支援指南針，請開啟此選項，否則關閉。';

		IDS_FULL_RESET = '完全重置';
		IDS_CONFIRM_FULL_RESET = '您確定要重置所有內容嗎？所有地點和設定將被刪除。';
		IDS_DARK_THEME = '深色主題';
		IDS_THEME_TIME_DEPENDENT = '依時間切換主題';
		IDS_DARK_THEME_START = '深色主題開始時間';
		IDS_DARK_THEME_END = '深色主題結束時間';
		IDS_ABOUT_THEME_TIME = '深色主題會依時間自動啟用。請以24小時制指定時間。';
		IDS_CATEGORIES = '類別';
		IDS_CATEGORIES_LIST = '地點\n工作\n購物\n飲食\n休閒\n旅行\n臨時';
		IDS_CATEGORIES_AT_RUN = '啟動時的類別';
		IDS_LAST_UPDATE = '最後更新：';
		IDS_LOCAL_STORAGE = '本地儲存：%s / 5000 KB';

		IDS_DATE_UPDATE = '日期將更新';
		IDS_DATE_NOT_UPDATE = '日期不會更新';
		IDS_AUTH_REJECT = '授權被拒絕';
		IDS_SYNC_SUCCESSFUL = '同步成功完成';
		IDS_SYNC_ERROR = '同步錯誤';
		// IDS_SYNC_NEED_CONNECT = '同步需要<br>連接網路';
		IDS_CONNECTION_FAILED = '連線失敗';
		// IDS_AUTH_MISSING = '授權缺失，<br>請儲存並重置筆記';
	}

// Spanish
} else if (lang.startsWith('es')) {
	IDS_MONTHS = ['ene.', 'feb.', 'mar.', 'abr.', 'may.', 'jun.', 'jul.', 'ago.', 'sep.', 'oct.', 'nov.', 'dic.'];
	IDS_DAYOFWEEK = ['Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo'];
	IDS_TODAY = 'Hoy';
	IDS_YESTERDAY = 'Ayer';
	IDS_DAYSAGO = 'días atrás';
	IDS_NEW_PLACE = 'Nuevo lugar';
	IDS_PLACES = 'Lugares';
	IDS_SEARCH = 'Buscar...';

	IDS_ON = 'Encendido';
	IDS_OFF = 'Apagado';
	IDS_DISTANCE = 'Distancia:';
	IDS_TIME_LEFT = 'Tiempo restante:';
	IDS_COORDINATES = 'Coordenadas:';
	IDS_DISTANCE_UNIT_LARGE = 'km';
	IDS_DISTANCE_UNIT_SMALL = 'm';
	IDS_RADIUS = 'Radio:';
	IDS_GET_COORDS = 'Obtener coordenadas';
	IDS_START = 'Iniciar';
	IDS_STOP = 'Detener';
	IDS_COMPASS_IMG = 'compass.png';

	IDS_SETTINGS = 'Configuración';
	IDS_SYNC_ADDRESS = 'IP o dominio';
	IDS_SYNC_PORT = 'Puerto';
	IDS_AUTOSEARCH_IP = 'Búsqueda automática de IP';
	IDS_ABOUT_SYNC = 'Dirección IP y puerto o dominio para sincronizar los lugares con tu PC o servidor web.';
	IDS_AUTO_SYNC = 'Sincronizar al iniciar';
	IDS_ABOUT_AUTO_SYNC = 'Sincronización automática al iniciar la aplicación.';
	IDS_AUTOSTART_NAV = 'Inicio automático de navegación';
	IDS_USE_COMPASS = 'Usar brújula';
	IDS_ABOUT_USE_COMPASS = 'Si tu dispositivo tiene brújula, activa esta opción; si no, desactívala.';

	IDS_FULL_RESET = 'Restablecimiento completo';
	IDS_CONFIRM_FULL_RESET = '¿Realmente deseas restablecer todo? Todos los lugares y configuraciones serán eliminados.';
	IDS_DARK_THEME = 'Tema oscuro';
	IDS_THEME_TIME_DEPENDENT = 'Tema según la hora';
	IDS_DARK_THEME_START = 'Inicio del tema oscuro';
	IDS_DARK_THEME_END = 'Fin del tema oscuro';
	IDS_ABOUT_THEME_TIME = 'El tema oscuro se activa automáticamente según la hora. Usa el formato de 24 horas.';
	IDS_CATEGORIES = 'Categorías';
	IDS_CATEGORIES_LIST = 'Lugares\nTrabajo\nCompras\nComida\nOcio\nViajes\nTemporal';
	IDS_CATEGORIES_AT_RUN = 'Categorías al iniciar';
	IDS_LAST_UPDATE = 'Última actualización: ';
	IDS_LOCAL_STORAGE = 'Almacenamiento local: %s de 5000 KB';

	IDS_DATE_UPDATE = 'La fecha se actualizará';
	IDS_DATE_NOT_UPDATE = 'La fecha no se actualizará';
	IDS_AUTH_REJECT = 'Autenticación rechazada';
	IDS_SYNC_SUCCESSFUL = 'Sincronización completada con éxito';
	IDS_SYNC_ERROR = 'Error de sincronización';
	// IDS_SYNC_NEED_CONNECT = 'Necesitas estar<br>conectado a la red para sincronizar';
	IDS_CONNECTION_FAILED = 'Conexión fallida';
	// IDS_AUTH_MISSING = 'Falta la autorización,<br>guarda y reinicia tus notas';
	
// Portuguese (Brazilian Portuguese)
} else if (lang.startsWith('pt')) {
	IDS_MONTHS = ['jan.', 'fev.', 'mar.', 'abr.', 'mai.', 'jun.', 'jul.', 'ago.', 'set.', 'out.', 'nov.', 'dez.'];
	IDS_DAYOFWEEK = ['Segunda-feira', 'Terça-feira', 'Quarta-feira', 'Quinta-feira', 'Sexta-feira', 'Sábado', 'Domingo'];
	IDS_TODAY = 'Hoje';
	IDS_YESTERDAY = 'Ontem';
	IDS_DAYSAGO = 'dias atrás';
	IDS_NEW_PLACE = 'Novo local';
	IDS_PLACES = 'Locais';
	IDS_SEARCH = 'Pesquisar...';

	IDS_ON = 'Ligado';
	IDS_OFF = 'Desligado';
	IDS_DISTANCE = 'Distância:';
	IDS_TIME_LEFT = 'Tempo restante:';
	IDS_COORDINATES = 'Coordenadas:';
	IDS_DISTANCE_UNIT_LARGE = 'km';
	IDS_DISTANCE_UNIT_SMALL = 'm';
	IDS_RADIUS = 'Raio:';
	IDS_GET_COORDS = 'Obter coordenadas';
	IDS_START = 'Iniciar';
	IDS_STOP = 'Parar';
	IDS_COMPASS_IMG = 'compass.png';

	IDS_SETTINGS = 'Configurações';
	IDS_SYNC_ADDRESS = 'IP ou domínio';
	IDS_SYNC_PORT = 'Porta';
	IDS_AUTOSEARCH_IP = 'Buscar IP automaticamente';
	IDS_ABOUT_SYNC = 'Endereço IP e porta ou domínio para sincronizar locais com seu PC ou servidor web.';
	IDS_AUTO_SYNC = 'Sincronizar ao iniciar';
	IDS_ABOUT_AUTO_SYNC = 'Sincronização automática ao iniciar o aplicativo.';
	IDS_AUTOSTART_NAV = 'Início automático da navegação';
	IDS_USE_COMPASS = 'Usar bússola';
	IDS_ABOUT_USE_COMPASS = 'Se seu dispositivo tiver bússola, ative esta opção; caso contrário, desative.';

	IDS_FULL_RESET = 'Redefinição total';
	IDS_CONFIRM_FULL_RESET = 'Você realmente deseja redefinir tudo? Todos os locais e configurações serão apagados.';
	IDS_DARK_THEME = 'Tema escuro';
	IDS_THEME_TIME_DEPENDENT = 'Tema baseado na hora';
	IDS_DARK_THEME_START = 'Início do tema escuro';
	IDS_DARK_THEME_END = 'Fim do tema escuro';
	IDS_ABOUT_THEME_TIME = 'O tema escuro será ativado automaticamente com base na hora. Informe a hora no formato de 24 horas.';
	IDS_CATEGORIES = 'Categorias';
	IDS_CATEGORIES_LIST = 'Locais\nTrabalho\nCompras\nComida\nLazer\nViagens\nTemporário';
	IDS_CATEGORIES_AT_RUN = 'Categorias ao iniciar';
	IDS_LAST_UPDATE = 'Última atualização: ';
	IDS_LOCAL_STORAGE = 'Armazenamento local: %s de 5000 KB';

	IDS_DATE_UPDATE = 'Data será atualizada';
	IDS_DATE_NOT_UPDATE = 'Data não será atualizada';
	IDS_AUTH_REJECT = 'Autenticação recusada';
	IDS_SYNC_SUCCESSFUL = 'Sincronização concluída com sucesso';
	IDS_SYNC_ERROR = 'Erro na sincronização';
	// IDS_SYNC_NEED_CONNECT = 'É necessário estar<br>conectado à rede para sincronizar';
	IDS_CONNECTION_FAILED = 'Falha na conexão';
	// IDS_AUTH_MISSING = 'Autorização ausente,<br>salve e reinicie suas notas';

// French
} else if (lang.startsWith('fr')) {
	IDS_MONTHS = ['janv.', 'févr.', 'mars', 'avr.', 'mai', 'juin', 'juil.', 'août', 'sept.', 'oct.', 'nov.', 'déc.'];
	IDS_DAYOFWEEK = ['Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi', 'Dimanche'];
	IDS_TODAY = 'Aujourd\'hui';
	IDS_YESTERDAY = 'Hier';
	IDS_DAYSAGO = 'jours passés';
	IDS_NEW_PLACE = 'Nouvel endroit';
	IDS_PLACES = 'Endroits';
	IDS_SEARCH = 'Recherche...';

	IDS_ON = 'Activé';
	IDS_OFF = 'Désactivé';
	IDS_DISTANCE = 'Distance :';
	IDS_TIME_LEFT = 'Temps restant :';
	IDS_COORDINATES = 'Coordonnées :';
	IDS_DISTANCE_UNIT_LARGE = 'km';
	IDS_DISTANCE_UNIT_SMALL = 'm';
	IDS_RADIUS = 'Rayon :';
	IDS_GET_COORDS = 'Obtenir les coordonnées';
	IDS_START = 'Démarrer';
	IDS_STOP = 'Arrêter';
	IDS_COMPASS_IMG = 'compass.png';

	IDS_SETTINGS = 'Paramètres';
	IDS_SYNC_ADDRESS = 'IP ou domaine';
	IDS_SYNC_PORT = 'Port';
	IDS_AUTOSEARCH_IP = 'Recherche automatique de l\'adresse IP';
	IDS_ABOUT_SYNC = 'Adresse IP et port ou domaine pour synchroniser les lieux avec votre PC ou serveur web.';
	IDS_AUTO_SYNC = 'Synchroniser au démarrage';
	IDS_ABOUT_AUTO_SYNC = 'Synchronisation automatique lors du démarrage de l\'application.';
	IDS_AUTOSTART_NAV = 'Démarrage automatique de la navigation';
	IDS_USE_COMPASS = 'Utiliser la boussole';
	IDS_ABOUT_USE_COMPASS = 'Si votre appareil possède une boussole, activez cette option, sinon désactivez-la.';

	IDS_FULL_RESET = 'Réinitialisation complète';
	IDS_CONFIRM_FULL_RESET = 'Voulez-vous vraiment tout réinitialiser ? Tous les lieux et paramètres seront supprimés.';
	IDS_DARK_THEME = 'Thème sombre';
	IDS_THEME_TIME_DEPENDENT = 'Thème selon l\'heure';
	IDS_DARK_THEME_START = 'Début du thème sombre';
	IDS_DARK_THEME_END = 'Fin du thème sombre';
	IDS_ABOUT_THEME_TIME = 'Le thème sombre s\'active automatiquement selon l\'heure. Entrez l\'heure au format 24h.';
	IDS_CATEGORIES = 'Catégories';
	IDS_CATEGORIES_LIST = 'Endroits\nTravail\nAchats\nNourriture\nLoisirs\nVoyages\nTemporaire';
	IDS_CATEGORIES_AT_RUN = 'Catégories au démarrage';
	IDS_LAST_UPDATE = 'Dernière mise à jour : ';
	IDS_LOCAL_STORAGE = 'Stockage local : %s sur 5000 Ko';

	IDS_DATE_UPDATE = 'La date sera mise à jour';
	IDS_DATE_NOT_UPDATE = 'La date ne sera pas mise à jour';
	IDS_AUTH_REJECT = 'Authentification refusée';
	IDS_SYNC_SUCCESSFUL = 'Synchronisation réussie';
	IDS_SYNC_ERROR = 'Erreur de synchronisation';
	// IDS_SYNC_NEED_CONNECT = 'Connexion au réseau<br>requise pour synchroniser';
	IDS_CONNECTION_FAILED = 'Échec de la connexion';
	// IDS_AUTH_MISSING = 'Autorisation manquante,<br>sauvegardez et réinitialisez<br>vos notes';
	
// German
} else if (lang.startsWith('de')) {
	IDS_MONTHS = ['Jan.', 'Feb.', 'März', 'Apr.', 'Mai', 'Juni', 'Juli', 'Aug.', 'Sept.', 'Okt.', 'Nov.', 'Dez.'];
	IDS_DAYOFWEEK = ['Montag', 'Dienstag', 'Mittwoch', 'Donnerstag', 'Freitag', 'Samstag', 'Sonntag'];
	IDS_TODAY = 'Heute';
	IDS_YESTERDAY = 'Gestern';
	IDS_DAYSAGO = 'Tage zuvor';
	IDS_NEW_PLACE = 'Neuer Ort';
	IDS_PLACES = 'Orte';
	IDS_SEARCH = 'Suche...';

	IDS_ON = 'Ein';
	IDS_OFF = 'Aus';
	IDS_DISTANCE = 'Entfernung:';
	IDS_TIME_LEFT = 'Verbleibende Zeit:';
	IDS_COORDINATES = 'Koordinaten:';
	IDS_DISTANCE_UNIT_LARGE = 'km';
	IDS_DISTANCE_UNIT_SMALL = 'm';
	IDS_RADIUS = 'Radius:';
	IDS_GET_COORDS = 'Koordinaten abrufen';
	IDS_START = 'Start';
	IDS_STOP = 'Stopp';
	IDS_COMPASS_IMG = 'compass.png';

	IDS_SETTINGS = 'Einstellungen';
	IDS_SYNC_ADDRESS = 'IP oder Domain';
	IDS_SYNC_PORT = 'Port';
	IDS_AUTOSEARCH_IP = 'IP-Adresse automatisch suchen';
	IDS_ABOUT_SYNC = 'IP-Adresse und Port oder Domain zur Synchronisation der Orte mit Ihrem PC oder Webserver.';
	IDS_AUTO_SYNC = 'Beim Start synchronisieren';
	IDS_ABOUT_AUTO_SYNC = 'Automatische Synchronisation beim Start der App.';
	IDS_AUTOSTART_NAV = 'Navigation automatisch starten';
	IDS_USE_COMPASS = 'Kompass verwenden';
	IDS_ABOUT_USE_COMPASS = 'Falls Ihr Gerät einen Kompass besitzt, aktivieren Sie diese Option, andernfalls deaktivieren Sie sie.';

	IDS_FULL_RESET = 'Kompletter Reset';
	IDS_CONFIRM_FULL_RESET = 'Möchten Sie wirklich alles zurücksetzen? Alle Orte und Einstellungen werden gelöscht.';
	IDS_DARK_THEME = 'Dunkles Design';
	IDS_THEME_TIME_DEPENDENT = 'Design abhängig von der Uhrzeit';
	IDS_DARK_THEME_START = 'Beginn des dunklen Designs';
	IDS_DARK_THEME_END = 'Ende des dunklen Designs';
	IDS_ABOUT_THEME_TIME = 'Das dunkle Design wird automatisch nach Uhrzeit aktiviert. Bitte im 24-Stunden-Format angeben.';
	IDS_CATEGORIES = 'Kategorien';
	IDS_CATEGORIES_LIST = 'Orte\nArbeit\nEinkaufen\nEssen\nFreizeit\nReisen\nTemporär';
	IDS_CATEGORIES_AT_RUN = 'Kategorien beim Start';
	IDS_LAST_UPDATE = 'Letzte Aktualisierung: ';
	IDS_LOCAL_STORAGE = 'Lokaler Speicher: %s von 5000 KB';

	IDS_DATE_UPDATE = 'Datum wird aktualisiert';
	IDS_DATE_NOT_UPDATE = 'Datum wird nicht aktualisiert';
	IDS_AUTH_REJECT = 'Authentifizierung abgelehnt';
	IDS_SYNC_SUCCESSFUL = 'Synchronisierung erfolgreich abgeschlossen';
	IDS_SYNC_ERROR = 'Synchronisierungsfehler';
	// IDS_SYNC_NEED_CONNECT = 'Zum Synchronisieren<br>ist eine Netzwerkverbindung erforderlich';
	IDS_CONNECTION_FAILED = 'Verbindung fehlgeschlagen';
	// IDS_AUTH_MISSING = 'Autorisierung fehlt,<br>speichern Sie und setzen<br>Sie Ihre Notizen zurück';

// Japanese
} else if (lang.startsWith('ja')) {
	IDS_MONTHS = ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月'];
	IDS_DAYOFWEEK = ['月曜日', '火曜日', '水曜日', '木曜日', '金曜日', '土曜日', '日曜日'];
	IDS_TODAY = '今日';
	IDS_YESTERDAY = '昨日';
	IDS_DAYSAGO = '日前';
	IDS_NEW_PLACE = '新しい場所';
	IDS_PLACES = '場所';
	IDS_SEARCH = '検索...';

	IDS_ON = 'オン';
	IDS_OFF = 'オフ';
	IDS_DISTANCE = '距離:';
	IDS_TIME_LEFT = '残り時間:';
	IDS_COORDINATES = '座標:';
	IDS_DISTANCE_UNIT_LARGE = 'km';
	IDS_DISTANCE_UNIT_SMALL = 'm';
	IDS_RADIUS = '半径:';
	IDS_GET_COORDS = '座標を取得';
	IDS_START = '開始';
	IDS_STOP = '停止';
	IDS_COMPASS_IMG = 'compass.png';

	IDS_SETTINGS = '設定';
	IDS_SYNC_ADDRESS = 'IPまたはドメイン';
	IDS_SYNC_PORT = 'ポート';
	IDS_AUTOSEARCH_IP = 'IPアドレスの自動検索';
	IDS_ABOUT_SYNC = 'PCまたはWebサーバーと場所を同期するためのIPアドレスとポート、またはドメインを指定してください。';
	IDS_AUTO_SYNC = '起動時に同期';
	IDS_ABOUT_AUTO_SYNC = 'アプリ起動時に自動的に同期を行います。';
	IDS_AUTOSTART_NAV = 'ナビゲーションを自動開始';
	IDS_USE_COMPASS = 'コンパスを使用';
	IDS_ABOUT_USE_COMPASS = 'お使いのデバイスがコンパスをサポートしている場合は有効にしてください。対応していない場合は無効にしてください。';

	IDS_FULL_RESET = '完全リセット';
	IDS_CONFIRM_FULL_RESET = '本当にすべてをリセットしますか？すべての場所と設定が削除されます。';
	IDS_DARK_THEME = 'ダークテーマ';
	IDS_THEME_TIME_DEPENDENT = '時間に応じたテーマ';
	IDS_DARK_THEME_START = 'ダークテーマ開始時刻';
	IDS_DARK_THEME_END = 'ダークテーマ終了時刻';
	IDS_ABOUT_THEME_TIME = 'ダークテーマは指定した時間に自動的に有効になります。24時間表記で入力してください。';
	IDS_CATEGORIES = 'カテゴリ';
	IDS_CATEGORIES_LIST = '場所\n仕事\n買い物\n食事\nレジャー\n旅行\n一時的';
	IDS_CATEGORIES_AT_RUN = '起動時のカテゴリ';
	IDS_LAST_UPDATE = '最終更新: ';
	IDS_LOCAL_STORAGE = 'ローカルストレージ: %s / 5000 KB';

	IDS_DATE_UPDATE = '日付が更新されます';
	IDS_DATE_NOT_UPDATE = '日付は更新されません';
	IDS_AUTH_REJECT = '認証が拒否されました';
	IDS_SYNC_SUCCESSFUL = '同期が正常に完了しました';
	IDS_SYNC_ERROR = '同期エラー';
	// IDS_SYNC_NEED_CONNECT = '同期するには<br>ネットワークに接続してください';
	IDS_CONNECTION_FAILED = '接続に失敗しました';
	// IDS_AUTH_MISSING = '認証がありません。<br>ノートを保存してリセットしてください';

// Arabic
} else if (lang.startsWith('ar')) {
	IDS_MONTHS = ['يناير', 'فبراير', 'مارس', 'أبريل', 'مايو', 'يونيو', 'يوليو', 'أغسطس', 'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر'];
	IDS_DAYOFWEEK = ['الاثنين', 'الثلاثاء', 'الأربعاء', 'الخميس', 'الجمعة', 'السبت', 'الأحد'];
	IDS_TODAY = 'اليوم';
	IDS_YESTERDAY = 'أمس';
	IDS_DAYSAGO = 'منذ أيام';
	IDS_NEW_PLACE = 'مكان جديد';
	IDS_PLACES = 'أماكن';
	IDS_SEARCH = 'بحث...';

	IDS_ON = 'تشغيل';
	IDS_OFF = 'إيقاف';
	IDS_DISTANCE = 'المسافة:';
	IDS_TIME_LEFT = 'الوقت المتبقي:';
	IDS_COORDINATES = 'الإحداثيات:';
	IDS_DISTANCE_UNIT_LARGE = 'كم';
	IDS_DISTANCE_UNIT_SMALL = 'م';
	IDS_RADIUS = 'نصف القطر:';
	IDS_GET_COORDS = 'الحصول على الإحداثيات';
	IDS_START = 'ابدأ';
	IDS_STOP = 'إيقاف';
	IDS_COMPASS_IMG = 'compass.png';

	IDS_SETTINGS = 'الإعدادات';
	IDS_SYNC_ADDRESS = 'IP أو اسم النطاق';
	IDS_SYNC_PORT = 'المنفذ';
	IDS_AUTOSEARCH_IP = 'البحث التلقائي عن عنوان IP';
	IDS_ABOUT_SYNC = 'عنوان IP والمنفذ أو اسم النطاق لمزامنة الأماكن مع جهاز الكمبيوتر أو الخادم.';
	IDS_AUTO_SYNC = 'المزامنة عند التشغيل';
	IDS_ABOUT_AUTO_SYNC = 'مزامنة تلقائية عند بدء التطبيق.';
	IDS_AUTOSTART_NAV = 'بدء الملاحة تلقائيًا';
	IDS_USE_COMPASS = 'استخدام البوصلة';
	IDS_ABOUT_USE_COMPASS = 'إذا كان جهازك يدعم البوصلة، فعّل هذا الخيار، وإلا فقم بإيقافه.';

	IDS_FULL_RESET = 'إعادة ضبط كاملة';
	IDS_CONFIRM_FULL_RESET = 'هل أنت متأكد أنك تريد إعادة ضبط كل شيء؟ سيتم حذف جميع الأماكن والإعدادات.';
	IDS_DARK_THEME = 'الوضع الداكن';
	IDS_THEME_TIME_DEPENDENT = 'الوضع حسب الوقت';
	IDS_DARK_THEME_START = 'بداية الوضع الداكن';
	IDS_DARK_THEME_END = 'نهاية الوضع الداكن';
	IDS_ABOUT_THEME_TIME = 'يتم تفعيل الوضع الداكن تلقائيًا حسب الوقت. أدخل الوقت بصيغة 24 ساعة.';
	IDS_CATEGORIES = 'الفئات';
	IDS_CATEGORIES_LIST = 'أماكن\nعمل\nتسوق\nطعام\nترفيه\nسفر\nمؤقت';
	IDS_CATEGORIES_AT_RUN = 'الفئات عند التشغيل';
	IDS_LAST_UPDATE = 'آخر تحديث: ';
	IDS_LOCAL_STORAGE = 'التخزين المحلي: %s من 5000 ك.ب';

	IDS_DATE_UPDATE = 'سيتم تحديث التاريخ';
	IDS_DATE_NOT_UPDATE = 'لن يتم تحديث التاريخ';
	IDS_AUTH_REJECT = 'تم رفض المصادقة';
	IDS_SYNC_SUCCESSFUL = 'اكتملت المزامنة بنجاح';
	IDS_SYNC_ERROR = 'حدث خطأ في المزامنة';
	// IDS_SYNC_NEED_CONNECT = 'يلزم الاتصال<br>بالشبكة لإجراء المزامنة';
	IDS_CONNECTION_FAILED = 'فشل الاتصال';
	// IDS_AUTH_MISSING = 'التفويض مفقود،<br>يرجى حفظ ملاحظا<br>وإعادة تعيينها';

// Italian
} else if (lang.startsWith('it')) {
	IDS_MONTHS = ['gen.', 'feb.', 'mar.', 'apr.', 'mag.', 'giu.', 'lug.', 'ago.', 'set.', 'ott.', 'nov.', 'dic.'];
	IDS_DAYOFWEEK = ['Lunedì', 'Martedì', 'Mercoledì', 'Giovedì', 'Venerdì', 'Sabato', 'Domenica'];
	IDS_TODAY = 'Oggi';
	IDS_YESTERDAY = 'Ieri';
	IDS_DAYSAGO = 'giorni fa';
	IDS_NEW_PLACE = 'Nuovo luogo';
	IDS_PLACES = 'Luoghi';
	IDS_SEARCH = 'Cerca...';

	IDS_ON = 'Acceso';
	IDS_OFF = 'Spento';
	IDS_DISTANCE = 'Distanza:';
	IDS_TIME_LEFT = 'Tempo rimanente:';
	IDS_COORDINATES = 'Coordinate:';
	IDS_DISTANCE_UNIT_LARGE = 'km';
	IDS_DISTANCE_UNIT_SMALL = 'm';
	IDS_RADIUS = 'Raggio:';
	IDS_GET_COORDS = 'Ottieni coordinate';
	IDS_START = 'Avvia';
	IDS_STOP = 'Ferma';
	IDS_COMPASS_IMG = 'compass.png';

	IDS_SETTINGS = 'Impostazioni';
	IDS_SYNC_ADDRESS = 'IP o dominio';
	IDS_SYNC_PORT = 'Porta';
	IDS_AUTOSEARCH_IP = 'Ricerca automatica IP';
	IDS_ABOUT_SYNC = 'Indirizzo IP e porta o dominio per sincronizzare i luoghi con il tuo PC o server web.';
	IDS_AUTO_SYNC = 'Sincronizza all\'avvio';
	IDS_ABOUT_AUTO_SYNC = 'Sincronizzazione automatica all\'avvio dell\'app.';
	IDS_AUTOSTART_NAV = 'Avvio automatico della navigazione';
	IDS_USE_COMPASS = 'Usa la bussola';
	IDS_ABOUT_USE_COMPASS = 'Se il tuo dispositivo supporta la bussola, abilita questa opzione; altrimenti disabilitala.';

	IDS_FULL_RESET = 'Ripristino completo';
	IDS_CONFIRM_FULL_RESET = 'Sei sicuro di voler ripristinare tutto? Tutti i luoghi e le impostazioni verranno eliminati.';
	IDS_DARK_THEME = 'Tema scuro';
	IDS_THEME_TIME_DEPENDENT = 'Tema in base all\'orario';
	IDS_DARK_THEME_START = 'Inizio tema scuro';
	IDS_DARK_THEME_END = 'Fine tema scuro';
	IDS_ABOUT_THEME_TIME = 'Il tema scuro viene attivato automaticamente in base all\'orario. Usa il formato a 24 ore.';
	IDS_CATEGORIES = 'Categorie';
	IDS_CATEGORIES_LIST = 'Luoghi\nLavoro\nAcquisti\nCibo\nTempo libero\nViaggi\nTemporaneo';
	IDS_CATEGORIES_AT_RUN = 'Categorie all\'avvio';
	IDS_LAST_UPDATE = 'Ultimo aggiornamento: ';
	IDS_LOCAL_STORAGE = 'Memoria locale: %s su 5000 KB';

	IDS_DATE_UPDATE = 'La data verrà aggiornata';
	IDS_DATE_NOT_UPDATE = 'La data non verrà aggiornata';
	IDS_AUTH_REJECT = 'Autenticazione rifiutata';
	IDS_SYNC_SUCCESSFUL = 'Sincronizzazione completata con successo';
	IDS_SYNC_ERROR = 'Errore di sincronizzazione';
	// IDS_SYNC_NEED_CONNECT = 'È necessario connettersi<br>alla rete per sincronizzare';
	IDS_CONNECTION_FAILED = 'Connessione fallita';
	// IDS_AUTH_MISSING = 'Autorizzazione mancante,<br>salva e reimposta le tue note';

// Korean
} else if (lang.startsWith('ko')) {
	IDS_MONTHS = ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'];
	IDS_DAYOFWEEK = ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'];
	IDS_TODAY = '오늘';
	IDS_YESTERDAY = '어제';
	IDS_DAYSAGO = '일 전';
	IDS_NEW_PLACE = '새 장소';
	IDS_PLACES = '장소';
	IDS_SEARCH = '검색...';

	IDS_ON = '켜짐';
	IDS_OFF = '꺼짐';
	IDS_DISTANCE = '거리:';
	IDS_TIME_LEFT = '남은 시간:';
	IDS_COORDINATES = '좌표:';
	IDS_DISTANCE_UNIT_LARGE = 'km';
	IDS_DISTANCE_UNIT_SMALL = 'm';
	IDS_RADIUS = '반지름:';
	IDS_GET_COORDS = '좌표 가져오기';
	IDS_START = '시작';
	IDS_STOP = '중지';
	IDS_COMPASS_IMG = 'compass.png';

	IDS_SETTINGS = '설정';
	IDS_SYNC_ADDRESS = 'IP 또는 도메인';
	IDS_SYNC_PORT = '포트';
	IDS_AUTOSEARCH_IP = 'IP 주소 자동 검색';
	IDS_ABOUT_SYNC = 'PC나 웹 서버와 장소를 동기화할 IP 주소와 포트 또는 도메인을 입력하세요.';
	IDS_AUTO_SYNC = '시작 시 동기화';
	IDS_ABOUT_AUTO_SYNC = '앱이 실행될 때 자동으로 동기화를 수행합니다.';
	IDS_AUTOSTART_NAV = '탐색 자동 시작';
	IDS_USE_COMPASS = '나침반 사용';
	IDS_ABOUT_USE_COMPASS = '기기에 나침반이 지원되는 경우 이 옵션을 켜세요. 그렇지 않으면 꺼주세요.';

	IDS_FULL_RESET = '전체 초기화';
	IDS_CONFIRM_FULL_RESET = '정말로 모든 내용을 초기화하시겠습니까? 모든 장소와 설정이 삭제됩니다.';
	IDS_DARK_THEME = '다크 테마';
	IDS_THEME_TIME_DEPENDENT = '시간에 따라 테마 변경';
	IDS_DARK_THEME_START = '다크 테마 시작 시간';
	IDS_DARK_THEME_END = '다크 테마 종료 시간';
	IDS_ABOUT_THEME_TIME = '다크 테마는 지정한 시간에 자동으로 적용됩니다. 24시간 형식을 사용하세요.';
	IDS_CATEGORIES = '카테고리';
	IDS_CATEGORIES_LIST = '장소\n작업\n쇼핑\n음식\n여가\n여행\n임시';
	IDS_CATEGORIES_AT_RUN = '실행 시 카테고리';
	IDS_LAST_UPDATE = '마지막 업데이트: ';
	IDS_LOCAL_STORAGE = '로컬 저장소: %s / 5000KB';

	IDS_DATE_UPDATE = '날짜가 업데이트됩니다';
	IDS_DATE_NOT_UPDATE = '날짜가 업데이트되지 않습니다';
	IDS_AUTH_REJECT = '인증 거부됨';
	IDS_SYNC_SUCCESSFUL = '동기화 완료';
	IDS_SYNC_ERROR = '동기화 오류';
	// IDS_SYNC_NEED_CONNECT = '동기화를 위해<br>네트워크에 연결해야 합니다';
	IDS_CONNECTION_FAILED = '연결 실패';
	// IDS_AUTH_MISSING = '인증이 없습니다,<br>노트를 저장하고 재설정하세요';
}