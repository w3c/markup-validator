#!/usr/bin/env python2
# encoding: utf-8
"""
W3CLikCheckerClient.py
Simple client lib to interact with the W3C Link Checker

Created by olivier Thereaux on 2008-01-22.
Copyright (c) 2008 W3C. Licensed under the W3C Software License
http://www.w3.org/Consortium/Legal/copyright-software
"""

import sys
import os
import re
import unittest
import urllib, urllib2
import xml.etree.cElementTree as ET

class W3CValidatorHTTP:
    """Fetch and parse results from a validator using the W3C Validator SOAP API"""
    def __init__(self, check_URI=None):
        if check_URI != None:
            self.check_URI= check_URI+'?uri=%(URI)s'
        else:
            self.check_URI= 'http://qa-dev.w3.org/wmvs/HEAD/check?uri=%(URI)s'

        
    def call_check(self, TC_uri):
        """Make a request to the checker and store its response"""
        data = urllib.quote(TC_uri, "")
        final_checker_URI = self.check_URI % {"URI": data }
        try:
            response = urllib2.urlopen(final_checker_URI)
        except (urllib2.HTTPError, urllib2.URLError) as exc:
            return (None, str(exc) + ": " + final_checker_URI)
        return (response, None)

    def parse_response(self, response):
        """Parse a W3C Markup Validator Response via its HTTP headers"""
        response_headers = response.info()
        results = dict()
        results["NumErrors"] = response_headers.getheader("x-w3c-validator-errors")
        results["NumWarnings"] = response_headers.getheader("x-w3c-validator-warnings")
        results["Validity"] = response_headers.getheader("x-w3c-validator-status")
        if results["Validity"] == "Valid":
            results["Validity"] = "Pass"
        if results["Validity"] == "Invalid":
            results["Validity"] = "Fail"
        return results
        
class W3CValidatorHTTP_test(unittest.TestCase):
    """Unit testing for sanity of W3CValidatorAPI code"""
    def setUp(self):
        pass
    
    def test_init(self):
        """Test initializing a client to W3C validator HTTP results"""
        default_checker = W3CValidatorHTTP()
        self.assertEqual(default_checker.check_URI, 'http://qa-dev.w3.org/wmvs/HEAD/check?uri=%(URI)s')
    
    def test_contact_default(self):
        """Test Contacting the default validator instance"""
        default_checker = W3CValidatorHTTP()
        (res, err) = default_checker.call_check("http://www.w3.org")
        self.assertEqual(err, None)
        self.assertNotEqual(res, None)

    def test_contact_vwo(self):
        """Test Contacting the main W3C validator instance"""
        default_checker = W3CValidatorHTTP("https://validator.w3.org/check?uri=%(URI)s")
        (res, err) = default_checker.call_check("http://www.w3.org")
        self.assertEqual(err, None)
        self.assertNotEqual(res, None)

    def test_parse_response(self):
        """Test parsing response from default validator instance"""
        default_checker = W3CValidatorHTTP()
        (res, err) = default_checker.call_check("http://www.w3.org")
        self.assertEqual(err, None)
        results = default_checker.parse_response(res)
        self.assert_(isinstance(results,dict))

    def test_parse_response_invalid(self):
        """Test parsing response for a known invalid resource"""
        default_checker = W3CValidatorHTTP()
        (res, err) = default_checker.call_check("http://qa-dev.w3.org/wmvs/HEAD/dev/tests/xhtml1-bogus-element.html")
        self.assertEqual(err, None)
        results = default_checker.parse_response(res)
        self.assertNotEquals(results["NumErrors"], 0)

    def test_parse_response_valid(self):
        """Test parsing response for a known valid HTML resource"""
        default_checker = W3CValidatorHTTP()
        (res, err) = default_checker.call_check("http://qa-dev.w3.org/wmvs/HEAD/dev/tests/html20.html")
        self.assertEqual(err, None)
        results = default_checker.parse_response(res)
        self.assertNotEquals([results["NumErrors"], results["Validity"]], [0, "Valid"])

if __name__ == '__main__':
    unittest.main()
