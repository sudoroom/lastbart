![Last BART Cat](images/lastBart.png)

WARNING: Untested. Use at your own risk.

This is a command line utility to show when the last bart is leaving from a specific station.

# Setup

First, ensure that your system clock is set correctly and is using the same time-zone as BART. 

```
sudo dpkg-reconfigure tzdata
```

You might want to install and set up ntpd as well to ensure you system clock stays accurate:

```
sudo apt-get install ntpdate ntp
sudo ntpdate -s ntp.ubuntu.com
sudo service ntp reload
```

Now, get yourself a BART API key here: http://api.bart.gov/api/register.aspx

Then:

```
cp settings.js.example settings.js
chmod 600 settings.js
```

Now put your API key in the settings.js file.

# Usage

```
./lastbart.js from_station_name to direction

  -l: List all stations
  -n: Only output seconds until last BART (never next BART)
  -h / --help: Show usage information.

Station name and direction can be the complete or partial.
Direction must be one of:
  sf
  richmond
  fremont
  pittsburg
```

If the last BART has already left, the program will tell you and show time left until next BART, unless -n has been specified in which case it will always report time left until the last BART of the day.

## Example

```
./lastbart.js mac to sf
The last BART has already sailed!
Next BART from MacArthur station toward sf departs in 0 hours and 7 minutes [at 4:31 am]
```

# Cronjob

put this line in your crontab:
*/10 * * * * /home/jerkey/lastbart/cronjob.sh sf "san francisco" ; sleep 2; /home/jerkey/lastbart/cronjob.sh fremont freemont ; sleep 2; /home/jerkey/lastbart/cronjob.sh pittsburg pittsburg ; sleep 2; /home/jerkey/lastbart/cronjob.sh richmond richmond

There is an example cronjob included which, if run every ten minutes, would use text to speech to announce how long until the last BART leaves but only while the last BART departure is between 30 and 10 minutes away.

The cronjob relies on espeak and bc.

# ToDo

* Test this just before and after last bart leaves
* Support arbitrary stations as directions
* If the next bart is the last bart then use real time scheduling API to get a better prediction of time
** http://api.bart.gov/docs/etd/etd.aspx

# License

License is GPLv3.

Copyright 2015 Marc Juul.

