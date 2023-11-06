return {
    givelic = {
        command = 'givelic'
    },
    licenses = {
        {
            title = 'Führerschein A',
            description = 'Führerschein für PKWs',
            icon = 'fas fa-car',
            jobs = {'police', 'dmv'}
        }
    },
    locales = {
        ['givelic_menu_title'] = 'Lizenzen ausstellen',
        ['givelic_notify_title'] = 'Lizenzsystem',
        ['givelic_command_usage'] = 'Nutze /givelic <Vorname_Nachname>',
        ['givelic_player_not_found'] = '%s konnte nicht gefunden werden!',
        ['givelic_player_distance'] = 'You have to be near the player!'
    },
    distanceCheck = 3.0, --set to false to disable
}