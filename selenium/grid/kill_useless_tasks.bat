@echo off
@echo =================================
@echo Author Kenny Wang at 2015.10.27
@echo kill useless tasks
@echo =================================
taskkill /F /IM IEDriverServer.exe
taskkill /F /IM chromedriver.exe
taskkill /F /IM iexplore.exe
taskkill /F /IM chrome.exe
taskkill /F /IM firefox.exe
taskkill /F /IM rundll32.exe