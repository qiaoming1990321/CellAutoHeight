#!/usr/bin/python
#coding=utf-8

import requests
import json
import sys
import os
import urllib2
import base64
import six

reload(sys)
sys.setdefaultencoding('utf-8')


# 从蒲公英获取 App 信息
pgyer_r = requests.post(url='http://www.pgyer.com/apiv2/app/view', data={'appKey':'df3c3fb59455532193d9bbd94a43bd8c','_api_key':'a6bf4db6f46321d1b8bcc00846637110'})
pgyer_res = json.loads(pgyer_r.text)
print(pgyer_res)
pgyer_data = pgyer_res["data"]

# var = os.popen("echo $CHANGES").read()
# print(var)


def auth_headers(username, password):
    '''Simple implementation of HTTP Basic Authentication.

    Returns the 'Authentication' header value.
    '''
    auth = '%s:%s' % (username, password)
    if isinstance(auth, six.text_type):
        auth = auth.encode('utf-8')
    return b'Basic ' + base64.b64encode(auth)


jenkins_build_url = os.environ["BUILD_URL"]
jenkins_api = jenkins_build_url + "api/json/"
#jenkins_api = "http://localhost:8080/jenkins/job/its_test/10/api/json/"
jenkins_headers = {"Authorization": auth_headers("admin", "admin")}
jenkins_r = requests.get(url=jenkins_api, headers=jenkins_headers)
jenkins_res = json.loads(jenkins_r.text)
#jenkins_res = simplejson.loads(jenkins_r.text)
print(jenkins_res)
jenkins_change_set_items = jenkins_res["changeSet"]["items"]
changelogs = ""
index = 0
for item in jenkins_change_set_items:
    index += 1
    changelogs += "> {0}、{1}；\n\n".format(index, item["msg"])
print changelogs

# 更新蒲公英上传的  git记录
pgyer_r1 = requests.post(url='https://www.pgyer.com/apiv2/app/updateApp', data={'_api_key':'df3c3fb59455532193d9bbd94a43bd8c','userKey': 'a6bf4db6f46321d1b8bcc00846637110','buildUpdateDescription':changelogs,'buildKey':pgyer_data["buildKey"]})

# 钉钉通知
dd_headers = {'Content-type':'application/json'}
dd_webhook = "https://oapi.dingtalk.com/robot/send?access_token=f1c4c986e9ca3e6de55358ee8adf6fe4bf596b2dbc28cc27056e8b361cac5ed2"
build_number = os.environ["BUILD_NUMBER"]
print build_number
markdown = {
    "title":"relax 测试版本更新 - " + build_number,
    "text":"### relax 版本更新 - " + build_number + "\n\n" +
    "### {0} \n\n".format(pgyer_data["buildCreated"]) + 
    changelogs + "\n\n" + 
    "![rcode]({0})\n\n".format(pgyer_data["buildQRCodeURL"]) + 
    "[点我进入下载页面](https://www.pgyer.com/{0})\n\n".format(pgyer_data["buildShortcutUrl"])}
dd_data = {"msgtype":"markdown", "markdown":markdown}
dd_r = requests.post(url=dd_webhook, headers=dd_headers, data=json.dumps(dd_data))
print(dd_r.text)
