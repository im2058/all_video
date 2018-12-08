#!/usr/bin/python3.5
# -*- coding:utf-8 -*-
import selenium
from selenium import webdriver
import time
import os
import sys
import json
import warnings
from pyquery import PyQuery as pq
import re
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities
import selenium.webdriver.support.ui as ui

warnings.filterwarnings('ignore')

service_args=[]
service_args.append('--load-images=no')
service_args.append('--disk-cache=yes')
service_args.append('--ignore-ssl-errors=true')


dcap = dict(DesiredCapabilities.PHANTOMJS)
dcap["phantomjs.page.settings.userAgent"] = (
        "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.221 Safari/537.36 SE 2.X MetaSr 1.0"
        )
driver = webdriver.PhantomJS(desired_capabilities=dcap)

#driver = webdriver.PhantomJS()
driver.implicitly_wait(5)
waiter = ui.WebDriverWait(driver,10)


url = sys.argv[1]
index = sys.argv[2]
wtid = sys.argv[3]

try:
    driver.get(str(url))
    waiter.until(lambda driver: driver.find_element_by_id(str(wtid)))
#   content = driver.find_element_by_id("vjs_video_3_html5_api").src
    content = driver.page_source
#    driver.quit()
    log = open(str(index),'w')
    log.write(content)
    log.close()
except Exception as e:
#(errors.TimeoutException, errors.NoSuchElementException):
    driver.get_screenshot_as_file('01.png')
    print(e)
    driver.get(str(url))
    #waiter.until(lambda driver: driver.find_element_by_id(str(wtid)))
    content = driver.page_source
    driver.quit()
    log = open(str(index),'w')
    log.write(content)
    log.close()
