*** Settings ***
Library                ../SSH_library/TestSSH.py
Resource               ../Resources/variables.robot

*** Test Cases ***
Check Hostname
    ${HOSTNAME}=     Get Hostname
    Log              ${HOSTNAME}
    Should Be Equal  ${HOSTNAME}  waseem-ahmad

Check Network
    ${NETWORK}=      Get Network Configurations
    Log              ${NETWORK}
    Should Contain   ${NETWORK}  ${NET1}
    Should Contain   ${NETWORK}  ${NET2}
    Should Contain   ${NETWORK}  ${NET3}

Make Directory
    Create Directory    directory3
    SHOULD EXIST        directory3


Make File
    Create File        dir1/file12.txt   my name is waseem   .
    Should Exist       dir1/file12.txt

Put File
    Put File        ./Resources/to_send_file.txt   from_local_file.txt
    Should Exist  from_local_file.txt

Get File
    Get File        file11.txt   ./fetched_file.txt

Remove File From Virtual
    Create File        file2.txt   my name is waseem   dir1
    ${NUM_OF_FILES_BEFORE}   Get Count Of Files  dir1
    Remove File      dir1/file2.txt
    ${NUM_OF_FILES_AFTER}   Get Count Of Files  dir1
    Evaluate  ${NUM_OF_FILES_AFTER} < ${NUM_OF_FILES_BEFORE}

Empty Directory
    Create File        file1.txt   my name is waseem   directory1
    Create File        file2.txt   my name is waseem   directory1
    Remove Files In Directory   directory1
    ${NUM_OF_FILES}    Get Count Of Files  directory1
    Should Be Equal As Integers  ${NUM_OF_FILES}  0
