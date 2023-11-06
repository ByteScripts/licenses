local logger = {
    webhookurl = ''
}

function logger.log(src, licenseType, target)
    local data = json.encode({ embeds = {
        {
            title = settings.locales['givelic_notify_title'],
            description = settings.locales['logger_desc']:format(src, licenseType, target)
        }
    }, username = shared.resource })

    local headers = {
        ["Content-Type"] = "application/json"
    }

    PerformHttpRequest(logger.webhookurl, function(statusCode, text, headers)
    end, "POST", data, headers)
end

return logger