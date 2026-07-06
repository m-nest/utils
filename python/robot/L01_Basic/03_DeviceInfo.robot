*** Settings ***
Resource    ../common.resource

*** Test Cases ***

D001 Serial Number
    ${out}=    USP Query    Device.DeviceInfo.SerialNumber?
    Should Contain    ${out}    Device.DeviceInfo.SerialNumber

D002 Manufacturer
    ${out}=    USP Query    Device.DeviceInfo.Manufacturer?
    Should Contain    ${out}    Manufacturer

D003 Manufacturer OUI
    ${out}=    USP Query    Device.DeviceInfo.ManufacturerOUI?
    Should Contain    ${out}    ManufacturerOUI

D004 Model Name
    ${out}=    USP Query    Device.DeviceInfo.ModelName?
    Should Contain    ${out}    ModelName

D005 Software Version
    ${out}=    USP Query    Device.DeviceInfo.SoftwareVersion?
    Should Contain    ${out}    SoftwareVersion

D006 Hardware Version
    ${out}=    USP Query    Device.DeviceInfo.HardwareVersion?
    Should Contain    ${out}    HardwareVersion

D007 UpTime
    ${out}=    USP Query    Device.DeviceInfo.UpTime?
    Should Contain    ${out}    UpTime

D008 Product Class
    ${out}=    USP Query    Device.DeviceInfo.ProductClass?
    Should Contain    ${out}    ProductClass
