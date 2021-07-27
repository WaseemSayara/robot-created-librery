*** Settings ***
Library                ../SSH_library/TestSSH.py

*** Variables ***
${HOST}                127.0.0.1
${USERNAME}            waseem
${PASSWORD}            123123
${NET1}                inet 10.0.2.15
${NET2}                netmask 255.255.255.0
${NET3}                broadcast 10.0.2.255

*** Test Cases ***
Check Hostname
    ${HOSTNAME}=     Get Hostname
    Log              ${HOSTNAME}
    Should Be Equal  ${HOSTNAME}  waseem-ahmad

Check Network
    ${NETWORK}=      Execute Command  ifconfig
    Log              ${NETWORK}
    Should Contain   ${NETWORK}  ${NET1}
    Should Contain   ${NETWORK}  ${NET2}
    Should Contain   ${NETWORK}  ${NET3}

Make Directory
    Create Directory    directory1
    Directory Should Exist  directory1

Make File
    Create File        file12.txt   my name is waseem   .
    File Should Exist  file12.txt

Put File
    Put File        ./file123.txt   .
    File Should Exist  file123.txt

Get File
    Get File        ./file11.txt   .

Copy Directory To Virtual
    Put Directory    .\\dir1  .
    ${NUM_OF_FILES}  Execute Command   ls dir1 | wc -l
    Should Be Equal As Integers  ${NUM_OF_FILES}  3

Remove File From Virtual
    Execute Command  rm dir1/file2.txt
    ${NUM_OF_FILES}  Execute Command   ls dir1 | wc -l
    Should Be Equal As Integers  ${NUM_OF_FILES}  2

Empty Directory
    Remove Files In Directory   dir1
    ${NUM_OF_FILES}  Execute Command   ls dir1 | wc -l
    Should Be Equal As Integers  ${NUM_OF_FILES}  0
