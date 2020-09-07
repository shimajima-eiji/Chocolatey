## [日本語](/README.md)

# Chocolatey
A repository for managing the version of the package itself inserted with cinst.
<br>[For guidance on chocolatey, refer to the explanation site](https://shimajima-eiji.github.io/resume/tech/chocolatey)
<br>The target is the installed package itself.

# Directory description
Since administrator authority (user account control) is required, overwrite and save.

-[cinst/tablacus/tools](https://github.com/shimajima-eiji/Chocolatey/tree/master/cinst/tablacus/tools)
-Those that require additional settings for each package after inserting the package. Tablacus Explorer is assumed here. Since VS code, chromium system, and storage system can use cloud integration, they are not considered here.
-[primitive](https://github.com/shimajima-eiji/Chocolatey/tree/master/tool)
-A program that corresponds to the program of Windows itself in addition. About WSL and task scheduler
-[tool](https://github.com/shimajima-eiji/Chocolatey/tree/master/primitive)
-Preliminary plan if chocolatey.package cannot be imported. Unconfirmed operation.

# Installation guide
As work

1. Installation of chocolatey body
1.Install chocolatey.config
1. cinst directory: Settings for installed applications
1. primitive

There is only an order, and the subsequent steps can be performed in any order. The explanation is as below.

Install/Upgrade https://github.com/shimajima-eiji/Chocolatey/wiki/Chocolatey

#After installation
https://github.com/shimajima-eiji/Chocolatey/wiki/Third party that requires configuration

# trouble shooting
https://github.com/shimajima-eiji/Chocolatey/wiki/Troubleshooting
