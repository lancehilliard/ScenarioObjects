:: This script assumes you've already set your NuGet API key:
:: http://nuget.org/account displays it and the command to set it

@echo off
C:\NuGet\NuGet pack
C:\NuGet\NuGet push *.nupkg
del *.nupkg