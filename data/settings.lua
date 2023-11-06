return {
    givelic = {
        command = 'givelic'
    },
    licenses = {
        {
            id = 'license_a',
            title = 'Driverslicense A',
            description = 'License for cars.',
            icon = 'fas fa-car',
            item = 'water',
            jobs = {'police', 'dmv'}
        }
    },
    locales = {
        ['givelic_menu_title'] = 'Licensesystem',
        ['givelic_notify_title'] = 'Licensesystem',
        ['givelic_command_usage'] = 'Use /givelic <Firstname_Lastname>',
        ['givelic_player_not_found'] = '%s could not be found!',
        ['givelic_player_distance'] = 'You have to be near the player!',
        ['item_description_format'] = 'Besitzer: **%s**  \nLizenz: **%s**',
        ['not_enough_space'] = "The player does not have enough space",
        ['item_added'] = 'The license got given out!',
        ['logger_desc'] = '**%s** gave out **%s** to **%s**.'
    },
    distanceCheck = 3.0, --set to false to disable
}