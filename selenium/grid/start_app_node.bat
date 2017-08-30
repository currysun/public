@echo off
@echo =================================
@echo Author Kenny Wang at 2015.10.27
@echo Start appium as app node on current machine
@echo =================================
set home=%cd%
set config=%home%\app_node.json
appium --nodeconfig %config%