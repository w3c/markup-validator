#!/usr/bin/env python2
# encoding: utf-8
"""
link-testsuite/harness/run.py
Run or Generate test suite for link checkers

Created by olivier Thereaux on 2008-01-23.
Copyright (c) 2008 W3C. Licensed under the W3C Software License
http://www.w3.org/Consortium/Legal/copyright-software
"""

import os
import sys
import glob
import getopt
import unittest
import re

basedir = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(basedir, "lib"))
from ValidatorsAPIs import W3CValidatorHTTP, W3CValidatorHTTP_test
from TestCase import ValidatorTestCase, ValidatorTestSuite, ValidatorTestCase_UT, ValidatorTestSuite_UT
from Documentation import Documentation
help_message = '''

Run or Generate test suite for markup validator(s)

Usage: harness.py [options] [run|sanity|doc]
    Options: 
        -h, --help: this manual you are reading
        -v, --verbose: verbose output
        -q, --quiet: suppress all output except errors
        --validator_uri: use a specific validator instance
          e.g https://validator.w3.org/check
        --id=collection_id: run a single collection from the test suite
          In run mode only, this filters the test suite and uses only
          a collection identified with id="..." 
          with its children tests and collections
    
    Modes:
        run: run the test suite 
        sanity: check that this code is still working 
            useful after using test cases or modifying code
        list: list the available test collections
        doc: generate an HTML index of the test cases
        (to be saved in ../../htdocs/dev/tests/index.html)
'''

class Usage(Exception):
    def __init__(self, msg):
        self.msg = msg

class TestRun(unittest.TestCase):
    def test_1_1_readTestCase(self):
        """Opening and parsing a Test Case"""
        basedir = getBaseDir()
        test_file = os.path.join(basedir, 'sample', 'collection_1.xml')


def main(argv=None):
    collection_id = None
    checker = None
    check_URI = None
    verbose=1
    if argv is None:
        argv = sys.argv
    try:
        try:
            opts, args = getopt.getopt(argv[1:], "ho:vq", ["help", "verbose", "quiet", "id=", "validator=", "validator_uri="])
            for (opt, value) in opts:
                if opt == "h" or opt == "--help":
                    raise Usage(help_message)
        except getopt.GetoptError as err:
            raise Usage(err)
    
        # option processing
        for option, value in opts:
            if option == "-v" or opt == "--verbose":
                verbose = 2
            if option == "-q" or opt == "--quiet":
                verbose = 0
            if option in ("-h", "--help"):
                raise Usage(help_message)
            if option in ("-o", "--output"):
                output = value
            if option == "--id":
                collection_id = value
            if option == "--validator":
                pass # TODO add selection of different validators
            if option == "--validator_uri":
                check_URI = value

        if len(args) == 0:
            raise Usage(help_message)
    
    except Usage as err:
        sys.stderr.write("%s: %s\n\t for help use --help\n" % \
                             (sys.argv[0].split("/")[-1], str(err.msg)))
        return 2

        
    if args[0] == "run":
        if checker == None:
            checker = W3CValidatorHTTP(check_URI=check_URI)
        else:
            pass # TODO add selection of different validators
        testsuite = buildTestSuite(collection_id=collection_id, checker=checker)
        runTestSuite(testsuite, verbose)
        
    elif args[0] == "sanity":
        suite1 = unittest.TestLoader().loadTestsFromTestCase(ValidatorTestCase_UT)
        suite2 = unittest.TestLoader().loadTestsFromTestCase(ValidatorTestSuite_UT)
        suite3 = unittest.TestLoader().loadTestsFromTestCase(TestRun)
        suite4 = unittest.TestLoader().loadTestsFromTestCase(W3CValidatorHTTP_test)
        suite = unittest.TestSuite([suite1, suite2, suite3, suite4])
        unittest.TextTestRunner(verbosity=verbose).run(suite)

    elif args[0] == "list":
        listCollections()

        
    elif args[0] == "doc":
        generateIndex()

def getBaseDir():
    basedir = os.path.dirname(os.path.abspath(__file__))
    return basedir
        
def buildTestSuite(ts_file=None, collection_id=None, checker=None):
    """read test suite XML file and build it"""
    test_suite = ValidatorTestSuite(checker=checker)
    if ts_file == None:
        basedir = getBaseDir()
        ts_file = os.path.join(basedir, 'catalog.xml')
    parsed_ts = test_suite.readTestSuiteFile(ts_file)
    filtered_ts = parsed_ts
    if collection_id != None:
        for collection in parsed_ts.findall(".//collection"):
            if collection.attrib.has_key("id"):
                if collection.attrib["id"] == collection_id: # this is the one we want, we keep this and its children
                    filtered_ts = collection
    test_suite.readTestCollection(filtered_ts)
    return test_suite

def runTestSuite(testsuite, verbose):
    """Describe each test collection in the test suite and run them"""
    for collection in testsuite.collections:
        print ("*** Running Collection #%s: %s" % (collection.collection_id, collection.title))
        if collection.countTestCases() > 0:
            unittest.TextTestRunner(verbosity=verbose).run(collection)

def listCollections():
    index = Documentation('list')
    test_suite = buildTestSuite()
    index.addTestSuite(test_suite)
    print (index.generate(template_path=os.path.join(basedir, "templates")).encode('utf-8'))


def generateIndex():
    index = Documentation('index')
    test_suite = buildTestSuite()
    index.addTestSuite(test_suite)
    print (index.generate(template_path=os.path.join(basedir, "templates")).encode('utf-8'))



if __name__ == "__main__":
    sys.exit(main())
