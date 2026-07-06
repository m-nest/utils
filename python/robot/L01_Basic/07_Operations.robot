*** Settings ***
Resource    ../common.resource

*** Test Cases ***

OP001 Get Supported Data Model
    ${out}=    USP Query    gsdm Device.
    Should Not Contain    ${out}    ERROR

OP002 Resolve Device
    ${out}=    USP Query    resolve Device.
    Should Not Contain    ${out}    ERROR

OP003 Dump DeviceInfo
    ${out}=    USP Query    dump Device.DeviceInfo
    Should Not Contain    ${out}    ERROR
