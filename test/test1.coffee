chai = require 'chai'
should = chai.should()

api = require '../lib/api'

###
Get Google Docs from a predefined folder
###

FOLDER_ID = '0BwQ-i_0r4A6gc0tHZDBkcGNocW8'

describe.only 'foo', ->
  docs = null
  it 'should fetch docs from folder', (done) ->
    @.timeout 10000
    api.docs FOLDER_ID, (e, _docs) ->
      docs = _docs
      docs.should.be.an.instanceOf Array
      docs.should.have.length 1
      done()

  it 'first doc should have a correct title', ->
    docs[0].title.should.equal 'Doc1'
    console.log JSON.stringify docs, null, 4


###
[
    {
        "kind": "drive#file",
        "id": "1rwG68SWkLBBKuriYDJ5QDYbs-MECGNJLVoXwx9bvxKU",
        "etag": "\"PA40KOhMf9e-1Hypww_TkG8doNA/MTM3OTM4MzQ4ODUzNQ\"",
        "selfLink": "https://www.googleapis.com/drive/v2/files/1rwG68SWkLBBKuriYDJ5QDYbs-MECGNJLVoXwx9bvxKU",
        "alternateLink": "https://docs.google.com/document/d/1rwG68SWkLBBKuriYDJ5QDYbs-MECGNJLVoXwx9bvxKU/edit?usp=drivesdk",
        "embedLink": "https://docs.google.com/document/d/1rwG68SWkLBBKuriYDJ5QDYbs-MECGNJLVoXwx9bvxKU/preview",
        "iconLink": "https://ssl.gstatic.com/docs/doclist/images/icon_11_document_list.png",
        "thumbnailLink": "https://docs.google.com/feeds/vt?gd=true&id=1rwG68SWkLBBKuriYDJ5QDYbs-MECGNJLVoXwx9bvxKU&v=9&s=AMedNnoAAAAAUjfaHDwA6CS_X9xsYODWaaBhvU7ASNbC&sz=s220",
        "title": "Doc1",
        "mimeType": "application/vnd.google-apps.document",
        "labels": {
            "starred": false,
            "hidden": false,
            "trashed": false,
            "restricted": false,
            "viewed": true
        },
        "createdDate": "2013-09-16T03:14:03.510Z",
        "modifiedDate": "2013-09-17T02:04:48.535Z",
        "modifiedByMeDate": "2013-09-17T02:04:48.535Z",
        "lastViewedByMeDate": "2013-09-17T02:04:48.535Z",
        "parents": [
            {
                "kind": "drive#parentReference",
                "id": "0BwQ-i_0r4A6gc0tHZDBkcGNocW8",
                "selfLink": "https://www.googleapis.com/drive/v2/files/1rwG68SWkLBBKuriYDJ5QDYbs-MECGNJLVoXwx9bvxKU/parents/0BwQ-i_0r4A6gc0tHZDBkcGNocW8",
                "parentLink": "https://www.googleapis.com/drive/v2/files/0BwQ-i_0r4A6gc0tHZDBkcGNocW8",
                "isRoot": false
            }
        ],
        "exportLinks": {
            "application/vnd.openxmlformats-officedocument.wordprocessingml.document": "https://docs.google.com/feeds/download/documents/export/Export?id=1rwG68SWkLBBKuriYDJ5QDYbs-MECGNJLVoXwx9bvxKU&exportFormat=docx",
            "application/vnd.oasis.opendocument.text": "https://docs.google.com/feeds/download/documents/export/Export?id=1rwG68SWkLBBKuriYDJ5QDYbs-MECGNJLVoXwx9bvxKU&exportFormat=odt",
            "text/html": "https://docs.google.com/feeds/download/documents/export/Export?id=1rwG68SWkLBBKuriYDJ5QDYbs-MECGNJLVoXwx9bvxKU&exportFormat=html",
            "application/rtf": "https://docs.google.com/feeds/download/documents/export/Export?id=1rwG68SWkLBBKuriYDJ5QDYbs-MECGNJLVoXwx9bvxKU&exportFormat=rtf",
            "text/plain": "https://docs.google.com/feeds/download/documents/export/Export?id=1rwG68SWkLBBKuriYDJ5QDYbs-MECGNJLVoXwx9bvxKU&exportFormat=txt",
            "application/pdf": "https://docs.google.com/feeds/download/documents/export/Export?id=1rwG68SWkLBBKuriYDJ5QDYbs-MECGNJLVoXwx9bvxKU&exportFormat=pdf"
        },
        "userPermission": {
            "kind": "drive#permission",
            "etag": "\"PA40KOhMf9e-1Hypww_TkG8doNA/gdRrbLQc9UKV8SPw9O-AHGvxtcY\"",
            "id": "me",
            "selfLink": "https://www.googleapis.com/drive/v2/files/1rwG68SWkLBBKuriYDJ5QDYbs-MECGNJLVoXwx9bvxKU/permissions/me",
            "role": "owner",
            "type": "user"
        },
        "quotaBytesUsed": "0",
        "ownerNames": [
            "Aldo Bucchi"
        ],
        "owners": [
            {
                "kind": "drive#user",
                "displayName": "Aldo Bucchi",
                "picture": {
                    "url": "https://lh4.googleusercontent.com/-ES6y76MOMEA/AAAAAAAAAAI/AAAAAAAAAdc/ujpo7eyYrXw/s64/photo.jpg"
                },
                "isAuthenticatedUser": true,
                "permissionId": "00380833599378862546"
            }
        ],
        "lastModifyingUserName": "Aldo Bucchi",
        "lastModifyingUser": {
            "kind": "drive#user",
            "displayName": "Aldo Bucchi",
            "picture": {
                "url": "https://lh4.googleusercontent.com/-ES6y76MOMEA/AAAAAAAAAAI/AAAAAAAAAdc/ujpo7eyYrXw/s64/photo.jpg"
            },
            "isAuthenticatedUser": true,
            "permissionId": "00380833599378862546"
        },
        "editable": true,
        "copyable": true,
        "writersCanShare": true,
        "shared": true,
        "appDataContents": false,
        "__html": "<html><head><title>Doc1</title><meta content=\"text/html; charset=UTF-8\" http-equiv=\"content-type\"><style type=\"text/css\">ol{margin:0;padding:0}.c5{max-width:468pt;background-color:#ffffff;padding:72pt 72pt 72pt 72pt}.c4{color:inherit;text-decoration:inherit}.c0{color:#1155cc;text-decoration:underline}.c2{height:11pt}.c3{color:#ff0000}.c1{direction:ltr}.title{padding-top:0pt;line-height:1.15;text-align:left;color:#000000;font-size:21pt;font-family:\"Trebuchet MS\";padding-bottom:0pt}.subtitle{padding-top:0pt;line-height:1.15;text-align:left;color:#666666;font-style:italic;font-size:13pt;font-family:\"Trebuchet MS\";padding-bottom:10pt}li{color:#000000;font-size:11pt;font-family:\"Arial\"}p{color:#000000;font-size:11pt;margin:0;font-family:\"Arial\"}h1{padding-top:10pt;line-height:1.15;text-align:left;color:#000000;font-size:16pt;font-family:\"Trebuchet MS\";padding-bottom:0pt}h2{padding-top:10pt;line-height:1.15;text-align:left;color:#000000;font-size:13pt;font-family:\"Trebuchet MS\";font-weight:bold;padding-bottom:0pt}h3{padding-top:8pt;line-height:1.15;text-align:left;color:#666666;font-size:12pt;font-family:\"Trebuchet MS\";font-weight:bold;padding-bottom:0pt}h4{padding-top:8pt;line-height:1.15;text-align:left;color:#666666;font-size:11pt;text-decoration:underline;font-family:\"Trebuchet MS\";padding-bottom:0pt}h5{padding-top:8pt;line-height:1.15;text-align:left;color:#666666;font-size:11pt;font-family:\"Trebuchet MS\";padding-bottom:0pt}h6{padding-top:8pt;line-height:1.15;text-align:left;color:#666666;font-style:italic;font-size:11pt;font-family:\"Trebuchet MS\";padding-bottom:0pt}</style></head><body class=\"c5\"><p class=\"c1\"><span>The blog loads a list of files</span></p><p class=\"c2 c1\"><span></span></p><p class=\"c2 c1\"><span></span></p><p class=\"c2 c1\"><span></span></p><p class=\"c1\"><span>0BwQ-i_0r4A6gc0tHZDBkcGNocW8</span></p><p class=\"c2 c1\"><span></span></p><p class=\"c2 c1\"><span></span></p><p class=\"c1\"><span>Test </span><span class=\"c3\">content</span></p><p class=\"c2 c1\"><span></span></p><p class=\"c2 c1\"><span></span></p><p class=\"c2 c1\"><span></span></p><p class=\"c1 c2\"><span></span></p><p class=\"c2 c1\"><span></span></p><p class=\"c2 c1\"><span></span></p><p class=\"c1\"><span class=\"c0\"><a class=\"c4\" href=\"https://developers.google.com/drive/v2/reference/files/get\">https://developers.google.com/drive/v2/reference/files/get</a></span></p><p class=\"c2 c1\"><span></span></p><p class=\"c2 c1\"><span></span></p><p class=\"c1\"><span>Can I list the contents of a folder?</span></p><p class=\"c2 c1\"><span></span></p><p class=\"c2 c1\"><span></span></p><p class=\"c2 c1\"><span></span></p><p class=\"c2 c1\"><span></span></p><p class=\"c2 c1\"><span></span></p><p class=\"c1\"><img height=\"800\" src=\"https://lh4.googleusercontent.com/7FlrpToMSSFwwAHNY4VTcApd0iMhiVLpsC4CgFQADddvdOjLF-ojmWnrqs437R5n18qQHIFfAB_tkI5hroUuGfoU-Bwp6JldJ6HrIBJC9yc8sC9RQg\" width=\"600\"></p><p class=\"c2 c1\"><span></span></p><p class=\"c2 c1\"><span></span></p><p class=\"c2 c1\"><span></span></p><p class=\"c1\"><img height=\"264\" src=\"https://docs.google.com/drawings/image?id=sv1hn1IZKTpIzBYtdt3USPQ&amp;rev=1&amp;h=264&amp;w=409&amp;ac=1\" width=\"409\"></p><p class=\"c2 c1\"><span></span></p></body></html>"
    }
]
###