# Edit this file to introduce tasks to be run by cron.
# 
# Each task to run has to be defined through a single line
# indicating with different fields when the task will be run
# and what command to run for the task
# 
# To define the time you can provide concrete values for
# minute (m), hour (h), day of month (dom), month (mon),
# and day of week (dow) or use '*' in these fields (for 'any').
# 
# Notice that tasks will be started based on the cron's system
# daemon's notion of time and timezones.
# 
# Output of the crontab jobs (including errors) is sent through
# email to the user the crontab file belongs to (unless redirected).
# 
# For example, you can run a backup of all your user accounts
# at 5 a.m every week with:
# 0 5 * * 1 tar -zcf /var/backups/home.tgz /home/
# 
# For more information see the manual pages of crontab(5) and cron(8)
# 
# m h  dom mon dow   command
00 00 * * * rm ~/cron/cron.log
00 00 * * * rm ~/cron/cron.err

00 00 * * * crontab -l >~/cron/cron.sh

10 00 * * * curl -sf https://raw.githubusercontent.com/shimajima-eiji/Chocolatey/master/wsl/ubuntu/auto_update_CHANGELOG.sh | sh -s -- Personal >>~/cron/cron.log 2>>~/cron/cron.err
20 00 * * * curl -sf https://raw.githubusercontent.com/shimajima-eiji/Chocolatey/master/wsl/ubuntu/auto_update_CHANGELOG.sh | sh -s -- Chocolatey >>~/cron/cron.log 2>>~/cron/cron.err
30 00 * * * curl -sf https://raw.githubusercontent.com/shimajima-eiji/Chocolatey/master/wsl/ubuntu/auto_update_CHANGELOG.sh | sh -s -- Article >>~/cron/cron.log 2>>~/cron/cron.err
40 00 * * * curl -sf https://raw.githubusercontent.com/shimajima-eiji/Chocolatey/master/wsl/ubuntu/auto_update_CHANGELOG.sh | sh -s -- Github_scout >>~/cron/cron.log 2>>~/cron/cron.err
50 00 * * * curl -sf https://raw.githubusercontent.com/shimajima-eiji/Chocolatey/master/wsl/ubuntu/auto_update_CHANGELOG.sh | sh -s -- README >>~/cron/cron.log 2>>~/cron/cron.err
00 01 * * * curl -sf https://raw.githubusercontent.com/shimajima-eiji/Chocolatey/master/wsl/ubuntu/auto_update_CHANGELOG.sh | sh -s -- Hosting GAS-snippets >>~/cron/cron.log 2>>~/cron/cron.err
10 01 * * * curl -sf https://raw.githubusercontent.com/shimajima-eiji/Chocolatey/master/wsl/ubuntu/auto_update_CHANGELOG.sh | sh -s -- Hosting GAS-timetrigger >>~/cron/cron.log 2>>~/cron/cron.err
20 01 * * * curl -sf https://raw.githubusercontent.com/shimajima-eiji/Chocolatey/master/wsl/ubuntu/auto_update_CHANGELOG.sh | sh -s -- Hosting GAS-minimum_wage >>~/cron/cron.log 2>>~/cron/cron.err
30 01 * * * curl -sf https://raw.githubusercontent.com/shimajima-eiji/Chocolatey/master/wsl/ubuntu/auto_update_CHANGELOG.sh | sh -s -- profile >>~/cron/cron.log 2>>~/cron/cron.err
40 01 * * * curl -sf https://raw.githubusercontent.com/shimajima-eiji/Chocolatey/master/wsl/ubuntu/auto_update_CHANGELOG.sh | sh -s -- Article >>~/cron/cron.log 2>>~/cron/cron.err
