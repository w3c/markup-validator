// prefill validator "direct input" form with basic document structure


var text_xhtml1 = '<?xml version="1.0" encoding="utf-8"?>\n<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"\n    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">\n <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">\n <head>\n   <title>I AM YOUR DOCUMENT TITLE REPLACE ME</title>\n   <meta http-equiv="content-type" content="text/html;charset=utf-8" />\n   <meta http-equiv="Content-Style-Type" content="text/css" />\n </head>\n <body>\n   <p>… Your HTML content here …</p>\n</body>\n </html>';

var text_html401 = '<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN"\n   "http://www.w3.org/TR/html4/strict.dtd">\n<html>\n<head>\n   <title>I AM YOUR DOCUMENT TITLE REPLACE ME</title>\n   <meta http-equiv="content-type" content="text/html;charset=utf-8">\n   <meta http-equiv="Content-Style-Type" content="text/css">\n</head>\n<body>\n   <p>… Your HTML content here …</p>\n</body>\n</html>';

function prefill_document(textarea_id, doctype) {
    var txtarea = document.getElementById(textarea_id);
    // first we remove all children nodes
    if (doctype == "html401") {
        txtarea.value = text_html401;
    }
    else {
        txtarea.value = text_xhtml1;
    }
//    txtarea.select();
    txtarea.focus();
};