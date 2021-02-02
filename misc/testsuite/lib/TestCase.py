#!/usr/bin/env python
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
from random import choice
from ValidatorsAPIs import W3CValidatorHTTP
import xml.etree.cElementTree as ET

class ValidatorTestCase(unittest.TestCase):
    """Atomic Test Case for validator test suite"""
    def __init__(self, title=None, description=None, docURI=None, expectResults=None, checker=None):
        super(ValidatorTestCase, self).__init()
        if docURI:
            self.docURI = docURI
        else: 
            self.docURI = ""
        if description:
            self.description = description
        else:
            self.description = u""
        if title:
            self.title = title
        else:
            self.title = self.description
        if isinstance(expectResults, dict):
            self.expectResults = expectResults
        else:
            self.expectResults = dict()
        if checker != None:
            self.checker = checker
        else:
            self.checker = W3CValidatorHTTP()
        self._testMethodName= "run_testcase"

    def shortDescription(self):
        return self.title

    def run_testcase(self):
        """Run a validator test case
        We first remove irrelevant result keys in the validation results,
        and compare that to the expected results
        """
        (res, err) = self.checker.call_check(self.docURI)
        self.assertEqual(err, None)
        results = self.checker.parse_response(res)
        results_filtered = dict()
        for result_key in self.expectResults.iterkeys():
            if results.has_key(result_key):
                # this is an interesting hack to state that we expect 
                #   at least some number of errors (or warnings) but don't specify how many
                if self.expectResults[result_key] == "yes" and int(results[result_key]) > 0:
                    results[result_key] = "yes"
                results_filtered[result_key] = results[result_key]
            
        self.assertEqual(results_filtered, self.expectResults)

class ValidatorTestSuite:
    """A Validator test suite is a flattened tree of test collections and test cases"""
    def __init__(self, checker=None):
        if checker == None:
            self.checker = None # leave undefined
        else:
            self.checker = checker
        self.collections= list()

    def randomId(self):
        """
        return a randomized identifier for test collections or cases that do not have one
        Kudos to http://aspn.activestate.com/ASPN/Cookbook/Python/Recipe/526619
        """
        return ''.join([choice('bcdfghklmnprstvw')+choice('aeiou') for i in range(4)])

    def readTestSuiteFile(self, test_file):
        test_file_handle = open(test_file, 'r')
        try:
            tree = ET.parse(test_file_handle)
            ts_node = tree.getroot()
        except SyntaxError, v:
            raise v
        return ts_node

    def readTestCollection(self, collection_node, level=None):
        """read a test collection from a given ElementTree collection node
        The collection can have test cases as children (which will be read and returned)"""
        if level == None:
            level = 0
        testcollection = ValidatorTestCollection()
        testcollection.level = level
        if collection_node.attrib.has_key("id"):
            testcollection.collection_id = collection_node.attrib["id"]
        else:
            testcollection.collection_id = self.randomId()
        
        for child_node in collection_node.getchildren():
            if child_node.tag == "{http://purl.org/dc/elements/1.1/}title":
                testcollection.title = child_node.text
            if child_node.tag == "test":
                try:
                    testcase = self.readTestCase(child_node)
                except:
                    testcase = None
                if testcase != None:
                    testcollection.addTest(testcase)
        if collection_node.tag == "collection":
            self.collections.append(testcollection)
        for child_node in collection_node.getchildren():
            if child_node.tag == "collection":
                self.readTestCollection(child_node, level=level+1)


    def readTestCase(self, testcase_node):
        """read metadata for a test case from an elementTree testcase node"""
        try:
            title = testcase_node.findtext(".//{http://purl.org/dc/elements/1.1/}title")
        except:
            title = ""
        try:
            descr = testcase_node.findtext(".//{http://www.w3.org/1999/xhtml}p")
        except:
            descr = ""
        test_uri = ""
        test_uri = testcase_node.findtext(".//uri")
        expect_elt = testcase_node.find(".//expect")
        expected = dict()
        for child_expect in expect_elt.getchildren():
            expected[child_expect.tag] = child_expect.text
        case = ValidatorTestCase(title=title, description=descr, docURI=test_uri, expectResults=expected, checker=self.checker)
        return case

class ValidatorTestCollection(unittest.TestSuite):
    """subclassing the TestSuite from the unittest framework to add identifier and title"""
    def __init__(self):
        super(ValidatorTestCollection, self).__init__()
        self.collection_id = None
        self.level = None
        self.title = None
                    

class ValidatorTestCase_UT(unittest.TestCase):
    """Sanity Check for ValidatorTestCase classe"""
    def test_init_default(self):
        """Test initialization of a default ValidatorTestCase Object"""
        default_tc = ValidatorTestCase()
        self.assertEqual(
            [default_tc.title, default_tc.description, default_tc.docURI, default_tc.expectResults],
            [u'', u'', '', dict()]
        )

class ValidatorTestSuite_UT(unittest.TestCase):
    """Sanity Check for ValidatorTestSuite classe"""
    
    def getSamplefile(self, filename):
        libdir = os.path.dirname(os.path.abspath(__file__))
        sampledir = os.path.join(os.path.split(libdir)[0], "samples")
        samplefile = os.path.join(sampledir, filename)
        return samplefile
        
    def test_init_default(self):
        """Test initialization of a default ValidatorTestSuite Object"""
        default_ts = ValidatorTestSuite()
    
    def test_readTestSuiteFile(self):
        """Test reading a sample Test Suite file"""
        default_ts = ValidatorTestSuite()
        samplefile = self.getSamplefile("testsuite.xml")
        node = default_ts.readTestSuiteFile(samplefile)
        self.assertEquals(node.tag, "testsuite")
        
    def test_readTestCollection(self):
        """Test reading a sample test collection from a parsed test suite file"""
        default_ts = ValidatorTestSuite()
        samplefile = self.getSamplefile("collection.xml")
        node = default_ts.readTestSuiteFile(samplefile)
        default_ts.readTestCollection(node)
        self.assertEquals(len(default_ts.collections), 1)

    def test_readTestCollection_2(self):
        """Test parsing a sample test collection for its id and title"""
        default_ts = ValidatorTestSuite()
        samplefile = self.getSamplefile("collection.xml")
        node = default_ts.readTestSuiteFile(samplefile)
        default_ts.readTestCollection(node)
        self.assertEquals(
            [default_ts.collections[0].collection_id, default_ts.collections[0].title], 
            ["valid", "Valid Documents"])
    
    def test_readTestCase(self):
        """Test reading a test case from a parsed test suite file"""
        default_ts = ValidatorTestSuite()
        samplefile = self.getSamplefile("testcase.xml")
        node = default_ts.readTestSuiteFile(samplefile)
        default_ts.readTestCollection(node)
        self.assertEquals(default_ts.collections[0].countTestCases(), 1)

    def test_readTestCase_2(self):
        """Test reading a test case and check URI"""
        default_ts = ValidatorTestSuite()
        samplefile = self.getSamplefile("testcase.xml")
        node = default_ts.readTestSuiteFile(samplefile)
        default_ts.readTestCollection(node)
        self.assertEquals(default_ts.collections[0]._tests[0].docURI, "http://qa-dev.w3.org/wmvs/HEAD/dev/tests/html20.html")

    def test_readTestCase_3(self):
        """Test reading a test case and check description"""
        default_ts = ValidatorTestSuite()
        samplefile = self.getSamplefile("testcase.xml")
        node = default_ts.readTestSuiteFile(samplefile)
        default_ts.readTestCollection(node)
        self.assertEquals(default_ts.collections[0]._tests[0].description, "HTML 2.0")

    def test_readTestCase_4(self):
        """Test reading a test case and check description"""
        default_ts = ValidatorTestSuite()
        samplefile = self.getSamplefile("testcase.xml")
        node = default_ts.readTestSuiteFile(samplefile)
        default_ts.readTestCollection(node)
        self.assertEquals(default_ts.collections[0]._tests[0].shortDescription(), "HTML 2.0")
    def test_readTestCollection_recursive(self):
        """Test reading a sample test file with nested test collections - and count them"""
        default_ts = ValidatorTestSuite()
        samplefile = self.getSamplefile("collection_nested.xml")
        node = default_ts.readTestSuiteFile(samplefile)
        default_ts.readTestCollection(node)
        self.assertEquals(len(default_ts.collections), 2)

    def test_readTestCollection_recursive(self):
        """Test reading a sample test file with nested test collections - and check their order and title"""
        default_ts = ValidatorTestSuite()
        samplefile = self.getSamplefile("collection_nested.xml")
        node = default_ts.readTestSuiteFile(samplefile)
        default_ts.readTestCollection(node)
        self.assertEquals([default_ts.collections[0].title, default_ts.collections[1].title], 
        ["Valid Documents", "Very Valid Documents"] )


if __name__ == '__main__':
    unittest.main()
